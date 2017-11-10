:timer.tc(fn() ->
  "cloud8421"
  |> Oredev.Github.Stream.by_username()
  |> Flow.from_enumerable(max_demand: 10)
  |> Flow.map(fn(repo) ->
    IO.inspect repo
    Process.sleep(500)
    repo.starred_at
    |> IO.inspect
  end)
  |> Enum.take(100)
end)
|> IO.inspect
