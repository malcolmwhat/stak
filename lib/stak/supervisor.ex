defmodule Stak.Supervisor do
  use Supervisor

  def start_link(ini_stack) do
    result = { :ok, sup } = Supervisor.start_link(__MODULE__, [ ini_stack ])
    start_workers(sup, ini_stack)
    result
  end

  def start_workers(sup, ini_stack) do
    # Start the stash worker
    { :ok, stash } =
      Supervisor.start_child(sup, worker(Stak.Stash, [ ini_stack ]))
    # and then the subsupervisor for the actual sequence server
    Supervisor.start_child(sup, supervisor(Stak.SubSupervisor, [ stash ]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
