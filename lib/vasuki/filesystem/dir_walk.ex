defmodule Vasuki.FileSystem.DirWalk do
  use GenServer
  require Logger

  alias Vasuki.Data.Mucket

  @me Application.get_env(:vasuki, :dirwalker)

  @moduledoc """
  DirWalk accept new path to traverse via `ls` returning first path, and every next file entry via `next`.
  It maintains state through crash using `Vasuki.Data.Mucket`.
  """

  defstruct filelist: [], dirlist: []

  defp files_in({:ok, filelist}, dirpath), do: filelist |> Enum.map(&("#{dirpath}/#{&1}"))
  defp files_in({:error, _}, dirpath) do
    Logger.error("ignore dir: #{dirpath}")
    []
  end

  defp walk(%__MODULE__{filelist: [], dirlist: []}), do: {:done, %__MODULE__{}}
  defp walk(%__MODULE__{filelist: [], dirlist: [path|tail]}) do
    alllist = File.ls(path) |> files_in(path)
    dirlist = alllist |> Enum.filter(&(File.dir?(&1)))
    filelist = alllist |> Enum.filter(&(File.regular?(&1)))
    walk(%__MODULE__{filelist: filelist, dirlist: dirlist ++ tail})
  end
  defp walk(%__MODULE__{filelist: [new_file|tail], dirlist: q}) do
    {new_file, %__MODULE__{filelist: tail, dirlist: q}}
  end

  ## GenServer impl
  def init(:no_args) do
    stash = Mucket.get(@me)
    state = case stash do
      nil -> %__MODULE__{}
      _ -> stash
    end
    {:ok, state}
  end

  def handle_call({:ls, dirpath}, _from, state) do
    state = Map.update(state, :dirlist, [dirpath], fn exis -> [dirpath|exis] end)
    {new_file, new_state} = walk(state)
    {:reply, new_file, new_state}
  end

  def handle_call(:next, _from, state) do
    {new_file, new_state} = walk(state)
    {:reply, new_file, new_state}
  end

  def handle_call(:reset, _from, _state) do
    update_me(%__MODULE__{})
    {:reply, :done, %__MODULE__{}}
  end

  def terminate(_reason, current_state), do: update_me(current_state)

  defp update_me(state), do: Mucket.update(@me, state)

  ## External API
  def start_link(_init_state) do
    GenServer.start_link(__MODULE__, :no_args, name: @me)
  end

  @doc "ls adds provided dirpath to list to be traversed and returns top file in queue to returned"
  def ls(dirpath), do: GenServer.call(@me, {:ls, dirpath})

  @doc "next returns one file at a time for directories queued up to traversed recrusively using 'ls'"
  def next, do: GenServer.call(@me, :next)

  @doc "reset simple cleans up the state"
  def reset, do: GenServer.call(@me, :reset)
end
