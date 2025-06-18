Code.require_file("genserver_cache.exs", __DIR__)

ExUnit.start()
ExUnit.configure(trace: true)

defmodule GenServerCacheTest do
  use ExUnit.Case

  describe "solution genserver work" do
    test "initialization work" do
      {:ok, pid} = GenServerCache.start_link()

      assert Process.alive?(pid)
      Process.exit(pid, :normal)
    end

    test "current_state work" do
      {:ok, pid} = GenServerCache.start_link(%{test: "value"})

      assert GenServerCache.current_state() == %{test: "value"}
      Process.exit(pid, :normal)
    end

    test "reset work" do
      {:ok, pid} = GenServerCache.start_link(%{test: "value"})

      assert GenServerCache.reset() == :ok
      assert GenServerCache.current_state() == %{}
      Process.exit(pid, :normal)
    end

    test "has? work" do
      {:ok, pid} = GenServerCache.start_link(%{test: "value"})

      assert GenServerCache.has?(:test)
      refute GenServerCache.has?(:some)
      Process.exit(pid, :normal)
    end

    test "add work" do
      {:ok, pid} = GenServerCache.start_link(%{test: "value"})

      assert GenServerCache.add(:some, 2) == :ok
      assert GenServerCache.current_state() == %{test: "value", some: 2}
      Process.exit(pid, :normal)
    end

    test "drop work" do
      {:ok, pid} = GenServerCache.start_link(%{test: "value"})

      assert GenServerCache.drop(:some) == :ok
      assert GenServerCache.current_state() == %{test: "value"}
      assert GenServerCache.drop(:test) == :ok
      assert GenServerCache.current_state() == %{}
      Process.exit(pid, :normal)
    end
  end
end
