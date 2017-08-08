Rails.application.routes.draw do
  get 'welcome/test'

  get 'welcome/index'

  post 'index' => 'welcome#index'

end
