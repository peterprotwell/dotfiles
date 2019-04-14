cliche = 'World!'
# No newline
print "Hello, #{cliche}"
# With newline
puts "Hello, #{cliche}"
# Python-style printf
print "Hello, %s" % [cliche]
# Newline and uses Object.inspect instead of to_s
p "Hello, #{cliche}"

# Dynamically typed, not untyped
x = 1
x.class # => Fixnum

# Ruby does not have ++ or --
x += 1

#-------------------------------------------------------------------------------
# Arrays

# Array literal
a = []
a = [1, 2, 3]
a[0] # => 1
a[3] = 'pants'
a << nil
puts a # => [1, 2, 3, "pants", nil]
a.each do |item|
  puts item
end

#-------------------------------------------------------------------------------
# Hashes

# Hash literal
h = {}

# Old syntax
h = {:one => 1, :two => 2, :three => 3}
h[:two] # => 2
# Anything can be keys
h = {'one' => 1, 2 => 2, Object.new => 3}
h['three'] # => 3

# New syntax (1.9)
h = {one: 1, two: 2, three: 3}
h[:three] # => 3

h = [{ a: 10 }, { b: 20 }, { c: 30 }]
# super cool
h.reduce(:merge) # returns { a: 10, b: 20, c: 30 }

#-------------------------------------------------------------------------------
# Scope

$GLOBAL_VARIABLE = "EVERYWHERE"

@instance_variable = "just in the instance"

@@class_variable = "Most places"

Constant = "String.Yes"

#-------------------------------------------------------------------------------
# Regex

r = /[Rr]uby/

str = "ruby"
puts "It matches" if str == r

#-------------------------------------------------------------------------------
# Functions

# Private function of Object
def square(x)
  x * x
end
# Class function of Math
def Math.square(x)
  x * x
end

# Predicate method
puts "It's empty!" if a.empty?

# Bang method
a.sort!

#-------------------------------------------------------------------------------
# Classes

class Foo

  # Include the methods of this module in this class
  include Enumerable

  def initialize(from, to, by)
    # Just save our parameters into instance variables for later use
    @from, @to, @by = from, to, by
  end

  def each
    x = @from
    # Pass x to the block associated with the iterator
    yield x
    x += @by
  end

  def length
    return 0 if @from > @to # Note if used as a statement modifier
    Integer((@to-@from)/@by) + 1 # Compute and return length of sequence end
  end

  # size is now a synonym for length. SHAZAM!
  alias size length

end

# From 1 to 10 by 2's
s = Sequence.new(1, 10, 2)
# Prints 13579
s.each { |num| puts num }

# Or we could have just used a module
module Sequences
  # A singleton method of the module
  def self.fromtoby(from, to, by)
    x = from while x <= to
    yield x
    x += by
  end
end

# Prints "13579"
Sequences.fromtoby(1, 10, 2) { |num| puts num }

# Class method
# Math::sqrt

# Instance method
# Hash#each

#-------------------------------------------------------------------------------
# Blocks, Procs, and Lambdas

# Examples from:
# http://awaxman11.github.io/blog/2013/08/05/what-is-the-difference-between-a-block

# Block
# block is in between the curly braces
[1,2,3].each { |n| puts n*2 }

# block is everything between the do and end
[1,2,3].each do |n|
  puts n*2
end

# Proc
p = Proc.new { |n| puts n*2 }
# alernate syntax
p = proc { |n| puts n*2 }
# The '&' tells ruby to turn the proc into a block
[1,2,3].each(&p)
p.call # totally cool
p.call('do', 're', 'mi') # also totally cool

proc = Proc.new { puts "Hello World" }
proc.call # prints "Hello World"

# Lambda
lam = lambda { |n| puts n*2 }
# new "stabby arrow" lambda syntax, same as above
lam = -> (n) { puts n*2 }
# & converts the lambda into a block
[1,2,3].each(&lam)
lam.call # totally not cool
lam.call(4, 5, 6) # also not cool

lam = lambda { puts "Hello World" }
lam.call # prints "Hello World"
lam.class # returns `Proc'

# Differences
# 1. Procs are objects, Blocks are not. Blocks are just syntax
# 2. You can only pass one Block to a method
# 3. Lambdas are just Procs, but slightly different
# 4. Lambdas check for the correct number of args, Procs don't
# 5. Lambdas and Procs treat the return keyword differently.
#    `return' in a Proc returns from the calling context
def proctest
  proc = Proc.new { return }
  proc.call
  puts "after the proc"
end

def lamtest
  lam = -> { return }
  lam.call
  puts "after the lambda"
end

proctest # prints nothing
lamtest # prints "after the lambda"

#-------------------------------------------------------------------------------
# Pass by reference/value
