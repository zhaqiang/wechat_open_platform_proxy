WechatOpenPlatformProxy::Engine.routes.draw do
  get "welcome/index"
  root "welcome#index"

  resources :third_party_platforms, param: :uid, only: [:index, :show] do
    scope module: :third_party_platforms do
      resources :authorization_events, only: [:create]
    end

    resource :official_account_authorization, only: [:new, :show] do
      get :account_info, defaults: {format: :json}
    end

    resources :official_accounts, param: :app_id, only: [:index, :show] do
      scope module: :official_accounts do
        resources :messages, only: [:create]
        resources :templated_messages, only: [:create], defaults: {format: :json}
        resources :qr_codes, only: [:create], defaults: {format: :json}
        get "jssdk/wx_config", defaults: {format: :json}
        get "jssdk/card_wx_config", defaults: {format: :json}
        get "jssdk/card_sign", defaults: {format: :json}
      end

      resource :wechat_user_authorization, only: [:new, :show] do
        get :base_info, :user_info, defaults: {format: :json}
      end

      resources :wechat_users, param: :open_id, only: [:show]
    end
  end
end
