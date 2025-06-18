defmodule GenServerCache do
  use GenServer

  def start_link(initial_state \\ %{}) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  def add(key, val), do: GenServer.cast(__MODULE__, {:add, key, val})
  def drop(key), do: GenServer.cast(__MODULE__, {:drop, key})
  def reset, do: GenServer.cast(__MODULE__, :reset)

  def current_state, do: GenServer.call(__MODULE__, :current_state)
  def has?(key), do: GenServer.call(__MODULE__, {:has?, key})

  def handle_cast({:add, key, val}, state) do
    {:noreply, Map.put(state, key, val)}
  end

  def handle_cast({:drop, key}, state) do
    {:noreply, Map.delete(state, key)}
  end

  def handle_cast(:reset, _state) do
    {:noreply, %{}}
  end

  def handle_cast(msg, state) do
    IO.puts("handle_cast intercept unknown message: #{inspect(msg)}")
    {:noreply, state}
  end

  def handle_call(:current_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:has?, key}, _from, state) do
    {:reply, Map.has_key?(state, key), state}
  end

  def handle_call(msg, _from, state) do
    IO.puts("handle_call intercept unknown message: #{inspect(msg)}")
    {:reply, {:error, :unknown_msg}, state}
  end
end
