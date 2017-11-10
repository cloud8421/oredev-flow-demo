:timer.tc(fn() ->
  "cloud8421"
  |> Oredev.Github.Stream.by_username()
  |> Enum.take(100)
  |> Enum.map(fn(repo) ->
    Process.sleep(500)
    repo.starred_at
    |> IO.inspect
  end)
end)
|> IO.inspect
