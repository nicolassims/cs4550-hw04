defmodule Practice.Factor do

  defp parseFloat(text) do
    {num, _} = Float.parse(to_string(text))
    num
  end

  defp factorOut(num, factors, divisor) do
    cond do
      num < 1 || trunc(num) != num -> ["Unfactorable number!"]#any float or number less than one is a bad input
      num != 2 && rem(trunc(num), divisor) == 0 -> factorOut(trunc(num/divisor), [divisor | factors], 2)
      divisor < trunc(num / 2) -> factorOut(num, factors, divisor + 1)
      Enum.count(factors) == 0 -> ["Prime!"]#Return "prime" in the event a prime number is given
      true -> [ num | factors ]
    end
  end

  def factor(x) do
    x
    |> parseFloat()
    |> factorOut([], 2)
    |> Enum.reverse()
  end
end
