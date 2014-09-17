# coding: utf-8

defmodule Eliflow.Connection.Worker do
  import Record

  import Eliflow.Logger
  import Eliflow.Utils

  def start_link(socket) do
    :proc_lib.start_link(__MODULE__, :init, [self(), socket])
  end

  def init(parent, socket) do
    spawn = fn ->
      :erlang.process_flag(:trap_exit, true)
      setopts(:tcp, socket, [active: :once])
      setup(socket)
    end
    case :plain_fsm.spawn_link(__MODULE__, spawn) do
      pid  when is_pid(pid) ->
        :proc_lib.init_ack(parent, {:ok, pid})
      error ->
        {:error, error}
    end
  end

  def setup(socket) do
    receive do
      {:tcp, socket, data} ->
        msg = :of_protocol.decode(data)
      _ ->
        close(:unexpected)
    after
      200000 ->
        close(:timeout)
    end
  end

  def do_send(socket, bin) do
    :gen_tcp.send(socket, bin)
  end

  def close(reason) do
    exit(reason)
  end

  def close(callback, reason) do
    callback.close(reason)
    exit(reason)
  end
end
