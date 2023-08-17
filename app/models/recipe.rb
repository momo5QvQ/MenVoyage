class Recipe < ApplicationRecord
  has_one_attached :image

  belongs_to :customer
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  def get_image #画像がない時の処理
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  # タグ付けの新規投稿用メソッド
  def save_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end

end

  # タグ付けの更新用メソッド
  # def update_tags(latest_tags)
  #   if self.tags.empty?
  #     # 既存のタグがなかったら追加だけ行う
  #     latest_tags.each do |latest_tag|
  #       self.tags.find_or_create_by(name: latest_tag)
  #     end
  #   elsif latest_tags.empty?
  #     # 更新対象のタグがなかったら既存のタグをすべて削除
  #     # 既に保存がされていたら既に登録されているタグの内容を削除
  #     self.tags.each do |tag|
  #       self.tags.delete(tag)
  #     end
  #   else
  #     # 既存のタグも更新対象のタグもある場合は差分更新
  #     current_tags = self.tags.pluck(:name)
  #     #左を起点に引き算をする
  #     #　　　　　　 b             a b c
  #     old_tags = current_tags - latest_tags
  #     #一致したものを取り出す
  #     # a c       a b c            b
  #     new_tags = latest_tags - current_tags

  #     # a  c
  #     old_tags.each do |old_tag|
  #       tag = self.tags.find_by(name: old_tag)
  #       self.tags.delete(tag) if tag.present?
  #     end


  #     new_tags.each do |new_tag|
  #       # b
  #       self.tags.find_or_create_by(name: new_tag)
  #       # self.tags << new_tags
  #     end
  #   end

  # end

