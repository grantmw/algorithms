class Node
	attr_accessor :val, :next_node

	def initialize(val, next_node = nil)
		@val = val
		@next_node = next_node
	end

end

class LinkList
	attr_accessor :head

	def initialize(head_val)
		@head = Node.new(head_val)
	end

	def display
		curr_node = @head
		while curr_node
			print "#{curr_node.val} "
			curr_node = curr_node.next_node
		end
		puts
	end

	def push(new_val)
		curr_node = @head
		while curr_node.next_node
			curr_node = curr_node.next_node
		end
		curr_node.next_node = Node.new(new_val)
		self
	end

	def add(node) #adds a node to the list, not just a value, will bring following nodes with
		curr_node = @head
		while curr_node.next_node
			curr_node = curr_node.next_node
		end
		curr_node.next_node = node
		self
	end


	def delete(node) #take val from next node, then delete next node #main issue: the current node that is deleted will become next node, and next node will be skipped in loop
		p "delete"
		temp = node.next_node
		if node.next_node == nil
			node = nil
		else
			node.val = node.next_node.val
			node.next_node = node.next_node.next_node
		end
		temp = nil
		self
	end

	def delete_at(position)
		if position == 0
			temp = @head
			@head = @head.next_node
			temp = nil
			return self
		end
		curr_node = @head
		for i in 0..position-2 #stop when current node is one before the one to be deleted, which means stopping iteration two before - so you can set current node to the node before deleted node
			curr_node = curr_node.next_node
		end
		temp = curr_node.next_node
		if curr_node.next_node.next_node
			curr_node.next_node = curr_node.next_node.next_node
		else
			curr_node.next_node = nil
		end
		temp = nil
	end

	def length
		length = 0
		curr_node = @head
		while curr_node
			length += 1
			curr_node = curr_node.next_node
		end
		length
	end

	def reverse #create previous variable
		curr_node = @head
		previous = nil
		while curr_node
			temp_next = curr_node.next_node
			curr_node.next_node = previous
			@head = curr_node #after setting the next node to previous, update the end to the current node
			previous = curr_node
			curr_node = temp_next
		end
		
		self
	end

	#2.1
	def remove_dups
		curr_node = @head
		counter = {}
		position = 0
		to_delete_at = [] 
		while curr_node
			if counter[curr_node.val]
				to_delete_at.push(position)
			else
				counter[curr_node.val] = 1
			end
			curr_node = curr_node.next_node
			position += 1
		end
		to_delete_at.each_with_index {|num, i| delete_at(num - i)} #have to adjust delete positions, because list shortens after delete
		self
	end

	#2.2
	def k_to_last(k)
		curr_node = @head
		nth_position = self.length - k
		for i in 0..nth_position-1
			curr_node = curr_node.next_node
		end
		curr_node
	end

	def recursive_k_to_last(k, curr_node)
		if curr_node == nil
			return 0
		end
		counter = recursive_k_to_last(k, curr_node.next_node) + 1
		if counter == k
			p curr_node
		end
		counter
	end

	#2.4*

	#start new list, think of given node as a pivot
	def partition(node)
		new_head = node
		new_tail = node
		curr_node = @head
		while curr_node
			p curr_node.val 
			temp_next = curr_node.next_node #***
			if curr_node.val < node.val
				curr_node.next_node = new_head
				new_head = curr_node
			else
				new_tail.next_node = curr_node
				new_tail = curr_node
				curr_node.next_node = nil
			end
			curr_node = temp_next
		end
		@head = new_head
	end

	#2.5*create lambda, procs will return out of surrounding function
	#add and carry over like general arith

	def self.sum(list1, list2)
		node1 = list1.head
		node2 = list2.head
		carry_over = 0
		what_to_add = lambda do |n1,n2,co| #lambdas have their aruments in higher priority than outside variables
			sum = n1.val + n2.val + co
			if sum < 10
				carry_over = 0
				return sum
			else
				carry_over = 1
				return sum - 10
			end
		end
		if node1 == list1.head #if first nodes, make new list
			sum_list = LinkList.new(what_to_add.call(node1,node2,carry_over))
			node1 = node1.next_node
			node2 = node2.next_node
		end
		while node1 && node2
			sum_list.push(what_to_add.call(node1,node2,carry_over))
			node1 = node1.next_node
			node2 = node2.next_node
		end
		while node1
			sum = node1.val + carry_over
			if sum < 10
				carry_over = 0
				sum_list.push(sum)
			else
				carry_over = 1
				sum_list.push(0)
			end
			node1 = node1.next_node
		end
		while node2
			sum = node2.val + carry_over
			if sum < 10
				carry_over = 0
				sum_list.push(sum)
			else
				carry_over = 1
				sum_list.push(0)
			end
			node2 = node2.next_node
		end
		if carry_over > 0
			sum_list.push(carry_over)
		end
		sum_list.display
	end

	# 2.6 - Palindrome
	#reverse list, compare list and reversed list
	#alternative - create stack

	def is_palindrome
		stack = []
		curr_node = @head
		while curr_node
			stack.push(curr_node.val)
			curr_node = curr_node.next_node
		end
		curr_node = @head #reset curr_node to start from beginning of ll
		while curr_node
			if curr_node.val != stack.pop
				return false
			end
			curr_node = curr_node.next_node
		end
		true
	end
	#opt: only half of list needs to be compaired to the half of the reverse list


	# 2.7 - Find Intersecting Node
	# if lists combine, they will have the same ending nodes
	# check length, delete head of longer list and check if nodes are equal
	def self.find_intersection(list1,list2)

		n1 = list1.head
		n2 = list2.head

		match = lambda do |node1, node2|
			if node1 == node2
				return node1
			end
		end

		while n2 && n1
			if match.call(n1, n2)
				return n1
			end
			if list1.length > list2.length
				n1 = n1.next_node
			elsif list1.length < list2.length
				n2 = n1.next_node
			else
				n1 = n1.next_node
				n2 = n2.next_node
			end
			false
		end

		if list1.head = list2.head
			return list1.head
		end



	end
end
# driver test for 2.5
# test2 = LinkList.new(6).push(7).push(8).push(9)
# test2.display
# test3 = LinkList.new(1).push(2).push(3)
# test3.display
# LinkList.sum(test2,test3)

a = Node.new(11)
b = Node.new(12)
c = Node.new(13)
test1 = LinkList.new(1)
test1.push(2)
test1.push(3)
test2 = LinkList.new(4)
test2.push(5)
test2.push(6)

test1.add(a).add(b).add(c)
test2.add(a)

test1.display
test2.display
p LinkList.find_intersection(test1,test2)
