defmodule Oredev.Github.StarredRepo do
  defstruct id: nil,
            owner: nil,
            name: nil,
            description: nil,
            created_at: nil,
            pushed_at: nil,
            starred_at: nil

  def month_year(repo) do
    case repo.pushed_at do
      nil -> "not_available"
      dt -> "#{dt.year}-#{dt.month}"
    end
  end
end
