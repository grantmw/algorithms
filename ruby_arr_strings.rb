
#1.1

#put into arr, sort, compare current with next
def unique?(str)
	arr = str.split("")
	arr.sort!
	for i in 0..arr.length-2
		if arr[i] == arr[i+1]
			return false
		end
	end
	true
end
#sorting takes more time than necessary

#optimized solution: hash to store and then check
def opt_unique?(str)
	exists = {}
	for i in 0..str.length-1
		if exists[str[i]]
			return false
		else
			exists[str[i]] = true
		end
	end
	true
end

#1.2 - check permutations

#create hash counters for each str, if the hashes are equal, return true

def permutation?(str1, str2)
	count1 = {}
	count2 = {}
	if str1.length != str2.length
		return false
	end
	for i in 0..str1.length-1
		if count1[str1[i]]
			count1[str1[i]] += 1
		else
			count1[str1[i]] = 1
		end
	end
	for i in 0..str2.length-1
		if count2[str2[i]]
			count2[str2[i]] += 1
		else
			count2[str2[i]] = 1
		end
	end
	if count1 == count2
		return true
	end
	false
end

#1.3 - Urlify

#

#1.4 - Palindrome Permutations - can a string be turned into a palindrome?

# make sure there are matches for each letter, if odd make sure only one letter has a count of one

def can_be_palindrome?(str)
	str.gsub!(/\s+/, "")
	letter_count = {}
	for i in 0..str.length-1
		if letter_count[str[i]]
			letter_count[str[i]] += 1
		else
			letter_count[str[i]] = 1
		end
	end
	odd_count = 0
	letter_count.each do |k,v|
		if v % 2 != 0
			odd_count += 1
		end
	end

	if str.length % 2 != 0 && odd_count == 1
		return true
	elsif str.length % 2 == 0 && odd_count == 0
		return true
	end
	false
end
#optimize: you can count odd as you are building the counting hash, if count is add subtract one, if count is even subtract one

#1.5 - One Away*

#draw out simple example, check if one away insert and removal in same method and then check replace
#insert/ removal: with just one shift over, strings should be the same, else false, basically check if an insert of s1 into s2 would work
#replacement: go through each letter and make sure that a count of one differences is not exceed

def one_away_insert(str1, str2)
	i1 = 0
	i2 = 0
	while i1 < str1.length && i2 < str2.length
		if str1[i1] != str2[i2]
			if i1 != i2 #if indexes are already offset and they don't equal, return false
				return false
			end
			i2 += 1
		else
			i1 += 1
			i2 += 1
		end
	end
	true
end


def replacement?(str1, str2)
	i1 = 0
	i2 = 0
	differences_count = 0
	while i1 < str1.length && i2 < str2.length
		if str1[i1] != str2[i2]
			differences_count += 1
		end
		if differences_count > 1
			return false
		end

		i1 +=1
		i2 +=1
	end
	
	true
end

def one_away(str1, str2)
	if str1.length - str2.length > 1
		return false
	elsif (str1.length - str2.length).abs == 1
		if one_away_insert(str1, str2) || one_away_insert(str2, str1)
			return true
		end
	elsif str1.length - str2.length == 0
		if replacement?(str1, str2)
			return true
		end
	end
			
	false
end
#possible change: can commbine insert and replacement methods, but it would be less readable

#1.6 - String Compression

# if none of the letters are repeated > 2 times, return original string
# create counter hash, iterating through it and printing it

def compress(str)
	letter_count = {}
	for i in 0..str.length-1
		if letter_count[str[i]]
			letter_count[str[i]] += 1
		else
			letter_count[str[i]] = 1
		end
	end
	compressed = ""
	letter_count.each {|k,v| compressed += "#{k}#{v}"}
	if compressed.length < str.length
		compressed
	else
		str
	end
end

#1.7 - Rotate Matrix

arr1 = [
	[1,2,3],
	[4,5,6],
	[7,8,9],
]

#if you flip diagonal, and then reverse, it should be the same as a right rotation of 90

def rotate_matrix(arr)

end

def transpose(arr)
	result = Array.new(arr.length,[])
	p result
	for i in 0..arr.length-1
		for j in 0..arr.length-1
			temp = arr[i][j]
			result[i][j] = arr[j][i]
			result[j][i] = temp
		end
	end
	result
end

#ic1 - return the largest profit
#make sure to buy before sell
#think about negative values - it's not max difference, it's max profit

#O(n^2)
# def apple_stocks(arr)
# 	max_diff = 0
# 	for i in 0..arr.length-2
# 		for j in i+1..arr.length-1
# 			if max_diff < (arr[j] - arr[i])
# 				max_diff = (arr[j] - arr[i])
# 			end
# 		end
# 	end
# 	max_diff
# end


def apple_stocks(arr)
	max_diff = 0
	min = arr[0]
	for i in 0..arr.length-1
		if arr[i] < min
			min = arr[i]
		end
		if (arr[i] - min) > max_diff
			max_diff = (arr[i] - min)
		end
	end
	max_diff
end

#ic2 - list of products, without current index
#account for zeros, no division
#iterate through twice

def products(arr)
	products = []
	product = 1
	for i in 0..arr.length-1
		products[i] = product
		product = product * arr[i]
	end
	i = arr.length - 1
	product = 1
	while i >= 0
		products[i] = products[i] * product
		product = arr[i] * product
		i -= 1
	end
	products
end

#ic3 - highest product of 3 integers
#find 3 highest values, save variables, multiply 3 variables together

def highest_product(arr)
	first = -1.0/0
	second = -1.0/0
	third = -1.0/0
	for i in 0..arr.length-1
		element = arr[i]
		if element >= first
			first = element
		elsif element > second
			second = element
		elsif element > third
			third = element
		end
	end
	first * second * third
end

#ic4 - merge overlapping intervals

def merge_overlap(arr)
	sorted = arr.sort_by {|e| [e[0]]}
	p sorted
	merged = []
	end_time = 0
	for i in 0..sorted.length-1
		if sorted[i][0] > end_time
			merged << [sorted[i][0], sorted[i][1]]
			end_time = sorted[i][1]
		elsif sorted[i][0] <= end_time && sorted[i][1] > end_time 
			merged.last[1] = sorted[i][1]
			end_time = sorted[i][1]
		end
	end
	merged
end

#ic5 - coin combinations
#try all combinations by recursively choosing each coin 0 to x amount of times until amount is zero
#basecases: have finished iterating through array, remainder == 0
#return ways
def change(amount, coin_arr, index)
	if amount == 0
		return 1
	end
	if index >= coin_arr.length
		return 0
	end

	amount_with_coin = 0
	ways = 0

	while amount_with_coin <= amount
		remainder = amount - amount_with_coin
		ways += change(remainder, coin_arr, index+1)
		amount_with_coin += coin_arr[index]
	end
	ways
end

def is_sub_array?(arr1, arr2)
	if arr1.length > arr2.length
		arr = arr1
		sub = arr2
	else
		arr = arr2
		sub = arr1
	end
	consecutive = 0
	for i in 0..arr.length-1

		if arr[i] == sub[consecutive]
			consecutive += 1
		else
			consecutive = 0
		end
		if consecutive == sub.length-1
			return true
		end
	end
	false
end

#dynamic programming: use matrix to iterate through str1 and compare it to single letter of str2
#if letters match take the count of the substring at letter before string one and string two + 1, if they don't, take highest number from previous iteration of str1 or str2
def common_longest_substring(str1, str2)
	x = str1.length
	y = str2.length 

	matrix = Array.new(x+1){Array.new(y+1,0)} #how to create a matrix in ruby

	for i in 0..x-1
		for j in 0..y-1
			if str1[i] == str2[j]
				matrix[i+1][j+1] = matrix[i][j] + 1
			else
				matrix[i+1][j+1] = [matrix[i+1][j], matrix[i][j+1]].max
			end
		end
	end
	matrix.last.last
end



#similar, but set count to zero if characters do not match, keep track of highest 
def longest_consecutive_substring(str1,str2)
	rows = str1.length
	cols = str2.length 

	matrix = Array.new(rows+1){Array.new(cols+1,0)}

	consecutive_count = 0
	for i in 0..rows-1
		for j in 0..cols-1
			if str1[i] == str2[j]
				previous_iteration = matrix[i][j]
				matrix[i+1][j+1] = previous_iteration + 1
				if previous_iteration + 1 > consecutive_count
					consecutive_count = previous_iteration + 1
				end
			else
				matrix[j+1][i+1] = 0
			end
		end
	end
	consecutive_count
end

#HR: Palindrome Index - Return index of character that could be removed to create palindrome
#start from begining and end, while deletion count > 0 and start>end
#if char match, move on, if not, move pointer whose next inside char has a match
def palindrome_index(string)
	check = ->(str){
		deletions = 0
		left = 0
		right = str.length-1
		d_index = 0
		while left < right #&& deletions < 2
			if str[left] == str[right]
				left += 1
				right -= 1
			elsif str[left + 1] == str[right] #delete left 
				deletions += 1
				d_index = left
				left += 1
			elsif str[left] == str[right - 1] #delete right
				deletions += 1
				d_index = right
				right -= 1
			else
				return -1
			end
		end
		if deletions == 0
			return -1
		else
			return d_index
		end
	}
	if check.call(string) == -1 && check.call(string.reverse) == -1
        return -1
    elsif check.call(string) != -1 && check.call(string.reverse) != -1
        return check.call(string)
    elsif check.call(string.reverse) != -1 && check.call(string) == -1
        return (string.length - 1) - check.call(string.reverse)
    elsif check.call(string.reverse) == -1 && check.call(string) != -1
        return check.call(string)
    end
end
#testcase: cwnnwcw - if method returns -1, check if the reverse is also -1

#1.9 - using is_substring once, check if a string is a rotation of another
#is substring - keep track of a count, if count == length of string, return true

def is_substring(str1, str2)
	if str2.length > str1.length
		sub = str1
		str = str2
	else
		sub = str2
		str = str1
	end
	p sub
	p str
	consecutive = 0
	for i in 0..str.length-1
		if str[i] == sub[consecutive]
			consecutive += 1
		else
			consecutive = 0
		end
		if consecutive == sub.length #has to come after consecutive is incremented
			return true
		end
	end
	false
end

def is_rotation?(str1, str2)
	concat = str1 + str1
	p concat

	if is_substring(concat, str2)
		true
	else
		false
	end
end



