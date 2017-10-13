defmodule Maneo.Github do
  alias Maneo.HTTPClient

  @link_matcher ~r/^<(?<url>.*)>; rel="(?<rel>.*)"$/ 

  def get_stars_by_username(username) do
    url = "https://api.github.com/users/" <> username <> "/starred"
    get_stars_by_url(url)
  end

  def get_stars_by_url(url) do
    headers = %{
      "Accept" => "application/vnd.github.v3.star+json",
      "User-Agent" => "Username: cloud8421"
    }
    with %HTTPClient.Response{status_code: 200,
                              headers: resp_headers,
                              body: body} <- HTTPClient.get(url, headers), 
         {:ok, data} <- Poison.decode(body),
         links <- parse_links(resp_headers)
    do
      {:ok, data, links}
    else
      %HTTPClient.Response{status_code: status_code, body: body} ->
        {:error, {status_code, body}}
      %HTTPClient.ErrorResponse{message: message} ->
        {:error, message}
    end
  end

  def parse_links(headers) do
    :proplists.get_value("link", headers)
    |> String.split(", ", trim: true) 
    |> Enum.map(&parse_link/1)
    |> Enum.into(%{})
  end

  defp parse_link(link) do
    %{"rel" => rel, "url" => url} = Regex.named_captures(@link_matcher, link)
    {parse_rel(rel), url}
  end

  defp parse_rel("next"), do: :next
  defp parse_rel("first"), do: :first
  defp parse_rel("last"), do: :last
  defp parse_rel("prev"), do: :prev
end