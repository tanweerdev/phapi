defmodule Phapi.Router do
  use Phapi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Phapi do
    pipe_through :api
  end
end
