username = "cloud8421"

star_stream = Maneo.Github.Stream.by_username(username)

Enum.take(star_stream, 2) |> IO.inspect
