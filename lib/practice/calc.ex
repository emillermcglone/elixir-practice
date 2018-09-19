defmodule Practice.Calc do
  # Get the next operation following order of operations
  def next_op(exp) do
    mul = Enum.find_index(exp, fn x -> x == "*" end)
    div = Enum.find_index(exp, fn x -> x == "/" end)
    add = Enum.find_index(exp, fn x -> x == "+" end)
    sub = Enum.find_index(exp, fn x -> x == "-" end)

    # compare indices to determine which op is next 
    cond do
      (mul != nil && div == nil) || (mul != nil && mul < div) ->
        mul

      div != nil ->
        div

      (add != nil && sub == nil) || (add != nil && add < sub) ->
        add

      sub != nil ->
        sub

      true ->
        1
    end
  end

  # Solve for an expression that has only number, operator, number
  def simple_eval([a, op, b]) do
    a = Integer.parse(a) |> elem(0)
    b = Integer.parse(b) |> elem(0)

    case op do
      "*" -> a * b
      "/" -> div(a, b)
      "+" -> a + b
      "-" -> a - b
    end
  end

  # Evalutate the expression
  def eval(exp) do
    cond do
      length(exp) == 1 ->
        exp

      true ->
        op_index = next_op(exp)
        a = Enum.at(exp, op_index - 1)
        op = Enum.at(exp, op_index)
        b = Enum.at(exp, op_index + 1)

        simple_answer =
          simple_eval([a, op, b])
          |> Integer.to_string()

        start = Enum.split(exp, op_index - 1) |> elem(0)
        ending = Enum.split(exp, op_index + 1) |> elem(1)

        eval(start ++ [simple_answer] ++ ending)
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    # ~r/\s+/
    expr
    |> String.split()
    |> eval
    |> Enum.at(0)

    # |> Integer.parse()
    # |> elem(0)

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end
