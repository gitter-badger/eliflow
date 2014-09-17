# coding: utf-8

defmodule Eliflow.Logger do
  require Logger

  def info(msg) do
    Logger.info(msg)
  end

  def debug(msg) do
    Logger.debug(msg)
  end

  def error(msg) do
    Logger.error(msg)
  end
end
