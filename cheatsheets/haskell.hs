main :: IO ()
main = putStrLn "Hello, what is a Haskell!"

-- Run the function with:
-- ghci> main

-- '->' in type signatures group to the right
--   a -> b -> c === a -> (b -> c)
-- Function application groups to the left
--   f a b c === ((f a) b) c

a = 2 + 3

double x = x + x

-- Booleans
val = not True && False

-- Equality
-- 1 == 1
-- Inequality
-- 1 /= 1

doubleSmallNumber x = if x > 100
                      then x
                      else x*2

-- Lists (homogeneous)
list1 = [1,2,3]
list2 = [4,5,6]
list3 = list1 ++ list2

-- Strings are just lists of characters
woot = ['w','o'] ++ ['o','t']

-- Behold! the cons:
list4 = 0:[1,2,3]

-- Element at index (starts at 0)
fifthElement = list3 !! 4

-- And a few old friends:
h = head list3
t = tail list3
l = last list3
butLast = init list3

len = length list3
-- empty? is called null
isNull = null []
rlist3 = reverse list3

onMe = ["do","re","mi"]
taken = take 2 onMe
dropped = drop 2 onMe

-- include? is called elem
included = elem 2 [1,2,3]
-- You can infix everything
included = 2 `elem` [1,2,3]

-- ranges
numbers = [1..20]
letters = ['a'..'z']
sixteenToThirtyByTwos = [16,18..30]

-- Laziness
