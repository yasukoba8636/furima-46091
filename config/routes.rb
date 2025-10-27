Rails.application.routes.draw do
  devise_for :users
  # Root URL
  root to: 'items#index'  # トップページ＝商品一覧
  resources :items

  # Orders の一覧・作成
  resources :items do
    resources :orders, only: [:index, :create]
  end

  # ヘルスチェック用ルート
  get 'up', to: 'rails/health#show', as: :rails_health_check
end
