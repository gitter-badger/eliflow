# coding: utf-8

defmodule Eliflow do
  use Application

  def start(_type, _args) do
    Eliflow.Supervisor.start_link
  end
end
