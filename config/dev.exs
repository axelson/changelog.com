use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :changelog, ChangelogWeb.Endpoint,
  url: [host: System.get_env("HOST") || "localhost"],
  http: [
    port: 4000
  ],
  https: [
    port: 4001,
    cipher_suite: :strong,
    certfile: "priv/cert/selfsigned.pem",
    keyfile: "priv/cert/selfsigned_key.pem"
  ],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false,
  watchers: [
    yarn: ["start", cd: Path.expand("../assets", __DIR__)]
  ]

# Watch static and templates for browser reloading.
config :changelog, ChangelogWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{lib/changelog_web/(live|views)/.*(ex)$},
      ~r{lib/changelog_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

# Configure your database
config :changelog, Changelog.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: SecretOrEnv.get("DB_NAME", "changelog_dev"),
  hostname: SecretOrEnv.get("DB_HOST", "localhost"),
  password: SecretOrEnv.get("DB_PASS"),
  pool_size: 10,
  username: SecretOrEnv.get("DB_USER", "postgres")

config :rollbax,
  access_token: "",
  environment: "development",
  enabled: :log
