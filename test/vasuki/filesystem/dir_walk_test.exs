defmodule Vasuki.FileSystem.DirWalkTest do
  use ExUnit.Case
  alias Vasuki.FileSystem.DirWalk

  describe "External API" do
    test "next without initiating anything" do
      assert DirWalk.next == :done
      DirWalk.reset()
    end

    test "ls without initiating anything for a wrong path" do
      assert DirWalk.ls("/_this_is_undef") == :done
      DirWalk.reset()
    end

    test "ls on a directory returns first file entry" do
      assert DirWalk.ls(".") == "./README.md"
      assert DirWalk.next == "./mix.lock"
      assert DirWalk.next == "./mix.exs"
      assert DirWalk.next == "./.formatter.exs"
      assert DirWalk.next == "./.gitignore"
      DirWalk.reset()
    end

    test "ls on a directory runs recursively" do
      assert DirWalk.ls("./lib") == "./lib/vasuki.ex"
      assert DirWalk.next == "./lib/vasuki/application.ex"
      DirWalk.reset()
    end

    test "ls on a directory after reset" do
      assert DirWalk.ls(".") == "./README.md"
      DirWalk.reset()
      assert DirWalk.next == :done
    end
  end
end
