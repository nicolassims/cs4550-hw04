defmodule Practice.Factor do

  defp parseInt(text) do
    {num, _} = Integer.parse(to_string(text))
    num
  end

  defp factorOut(num, factors, divisor) do
    cond do
      rem(num, divisor) == 0 -> factorOut(trunc(num/divisor), [divisor | factors], 2)
      divisor < trunc(num / 2) -> factorOut(num, factors, divisor + 1)
      num == 1 -> factors
      true -> [ num | factors ]
    end
  end

  def factor(x) do
    x
    |> parseInt()
    |> factorOut([], 2)
    |> Enum.reverse()
  end
end
