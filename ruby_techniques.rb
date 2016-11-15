
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
#0,1,1,2,3,5,8,13
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

#continuously find gcd of two numbers, make sure num1 is greater than num 2
#basecase: if num1 is divisible by num2 then num2 is the gcd
def gcd(num1,num2)
	if num1 < num2
		temp = num1
		num1 = num2
		num2 = temp
	end

	if num1 % num2 == 0
		return num2
	end

	remainder = num1 % num2 
	gcd(num2, remainder)
end


#HR - Ice Cream Parlor

def parlor(m,arr)
	menu = []
	arr.each do |num|
		menu << num
	end
	find_comp = ->(cost, arr){ #binary serach that returns the index of the complement
		search_for = m - cost
		startdex = 0
		enddex = arr.length-1
		while startdex <= enddex
			middex = ((startdex + enddex) / 2).floor
			if arr[middex] == search_for
				return middex
			elsif arr[middex] > search_for
				enddex = middex - 1
			else
				startdex = middex + 1
			end
		end
		false
	}

	index_of = ->(value, skip_index){
		for i in 0..arr.length-1
			if arr[i] == value && i != skip_index
				return i
			end
		end
	}
	get_original = ->(value1, value2){
		index1 = index_of.call(value1, -1)
		index2 = index_of.call(value2, index1)
		[[index1,index2].min + 1, [index1,index2].max + 1]
	}
	sorted = menu.sort!
	menu_places = []
	for i in 0..sorted.length-1
		# p find_comp.call(sorted[i], sorted)
		if find_comp.call(sorted[i], sorted)
			index_of_match = find_comp.call(sorted[i], sorted)
			menu_places = get_original.call(sorted[i], sorted[index_of_match])
			break #if complement is found - you don't need to check anymore
		end
	end
	menu_places.join(" ")
end
list = "591 955 829 805 312 83 764 841 12 744 104 773 627 306 731 539 349 811 662 341 465 300 491 423 569 405 508 802 500 747 689 506 129 325 918 606 918 370 623 905 321 670 879 607 140 543 997 530 356 446 444 184 787 199 614 685 778 929 819 612 737 344 471 645 726"
array = list.split(" ").map! {|num| num.to_i}
p 789 - 104

list2 = [2,4,4,4,4,2,2]
p parlor(789, array)