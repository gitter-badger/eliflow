# coding: utf-8

defmodule Eliflow.Listener do
  import Record

  import Eliflow.Utils

  use GenServer

  defrecord :state, lsock: nil

  def start_link do
    :gen_server.start_link({:local, __MODULE__}, __MODULE__, [], [])
  end

  def init([]) do
    case get_config(:listen, fn(x) -> is_boolean(x) end, true) do
      false ->
        :ok
      _ ->
        listen
    end
    {:ok, state}
  end

  defp listen do
    :gen_server.cast(__MODULE__, :startup)
  end

  def handle_cast(:startup, state) do
    port = get_config(:listen_port, fn(x) -> is_integer(x) end, 6653)
    listen_options = get_config(:listen_opts, fn(x) -> is_list(x) end, [:binary,
                                                                        {:packet, :raw},
                                                                        {:active, :false},
                                                                        {:reuseaddr, :true}])
    listen_options2 = :lists.append(listen_options, [{:ip, {0,0,0,0}}])
    debug("Eliflow listening for switches on #{ port }")
    {:ok, lsocket} = :gen_tcp.listen(port, listen_options2)
    spawn_link(__MODULE__, :accept, [lsocket])
    {:noreply, state(lsock: lsocket)}
  end

  def handle_cast(msg, state) do
    {:noreply, state}
  end

  def accept(lsocket) do
    case :gen_tcp.accept(lsocket) do
      {:ok, socket} ->
        case Eliflow.Connection.start_child(socket) do
          {:ok, connect_controll_pid} ->
            :gen_tcp.controlling_process(socket, connect_controll_pid)
          {:error, _reason} ->
            :ok
        end
        accept(lsocket)
      _error ->
        accept(lsocket)
    end
  end
end
