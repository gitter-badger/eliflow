# coding: utf-8

defmodule Eliflow.Utils do
  def setopts(:tcp, socket, opts) do
    :inet.setopts(socket, opts)
  end

  def setopts(:tls, socket, opts) do
    :ssl.setopts(socket, opts)
  end

  def get_config(entry, default) do
    case :application.get_env(:eliflow, entry) do
      {:ok, value} ->
        value
      _ ->
        default
    end
  end

  def get_config(entry, guard, default) do
    case :application.get_env(:eliflow, entry) do
      {:ok, value} ->
        case guard.(value) do
          true ->
            value
          false ->
            default
        end
      _ ->
        default
    end
  end
end
