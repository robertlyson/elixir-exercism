defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    const = ["wink", "double blink", "close your eyes", "jump"]

    actions = const
      |> Enum.with_index
      |> Enum.filter(fn({element,index}) -> (1 <<< index &&& code) > 0 end)
      |> Enum.map(fn {element,_} -> element end)

    cond do
      (1 <<< 4 &&& code) > 0 -> actions |> Enum.reverse
      true -> actions
    end
  end
end
