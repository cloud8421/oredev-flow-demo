defmodule Oredev.Github.StarredRepo do
  defstruct id: nil,
            owner: nil,
            name: nil,
            description: nil,
            created_at: nil,
            pushed_at: nil,
            starred_at: nil
end
