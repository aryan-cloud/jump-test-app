defmodule JumpTestApp.Repo do
  use Ecto.Repo,
    otp_app: :jump_test_app,
    adapter: Ecto.Adapters.Postgres
end
