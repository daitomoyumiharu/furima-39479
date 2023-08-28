Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"

  resources :items do
    #商品(item)が無いと実行されない為itemsにネスト
    #index.html.erbと紐付いている為indexを定義
    resources :orders, only: [:index, :create]
  end
end
