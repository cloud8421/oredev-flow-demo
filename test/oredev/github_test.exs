defmodule Oredev.GithubTest do
  use ExUnit.Case, async: true

  alias Oredev.Github

  test "parses hypermedia links out of headers" do
    headers =
      [
        {"cache-control", "public, max-age=60, s-maxage=60"},
        {"date", "Fri, 13 Oct 2017 09:33:59 GMT"},
        {"etag", "\"d32c52ee9c9218a92ba8d17ee4a547d8\""},
        {"server", "GitHub.com"},
        {"vary", "Accept"},
        {"content-length", "145960"},
        {"content-type", "application/json; charset=utf-8"},
        {"status", "200 OK"},
        {"x-ratelimit-limit", "60"},
        {"x-ratelimit-remaining", "57"},
        {"x-ratelimit-reset", "1507890536"},
        {"x-github-media-type", "github.v3; param=star; format=json"},
        {
          "link",
          "<https://api.github.com/user/537608/starred?page=2>; rel=\"next\", <https://api.github.com/user/537608/starred?page=15>; rel=\"last\""
        },
        {
          "access-control-expose-headers",
          "ETag, Link, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"
        },
        {"access-control-allow-origin", "*"},
        {"content-security-policy", "default-src 'none'"},
        {"strict-transport-security", "max-age=31536000; includeSubdomains; preload"},
        {"x-content-type-options", "nosniff"},
        {"x-frame-options", "deny"},
        {"x-xss-protection", "1; mode=block"},
        {"x-runtime-rack", "0.121894"},
        {"x-github-request-id", "CD14:301F:1228F4:3145F8:59E08887"}
      ]

    assert Github.parse_links(headers) ==
             %{
               next: "https://api.github.com/user/537608/starred?page=2",
               last: "https://api.github.com/user/537608/starred?page=15"
             }
  end

  test "parses starred repos" do
    response =
      File.cwd!()
      |> Path.join("/test/fixtures/starred_repos.json")
      |> File.read!()
      |> Poison.decode!()

    {:ok, created_at, 0} = DateTime.from_iso8601("2011-01-26T19:01:12Z")
    {:ok, pushed_at, 0} = DateTime.from_iso8601("2011-01-26T19:06:43Z")
    {:ok, starred_at, 0} = DateTime.from_iso8601("2011-01-16T19:06:43Z")

    assert Github.parse_starred_repos(response) ==
             [
               %Github.StarredRepo{
                 id: 1_296_269,
                 owner: "octocat",
                 name: "Hello-World",
                 description: "This your first repo!",
                 created_at: created_at,
                 pushed_at: pushed_at,
                 starred_at: starred_at
               }
             ]
  end
end
