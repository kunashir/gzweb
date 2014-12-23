Inlook::Application.routes.draw do

  devise_for :users, path: '/', controllers: { sessions: "sessions" }

  get "static_pages/test"
  get 'task_info' => 'task_info#show'
  post 'task_info/refresh' => 'task_info#refresh', constraints: { format: :json }, defaults: { format: :json }
  get 'task_info/:kind' => 'task_info#tasks'
  post 'task_info/:id/perform' => 'task_info#perform', constraints: { format: :json }, defaults: { format: :json }
  get 'task_info/:id/data' => 'task_info#data', constraints: { format: :json }, defaults: { format: :json }
  get 'task_info/:id/history' => 'task_info#history', constraints: { format: :json }, defaults: { format: :json }
  get 'task_info/:id/assignment_tree' => 'task_info#assignment_tree'
  get 'assignments/:id/details' => 'assignment#details', constraints: { format: :json }, defaults: { format: :json }
  get 'wftasks/:id/details' => 'w_f_task#details', constraints: { format: :json }, defaults: { format: :json }
  root 'main#index'

  resources :tasks, only: [ :new, :create, :show ]
  get 'employees/find' => 'employees#find', constraints: { format: :json }, defaults: { format: :json }
  get 'file/icon' => 'main#file_icon'
  get 'file/:id' => 'main#file', as: :file
  get 'file_pdf/:id' => 'main#file_pdf', as: :file_pdf
  post 'file' => 'main#upload', as: :upload_file
  get 'employees/:id/photo' => 'employees#photo', as: :employee_photo
  get 'refresh_all' => 'main#refresh_all', as: :refresh_all
  
  devise_for :admin, path: '/admin', controllers: { sessions: "admin_sessions" }
  get 'admin' => 'admin#main'
  get 'admin/user_details' => 'admin#user_details', as: :admin_user_details
  post 'admin/add_user' => 'admin#add_user', as: :admin_add_user
  delete 'admin/remove_user' => 'admin#remove_user', as: :admin_remove_user
  post 'admin/refresh_user' => 'admin#refresh_user', as: :admin_refresh_user
  post 'admin/set_user_password' => 'admin#set_user_password', as: :admin_set_user_password
  post 'admin/save_controller' => 'admin#save_controller', as: :admin_save_controller
  post 'admin/save_quick_performers' => 'admin#save_quick_performers', as: :admin_save_quick_performers
  post 'admin/set_user_refresh_period' => 'admin#set_user_refresh_period', as: :admin_set_user_refresh_period
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
