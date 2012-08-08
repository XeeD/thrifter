Thrifter::Application.routes.draw do

  # Admin backend
  namespace :admin do
    root :to => "admin#homepage"

    resources :brands, path: "znacky", path_names: {new: "nova", edit: "editace"}, except: :show

    resources :products,
              path: "produkty",
              path_names: {new: "novy", edit: "editace"},
              except: :show do
      resources :photos, except: [:show], controller: "product_photos", path: "fotky" do
        collection { post :sort }
      end
      resources :params, controller: "product_param_items", path: "parametry"
      resources :categorizations, controller: "product_categorizations", only: [:index, :destroy] do
        collection do
          post :add_shop_to
          get :edit_alternative
          put :update_alternative
        end
        member do
          get :edit_preferred
        end
      end
    end

    resources :param_templates, path: "sablony-parametru", path_names: {new: "nova", edit: "editace"} do
      resources :groups, path: "skupiny", path_names: {new: "nova", edit: "editace"}, controller: "param_groups", except: :index do
        collection { post :sort }
      end
      resources :param_items, path: "parametry", path_names: {new: "novy", edit: "editace"}
    end

    resources :shops, path: "obchody", path_names: {new: "novy", edit: "editace"}, except: :show do
      member do
        get :deletion_confirmation
      end

      resources :categories, path: "kategorie", path_names: {new: "nova", edit: "editace"}, except: :show
    end

    # Admistation of categories - choose which shop's categories to administrate
    match "kategorie/vyber-obchodu" => "categories#choose_shop", as: "categories"
  end
end