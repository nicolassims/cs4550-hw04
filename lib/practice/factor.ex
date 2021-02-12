defmodule Practice.Factor do

  defp parseInt(text) do
    {num, _} = Integer.parse(to_string(text))
    num
  end

  defp factorOut(num, factors, divisor) do
    cond do
      num == 0 -> ["Zero has no factors!"]
      rem(num, divisor) == 0 -> factorOut(trunc(num/divisor), [divisor | factors], 2)
      divisor < trunc(num / 2) -> factorOut(num, factors, divisor + 1)
      Enum.count(factors) == 0 -> ["Prime!"]#Return "prime" in the event a prime number is given
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
