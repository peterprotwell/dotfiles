# Comments start with a hash
# Files can end in .ex or .exs, .ex are compiled, .exs are run as scripts

IO.puts "hello world!"

# This is actually matching
a = 1
# Totally fine
1 = a
# String interpolation same as ruby
IO.puts "a is #{a}"
# You can force variables to not re-match with the pin operator
# ^a = 2
# => MatchError

# Lists are declared with []
[a, b] = [1, 2]
IO.puts "a is #{a}, b is #{b}"

# Pattern matching is integral to the language
[head|tail] = [1, 2, 3]
IO.puts "head is #{head}"
IO.puts "tail is #{inspect tail}"

## Types

# Arbitrary size
int = 1234
hex = 0xcafe
octal = 0o765
binary = 0b1010

float = 1.0
f = 0.234
f = 0.314159e1
f = 314159.0e-5

atom = :foo
b = :is_binary?
c = :"func/3"
d = :danger_zone!

# Elixir has PCRE regexes
r = ~r{[0-9]+}

## Collection Types

tuple = {:ok, 41, "pants"}

# (linked-)list
list = [1,2,3,4]
IO.puts 3 in list

keyword_list = [name: "mike", city: "Chicago", likes: "emacs"]
# => [{name: "mike"}, {city: "Chicago"}, {likes: "emacs"}]
IO.puts "#{keyword_list[:name]} likes #{keyword_list[:likes]}"

map = %{"key" => "value"}
map = %{a: "a", b: "b", c: "c"} # Only if all keys are atoms
map = %{:one => "one", "two" => 2, [1,1,1] => :three, 4 => {"to the fore"}}
IO.puts map["two"]
IO.puts map[:one]
IO.puts map.one

binary = <<1,2>>

t = true
f = false
true == :true
false === :false

true and true
true or true
not true

1 && 2
nil || "false"
!"pants"

## So much fun(ctions)!
sum = fn (a, b) -> a + b end
IO.puts sum.(10, 32)

defmodule MyMath do
  def double(n) do
    n * 2
  end

  def triple(n), do: n * 3
end
IO.puts MyMath.double 100
IO.puts MyMath.triple 100
