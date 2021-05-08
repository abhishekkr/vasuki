defmodule Vasuki.Data.Mucket do
  use GenServer

  @me Application.get_env(:vasuki, :mucket)

  @moduledoc """
  Mucket is a memory bucket for varied GenServers to get/update their state at.
  """

  ## GenServer impl

  def init(init_state), do: {:ok, init_state}

  def handle_call({:get, bucket}, _from, state) do
    data = Map.get(state, bucket)
    {:reply, data, state}
  end

  def handle_cast({:update, bucket, data}, state) do
    new_state = put_in(state, [bucket], data)
    {:noreply, new_state}
  end

  def handle_cast(:reset, _state), do: {:noreply, %{}}

  ## External API

  @doc "Starts GenServer for Mucket."
  def start_link(_init_state), do: GenServer.start_link(__MODULE__, %{}, name: @me)

  @doc "Gets the data mapped to bucket name in state map."
  def get(bucket), do: GenServer.call(@me, {:get, bucket})

  @doc "Maps the data to bucket name in state."
  def update(bucket, new_state), do: GenServer.cast(@me, {:update, bucket, new_state})

  @doc "Resets the memory map of buckets to empty."
  def reset, do: GenServer.cast(@me, :reset)
end
