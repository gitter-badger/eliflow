defmodule Eliflow.Mixfile do
  use Mix.Project

  def project do
    [app: :eliflow,
     version: "0.0.1",
     elixir: "~> 1.1.0-dev",
     deps: deps]
  end

  def application do
    [mod: {Eliflow,[]},
     applications: [:sasl, :logger, :of_protocol, :of_msg_lib, :plain_fsm],
     registered: [:eliflow],
     description: 'Elixir OpenFlow Driver']
  end

  defp deps do
    [{ :exrm, "~> 0.14.9" },
     { :ex_doc, "~> 0.5" },
     { :plain_fsm, git: "https://github.com/uwiger/plain_fsm.git", tag: "1.0" },
     { :of_protocol, git: "https://github.com/FlowForwarding/of_protocol.git", branch: "master" },
     { :of_msg_lib, git: "https://github.com/FlowForwarding/of_msg_lib.git", branch: "master" }]
  end
end
