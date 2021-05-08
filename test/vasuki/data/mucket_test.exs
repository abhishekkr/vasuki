defmodule Vasuki.Data.MucketTest do
  use ExUnit.Case
  alias Vasuki.Data.Mucket

  describe "External API" do
    test "gets nil if bucket doesn't exist" do
      assert nil == Mucket.get(:live)
    end

    test "update a bucket that doesn't exist" do
      assert :ok == Mucket.update(:live, :done)
      assert :done == Mucket.get(:live)
      Mucket.reset()
    end

    test "update a bucket that already exists" do
      state1 = %{say: :what, this: :that}
      state2 = %{state1 | say: :louder}
      Mucket.update(:live, state1)
      assert state1 == Mucket.get(:live)
      assert :ok == Mucket.update(:live, state2)
      assert state2 == Mucket.get(:live)
      Mucket.reset()
    end

    test "support different buckets of data" do
      assert :ok == Mucket.update(:one, [1])
      assert :ok == Mucket.update(:two, [2])

      assert [1] == Mucket.get(:one)
      assert [2] == Mucket.get(:two)
      Mucket.reset()
    end

    test "reset cleans up all buckets" do
      assert :ok == Mucket.update(:one, [1])
      assert :ok == Mucket.update(:two, [2])
      Mucket.reset()
      assert nil == Mucket.get(:one)
      assert nil == Mucket.get(:two)
    end
  end
end
