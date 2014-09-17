# coding: utf-8

defmodule Eliflow.ConnectionSup do
  use Supervisor

  import Eliflow.Logger
  import Supervisor.Spec, warn: false

  def start_link do
    :supervisor.start_link({:local, __MODULE__}, __MODULE__, [])
  end

  def init([]) do
    debug("Initializing Eliflow Connection Supervisor.")

    c = Eliflow.Connection.Worker
    restart_strategy = :simple_one_for_one
    max_restarts = 1000
    max_seconds_between_restarts = 3600
    sup_flags = {restart_strategy, max_restarts, max_seconds_between_restarts}

    {:ok, {sup_flags,
           [{:conn_id, {c, :start_link, []}, :temporary, 1000, :worker, [c]}
           ]}}
  end

  def start_child(socket) do
    debug("Starting Child Connection Process.")
    :supervisor.start_child(__MODULE__, [socket])
  end
end
