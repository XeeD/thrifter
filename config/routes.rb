Thrifter::Application.routes.draw do

  #Admin backend
  namespace :admin do
    root :to => "admin#homepage"

    resources :brands, path: "znacky", path_names: {new: "nova", edit: "editace"}, except: :show
    resources :products, path: "produkty", path_names: {new: "novy", edit: "editace"}, except: :show
    resources :categories, path: "kategorie", path_names: {new: "nova", edit: "editace"}, except: :show
    resources :param_templates, path: "sablony-parametru", path_names: {new: "nova", edit: "editace"} do
      resources :groups, path: "skupiny", path_names: {new: "nova", edit: "editace"}, :controller => "param_groups"
    end
    resources :shops, path: "obchody", path_names: {new: "novy", edit: "editace"}, except: :show do
      member do
        get :deletion_confirmation
      end
    end
  end
end
