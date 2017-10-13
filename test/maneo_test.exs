defmodule ManeoTest do
  use ExUnit.Case
  doctest Maneo

  test "greets the world" do
    assert Maneo.hello() == :world
  end
end
