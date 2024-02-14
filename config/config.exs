import Config

config :test,
  ecto_repos: [Test.Repo],
  ash_apis: [Test.API]

config :test, Test.Repo,
  username: "yousefjanajri",
  database: "test-dev",
  port: 5432,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true
