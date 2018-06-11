defmodule TilanneApi.Router do
  use TilanneApi.Web, :router

  pipeline :api do
    plug CORSPlug, [origin: "http://localhost:4000"]
    plug :accepts, ["json"]
  end

  scope "/api", TilanneApi do
    pipe_through :api
  end

  scope "/", TilanneApi do
    pipe_through :api
    get "/", WelcomeController, :index
    resources "/collections", CollectionController
    get "/collections/:id/:selection", CollectionController, :selection
  end
end
