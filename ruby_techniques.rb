
=begin
- if a * b = num, a = b when they are square root of num, e.g. 6 x 6 = 36
- if a != b, then one factor is greater than num and the other less than, e.g. 4 x 9 = 36, with 4 < 6, 9 > 6
- to check if prime, just check the nums up until square root of num
=end

def is_prime(num)
	s_root = (num ** (0.5)).floor
	p s_root
	for i in 2..s_root
		if num % i  == 0
			return false
		end
	end
	true
end

=begin
*recursive
- basecase: n = 0 or n = 1
*iterative
- account for 0 and 1
- start iteration after 1 aka on 2
- sum two previous, reset both previous numbers to one before, and current value aka sum
- return sum
=end

def fib_i(n)
	if n == 0
		return 0
	elsif n ==1
		return 1
	end
	one = 0
	two = 1
	sum = 0
	for i in 2..n
		sum = one + two
		one = two
		two = sum
	end
	sum
end

def fib_r(n)
	if n == 0
		return 0
	elsif n ==1
		return 1
	end
	fib_r(n - 1) + fib_r(n - 2)
end


=begin
- recursive sequence
- basecases:
- if n == 1 --> 1 way
- if n == 2 --> 2 ways: 1,1 and 2
- if n == 3 --> 4 ways: 1,1,1 and 1,2 and 2,1 and 3

- e.g. 4 --> 6 ways: 1,1,1,1 and 1,1,2 and 2,1,1 and 2,2 and 3,1, and 1,3
- e.g. 5 --> 12 ways: 11111,1112,2111,1211, 1121, 221, 122, 131, 311, 113, 23, 32
=end

$memo_cache = {}
def num_of_steps(n)

	if $memo_cache[n] != nil
		return $memo_cache[n]
	end

	return 1 if n == 1 
	return 2 if n == 2 
	return 4 if n == 3 

	value = num_of_steps(n-1) + num_of_steps(n-2) + num_of_steps(n-3)

	$memo_cache[n] = value
end

=begin
- input: array of different values of coins, dollar amount to equal
- output: the number of different combinations of coins

- recursion:
- basecase: 
	
=end


p num_of_steps(4)
