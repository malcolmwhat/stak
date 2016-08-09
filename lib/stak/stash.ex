defmodule Stak.Stash do
  use GenServer

  #######
  # External API

  def start_link(ini_stash) do
    { :ok, _pid } = GenServer.start_link(__MODULE__, ini_stash)
  end

  def save_stack(pid, value) do
    GenServer.cast pid, { :save_stack, value }
  end

  def get_stack(pid) do
    GenServer.call pid, :get_stack
  end

  ######
  # GenServer implementation

  def handle_call(:get_stack, _from, current_stack) do
    { :reply, current_stack, current_stack }
  end

  def handle_cast({ :save_stack, stack }, _current_stack) do
    { :noreply, stack }
  end
end
