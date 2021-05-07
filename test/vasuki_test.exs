defmodule VasukiTest do
  use ExUnit.Case
  doctest Vasuki

  test "greets the world" do
    assert Vasuki.hello() == :world
  end
end
