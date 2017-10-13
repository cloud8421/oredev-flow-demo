defmodule Maneo.Github.Stream do
  def by_username(username) do
    start_fn = fn() ->
      Maneo.Github.url_for(username)
    end

    next_fn = fn(next_url) ->
      case Maneo.Github.get_stars_by_url(next_url) do
        {:ok, data, links} ->
          case Map.get(links, :next) do
            nil -> {:halt, next_url}
            new_url -> {data, new_url}
          end
        error ->
          {:halt, error}
      end
    end

    halt_fn = fn(_next_url) -> :ok end

    Stream.resource(start_fn, next_fn, halt_fn)
  end
end
