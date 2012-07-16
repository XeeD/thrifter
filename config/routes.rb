Thrifter::Application.routes.draw do

  #Admin backend
  namespace :admin do
    root :to => "admin#index"
    resources :brands, :path => "znacky", :path_names => {:new => "nova", :edit => "editace"}
  end
end
