:timer.tc(fn() ->
  "cloud8421"
  |> Oredev.Github.Stream.by_username()
  |> Flow.from_enumerable(max_demand: 10)
  |> Flow.partition(key: {:key, :starred_at}, hash: fn(repo) ->
    {repo, Oredev.Github.StarredRepo.month_year(repo)}
  end)
  |> Flow.group_by(fn(repo) ->
    Oredev.Github.StarredRepo.month_year(repo)
  end)
  |> Flow.take_sort(5, fn {month_a, _repos_a}, {month_b, _repos_b} -> month_a <= month_b end)
  |> Enum.to_list()
end)
|> IO.inspect
