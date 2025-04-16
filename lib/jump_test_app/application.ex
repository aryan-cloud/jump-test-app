defmodule JumpTestApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JumpTestAppWeb.Telemetry,
      JumpTestApp.Repo,
      {DNSCluster, query: Application.get_env(:jump_test_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: JumpTestApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: JumpTestApp.Finch},
      # Start a worker by calling: JumpTestApp.Worker.start_link(arg)
      # {JumpTestApp.Worker, arg},
      # Start to serve requests, typically the last entry
      JumpTestAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JumpTestApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JumpTestAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
