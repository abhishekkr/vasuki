defmodule Vasuki do
  @moduledoc """
  Vasuki manages simple things in projects, currently FileSystem and Data.

  ## FileSystem

  * [DirWalk](https://hexdocs.pm/vasuki/Vasuki.FileSystem.DirWalk.html): helps recursively traverse through directories; can add target directories using 'ls' and keep getting regular file paths one by one using 'next'


  ## Data

  * [Mucket](https://hexdocs.pm/vasuki/Vasuki.Data.Mucket.html): helps manage different bucket of data/states in memory by bucket-name providing 'get', 'update' & 'reset'
  """

  @doc """
  Every ping gets a pong.

  ## Examples

      iex> Vasuki.ping()
      :pong

  """
  def ping do
    :pong
  end
end
