
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

p transpose(arr1)
