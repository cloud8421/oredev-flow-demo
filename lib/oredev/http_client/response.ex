defmodule Oredev.HTTPClient.Response do
  @moduledoc false
  defstruct status_code: 100,
            headers: [],
            body: <<>>

  @type t :: %__MODULE__{
          status_code: pos_integer,
          headers: Oredev.HTTPClient.headers(),
          body: binary
        }
end
