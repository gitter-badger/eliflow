# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for third-
# party users, it should be done in your mix.exs file.

config :eliflow,
  listen:    true,
  listen_ip: {0,0,0,0},
  listen_port: 6653,
  listen_opts: [:binary, {:packet, :raw}, {:active, :false}, {:reuseaddr, true}],
  ofp_version: [3, 4],
  callback_module: Eliflow.DefaultHandler

config :logger, :console,
  level: :debug,
  handle_sasl_reports: true,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:user_id]

# import_config "#{Mix.env}.exs"
