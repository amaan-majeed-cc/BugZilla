Rails.application.routes.draw do
  get "ticket/index", as: "tickets"
  post "ticket/create"
  get "ticket/new"
  get "ticket/edit/:id", to: "ticket#edit", as: "ticket/edit"
  patch "ticket/update/:id", to: "ticket#update", as: "ticket/update"
  get "ticket/show/:id", to: "ticket#show", as: "ticket_show"
  delete "ticket/destroy", to: "ticket#destroy", as: "ticket/destroy"

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "home#index"

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end


=begin

id: ,
title: "New Ticket",
description: "This is a new Ticket",
deadline: 12-3-22,
type: ,
status: ,
creator: ,
developer: ,
project_id: ,
created_at: ,
updated_at: )

Ticket.create!(title: "Ticket Title", description: "Ticket description",  deadline: Date.today + 7.days, type: "Bug", status: "Open", creator: "John Doe", developer: "Jane Doe",  project_id: 1)

=end

