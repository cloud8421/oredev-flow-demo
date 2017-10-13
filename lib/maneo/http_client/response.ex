defmodule Maneo.HTTPClient.Response do
  @moduledoc false
  defstruct status_code: 100,
            headers: [],
            body: <<>>
end
