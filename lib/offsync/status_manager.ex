defmodule Offsync.StatusManager do
  use GenServer

  defstruct [status: :closed]
  
  def start_link(_) do
    GenServer.start_link(__MODULE__, %__MODULE__{}, name: __MODULE__)
  end
  
  def open() do
    GenServer.call(__MODULE__, :open)
  end
  
  def open?() do
    GenServer.call(__MODULE__, :is_open)
  end

  def close() do
    GenServer.call(__MODULE__, :close)
  end

  @impl true
  def init(params) do
    {:ok, params}
  end

  @impl true
  def handle_call(:open, _from, state) do
    new_state = %__MODULE__{state | status: :open}
    
    Phoenix.PubSub.broadcast(Offsync.PubSub, "status", {:status, new_state})
    
    {:reply, new_state, new_state}
  end
  
  @impl true
  def handle_call(:close, _from, state) do
    new_state = %__MODULE__{state | status: :closed}
    
    Phoenix.PubSub.broadcast(Offsync.PubSub, "status", {:status, new_state})

    {:reply, new_state, new_state}
  end
  
  @impl true
  def handle_call(:is_open, _from, %__MODULE__{status: status} = state) do
    case status do
      :open ->
        {:reply, true, state}
      
      :closed ->
        {:reply, false, state}
    end
  end
end

