Rails.application.routes.draw do
  get "dashboards/*query", to: "dashboards#show"
end
