defmodule VasukiTest do
  use ExUnit.Case
  doctest Vasuki

  test "play ping pong" do
    assert Vasuki.ping() == :pong
  end
end
