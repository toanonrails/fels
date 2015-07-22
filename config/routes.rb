Rails.application.routes.draw do
  scope '(:locale)', locale: /en/ do
    root 'home#index'
  end
end
