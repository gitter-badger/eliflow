# coding: utf-8

defmodule Eliflow.Supervisor do
  use Supervisor

  import Eliflow.Logger
  import Supervisor.Spec, warn: false

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    debug("Starting Eliflow.")
    children = [supervisor(Eliflow.ConnectionSup, []), worker(Eliflow.Listener, [])]
    supervise(children, strategy: :one_for_one)
  end
end
