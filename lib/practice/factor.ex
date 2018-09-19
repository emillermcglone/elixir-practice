# Attribution: https://stackoverflow.com/questions/28587249/how-can-this-code-be-better-structured-in-elixir
defmodule Practice.Factor do
  def factor(x) do
    num = String.to_integer(x)
    primes = get_factors(num)
    inspect(primes)
  end

  def get_factors(num, next \\ 2)

  def get_factors(num, 2) do
    cond do
      rem(num, 2) == 0 -> [2 | get_factors(div(num, 2))]
      4 > num -> [num]
      true -> get_factors(num, 3)
    end
  end

  def get_factors(num, next) do
    cond do
      rem(num, next) == 0 -> [next | get_factors(div(num, next))]
      next + next > num -> [num]
      true -> get_factors(num, next + 2)
    end
  end
end
