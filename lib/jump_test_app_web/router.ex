defmodule JumpTestAppWeb.Router do
  use JumpTestAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {JumpTestAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JumpTestAppWeb do
    pipe_through :browser

    get "/", RedirectController, :home
    live "/messages", MessageLive.Index, :index
    live "/messages/new", MessageLive.Index, :new
    live "/messages/:id", MessageLive.Show, :show
    live "/messages/:id/edit", MessageLive.Index, :edit
  end


  # Other scopes may use custom stacks.
  # scope "/api", JumpTestAppWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:jump_test_app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: JumpTestAppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

# filepath: lib/jump_test_app_web/controllers/redirect_controller.ex
defmodule JumpTestAppWeb.RedirectController do
  use JumpTestAppWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: "/messages")
  end
end
