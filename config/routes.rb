Thrifter::Application.routes.draw do

  #Admin backend
  namespace :admin do
    root :to => "admin#index"
    resources :brands#, :path => "znacky"
  end
end
