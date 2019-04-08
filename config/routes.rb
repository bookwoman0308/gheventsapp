Rails.application.routes.draw do
  root to: redirect('/forms/github-search')

  scope(:forms) do
    resources :event_forms, path: 'github-search'
  end
end
