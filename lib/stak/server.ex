defmodule Stak.Server do
  use GenServer

  @vsn "0"

  ######
  # External API

  def start_link(stash_pid) do
    { :ok, _p } = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    with number = GenServer.call(__MODULE__, :pop),
    do: "The next number is #{number}"
  end

  def push(value) do
    GenServer.cast __MODULE__, { :push, value }
  end

  ######
  # GenServer Implementation

  def init(stash_pid) do
    current_stash = Stak.Stash.get_stack stash_pid
    { :ok, { current_stash, stash_pid } }
  end

  def handle_call(:pop, _from, { [ top | rest ], stash_pid }) do
    { :reply, top, { rest, stash_pid } }
  end

  def handle_cast({ :push, value }, { stack, stash_pid }) do
    { :noreply, { [ value | stack ], stash_pid } }
  end

  def terminate(_reason, { current_stack, stash_pid }) do
    Stak.Stash.save_stack stash_pid, current_stack
  end
end
