Rails.application.routes.draw do
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    root to: "homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
     #顧客の一覧・詳細・編集・更新

    resources :comments, only: [:index, :destroy]
    #顧客コメントの一覧・削除

    #resources :sessions, only: [:new, :create, :destroy]
     #管理者のログイン・ログアウト

    #get 'sessions/new'
    #get 'sessions/create'
    #get 'sessions/destroy'
  end

  scope module: :public do

    root to: 'homes#top'

    get "/homes/about" => "homes#about", as: "about"

    resources :recipes, only: [:new, :create, :show, :index, :edit, :update] do
     #レシピの投稿・詳細・一覧・編集・更新

      resources :bookmarks, only: [:create, :destroy]
       #ブックマークの追加・削除
       
      resources :comments, only: [:create, :destroy]
      #コメントの追加・削除

    end

    resources :tags, only: [:create, :edit, :update, :destroy]
     #タグの作成・編集・更新・削除

    get 'customers/mypage' => 'customers#show'
    # 顧客のマイページ

    get 'customers/information/edit' => 'customers#edit'
    # 顧客の会員登録情報編集

    patch 'customers/information/update' => 'customers#update'
    # 顧客の登録情報更新

    get 'customers/check' => 'customers#check', as: 'customers_check'
    # 顧客の退会確認画面

    get 'customers/withdrawal' => 'customers#withdrawal', as: 'customers_withdrawal'
    # 顧客の退会処理(ステータスの更新) patchではない？

    get "search_tag" => "recipes#search_tag"
    # タグの検索で使用する

    get "search" => "searches#search"

    #resources :customers, only: [:show, :edit, :update, :check, :withdrawal]
     #顧客情報の詳細・編集・退会の確認画面・退会

    #resources :sessions, only: [:new, :create, :destroy]
     #顧客のログイン・新規登録・ログアウト

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
