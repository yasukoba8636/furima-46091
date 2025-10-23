Rails.application.routes.draw do
  # Root URL
  root to: 'orders#index'

  # Orders の一覧・作成
  resources :orders, only: [:index, :create]

  # ヘルスチェック用ルート
  get 'up', to: 'rails/health#show', as: :rails_health_check
end
