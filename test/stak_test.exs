defmodule StakTest do
  use ExUnit.Case
  doctest Stak
  
  test "push then pop works correctly" do
    assert :ok == Stak.Server.push 1
    assert Stak.Server.pop == 1
  end
end
