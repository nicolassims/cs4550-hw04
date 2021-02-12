defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  defp tag_token(token) do
    if (token == "+" || token == "*" || token == "-" || token == "/") do
      {:op, token}
    else
      {:num, parse_float(token)}
    end
  end

  defp precedence(op) do
    case op do
      "+" -> 0
      "-" -> 0
      "*" -> 1
      "/" -> 1
    end
  end

  defp convertOperator(op, tokens, output, opsStack) do
    if (Enum.count(opsStack) > 0) do
      if (precedence(op) > precedence(hd opsStack)) do
        convertPostfix(tokens, output, [op | opsStack])
      else
        convertOperator(op, tokens, [(hd opsStack) | output], tl opsStack)
      end
    else
      convertPostfix(tokens, output, [op])
    end
  end

  defp convertPostfix(tokens, output, opsStack) do
    if (Enum.count(tokens) > 0) do
      head = hd tokens
      tail = tl tokens
      case head do
        {:num, num} -> convertPostfix(tail, [num | output], opsStack)
        {:op, op} -> convertOperator(op, tail, output, opsStack)
      end
    else
      Enum.reverse(output) ++ opsStack
    end
  end

  defp evaluateOperator(op, stack) do
    case op do
      "+" -> Enum.at(stack, 1) + (hd stack)
      "-" -> Enum.at(stack, 1) - (hd stack)
      "*" -> Enum.at(stack, 1) * (hd stack)
      "/" -> Enum.at(stack, 1) / (hd stack)
    end
  end

  defp evaluatePostfix(tokens, stack) do
    if (Enum.count(tokens) > 0) do
      head = hd tokens
      if (is_float(head)) do
        evaluatePostfix((tl tokens), [head | stack])
      else
        evaluatePostfix((tl tokens), [ evaluateOperator(head, stack) | stack -- [(hd stack), (hd (tl stack))]])
      end
    else
      hd stack
    end
  end

  defp removeZeroes(num) do
    if (trunc(num) == num) do
      trunc(num)
    else
      num
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    # There _MUST_ be spaces between separate numbers and operations. Otherwise, it's a bad input.
    expr
    |> String.split(~r/\s+/)
    |> Enum.map(&tag_token/1)
    |> convertPostfix([], [])
    |> evaluatePostfix([])
    |> removeZeroes()
  end
end
