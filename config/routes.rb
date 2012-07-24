Thrifter::Application.routes.draw do

  #Admin backend
  namespace :admin do
    root :to => "admin#homepage"

    resources :brands,     path: "znacky",    path_names: {new: "nova", edit: "editace"}, except: :show
    resources :products,   path: "produkty",  path_names: {new: "novy", edit: "editace"}, except: :show
    resources :categories, path: "kategorie", path_names: {new: "nova", edit: "editace"}, except: :show
    resources :param_templates, path: "sablony-parametru", path_names: {new: "nova", edit: "editace"}
    resources :shops, path: "obchody", path_names: {new: "novy", edit: "editace"}, except: :show
  end
end
