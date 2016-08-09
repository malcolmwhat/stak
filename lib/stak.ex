defmodule Stak do
  use Application

  def start(_type, _args) do
    initial_stack = Application.get_env(:stak, :ini_stack)
    { :ok, _p } = Stak.Supervisor.start_link(initial_stack)
  end
end
