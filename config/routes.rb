Rails.application.routes.draw do

  mount S3Relay::Engine => "/s3_relay"

  resources :things, only: [:index, :new, :create, :show, :edit, :update]

  root "things#index"

end
