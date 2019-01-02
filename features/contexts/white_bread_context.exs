defmodule WhiteBreadContext do
  use WhiteBread.Context

  given_ ~r/^the following taxis are on duty$/, fn state ->
    {:ok, state}
  end

end
