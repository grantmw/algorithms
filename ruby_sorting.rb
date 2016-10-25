require 'rubocop'
require 'benchmark'

unsorted = [5, 4, 3, 2, 1, 7, 8, 9]
sorted = [1, 2, 3, 25]

def bubble_sort(arr)
  arr.length.times do
    for i in 0..arr.length - 2
      if arr[i] > arr[i + 1]
        temp = arr[i]
        arr[i] = arr[i + 1]
        arr[i + 1] = temp
      end
    end
  end
  arr
end

def selection_sort(arr)
  for i in 0..arr.length - 2
    mindex=i
    for j in 1..arr.length - 1
      if arr[j] < arr[i]
        mindex = j
      end
    end
    temp = arr[i]
    arr[i] = arr[mindex]
    arr[mindex] = temp
  end
  arr
end

def insertion_sort(arr) # sorted portion and unsorted portion
  for i in 1..arr.length-1
    element = arr[i]
    j = i
    while (j > 0) && (element < arr[j - 1])
      arr[j] = arr[j - 1] # element saves arr[j], and opens up a space by copying the left element to the current element
      j -= 1
    end
    arr[j] = element
  end
  arr
end

def partition(arr, startdex, enddex) #for quicksort
  pivot = arr[enddex] # elements less than pivot will be to the left of the pivot, greater than --> to the right
  partition_index = startdex
  for i in startdex..enddex - 1
    if arr[i] <= pivot
      temp = arr[i]
      arr[i] = arr[partition_index]
      arr[partition_index] = temp # swap if element is less than pivot
      partition_index += 1
    end
  end
  temp = arr[partition_index]
  arr[partition_index] = pivot
  arr[enddex] = temp # swap partition element and pivot
  partition_index
end

def partition_call(arr, startdex, enddex)
  if startdex < enddex # partition only if the partitioned array is more than 1 elements long
    partition_index = partition(arr, startdex, enddex)
    partition_call(arr, startdex, partition_index - 1) # partition the lesser half
    partition_call(arr, partition_index, enddex) # partition the greater half
    arr
  end
end

def quick_sort(arr)
  partition_call(arr, 0, arr.length - 1)
end

def merge_sort_logic(left, right, arr) # pass array to not create new array, array will be the array left/right should be merging into
  l_length = left.length
  r_length = right.length
  i = j = k = 0 # indices of left right and arr
  while (i < l_length) && (j < r_length)
    if left[i] <= right[j]
      arr[k] = left[i]
      k += 1
      i += 1
    elsif left[i] > right[j]
      arr[k] = right[j]
      k += 1
      j += 1
    end
  end
  while i < l_length
    arr[k] = left[i]
    k += 1
    i += 1
  end
  while j < r_length
    arr[k] = right[j]
    k += 1
    j += 1
  end
  arr
end

def merge_sort(arr)
  return arr if arr.length < 2
  left = []
  right = []
  midex = ((arr.length) / 2).floor
  for i in 0...midex
    left << arr[i]
  end
  for i in midex..arr.length - 1
    right << arr[i]
  end
  merge_sort(left)
  merge_sort(right)
  merge_sort_logic(left, right, arr)
end

puts Benchmark.measure { merge_sort(unsorted) }
puts Benchmark.measure { bubble_sort(unsorted) }
puts Benchmark.measure { selection_sort(unsorted) }
puts Benchmark.measure { insertion_sort(unsorted) }

    # a = ["{","[","(",")","]","}"]
    # if a.length % 2 != 0
    #     puts "NO"
    #     next
    # end
    # left = []
    # right = []
    # mid = (a.length / 2) - 1
    # for i in 0..a.length-1
    #     if i <= mid
    #         left << a[i]
    #     else
    #         right << a[i]
    #     end
    # end
    # for i in 0..right.length-1
    #     if right[i] == ")"
    #         right[i] = "("
    #     elsif right[i] == "]"
    #         right[i] = "["
    #     elsif right[i] == "}"
    #         right[i] = "{"
    #     end
    # end
    # if left != right.reverse
    #     puts "NO"
    #     next
    # else
    #     puts "YES"
    #     next
    # end
    # count = 0
    # a.each do |br|
    #     if (br == "(") || (br == "[") || (br == "{")
    #         count += 1
    #     else
    #         count -= 1
    #     end
    #     if count < 0
    #         puts "No"
    #         next
    #     end
    # end
    
    
    # if count != 0
    #     puts "No"
    #     next
    # elsif count == 0
    #     puts "YES"
    #     next
    # end
