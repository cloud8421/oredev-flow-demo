"cloud8421"
|> Maneo.Github.Stream.by_username
|> Flow.from_enumerable
|> Flow.group_by(fn(r) -> "#{r.created_at.year}-#{r.created_at.month}" end)
|> Enum.take(2)
|> IO.inspect
