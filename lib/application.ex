defmodule Test.Application do
  use Application

  @impl Application
  def start(_type, _args) do
    Supervisor.start_link([Test.Repo],
      strategy: :one_for_one,
      name: Test.Supervisor
    )
  end
end
