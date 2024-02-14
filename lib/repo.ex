defmodule Test.Repo do
  use AshPostgres.Repo,
    otp_app: :test
end
