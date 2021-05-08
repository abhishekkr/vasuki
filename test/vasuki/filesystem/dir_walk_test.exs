defmodule Vasuki.FileSystem.DirWalkTest do
  use ExUnit.Case
  alias Vasuki.FileSystem.DirWalk

  describe "External API" do
    @tag :active
    test "next without initiating anything" do
      assert DirWalk.next == :done
      DirWalk.reset()
    end

    @tag :active
    test "ls without initiating anything for a wrong path" do
      assert DirWalk.ls("/_this_is_undef") == :done
      DirWalk.reset()
    end

    @tag :active
    test "ls on a directory returns first file entry" do
      assert DirWalk.ls("./test/vasuki/filesystem") == "./test/vasuki/filesystem/.keep"
      assert DirWalk.next == "./test/vasuki/filesystem/dir_walk_test.exs"
      assert DirWalk.next == :done
      DirWalk.reset()
    end

    @tag :active
    test "ls on a directory runs recursively" do
      assert DirWalk.ls("./lib") == "./lib/vasuki.ex"
      assert DirWalk.next == "./lib/vasuki/application.ex"
      DirWalk.reset()
    end

    @tag :active
    test "ls can accept a list of dirs" do
      assert DirWalk.ls(["./lib/vasuki/data", "./lib/vasuki/filesystem"]) == "./lib/vasuki/data/mucket.ex"
      assert DirWalk.next == "./lib/vasuki/filesystem/dir_walk.ex"
      assert DirWalk.next == :done
      DirWalk.reset()
    end

    @tag :active
    test "ls on a directory after reset" do
      assert DirWalk.ls("./test/vasuki/filesystem") == "./test/vasuki/filesystem/.keep"
      DirWalk.reset()
      assert DirWalk.next == :done
    end
  end
end
