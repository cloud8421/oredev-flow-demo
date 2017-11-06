"cloud8421"
|> Oredev.Github.Stream.by_username()
|> Flow.from_enumerable()
|> Flow.group_by(fn r ->
     case r.pushed_at do
       nil -> "not_available"
       dt -> "#{dt.year}-#{dt.month}"
     end
   end)
|> Flow.take_sort(20, fn {month_a, _repos_a}, {month_b, _repos_b} -> month_a <= month_b end)
|> Enum.to_list()
|> IO.inspect()
