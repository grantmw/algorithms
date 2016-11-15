class LinkListNode
	attr_accessor :val, :next_node

	def initialize(val, next_node=nil)
		val = val
		next_node = next_node
	end
end

class BinaryTreeNode

	attr_accessor :val, :left_node, :right_node

	def initialize(val)
		@val = val
	end

	def insert(node_val)
		if self.val >= node_val
			if self.left_node
				left_node = self.left_node
				left_node.insert(node_val)
			else
				self.left_node = BinaryTreeNode.new(node_val)
			end
		elsif self.val < node_val
			if self.right_node
				right_node = self.right_node
				right_node.insert(node_val)
			else
				self.right_node = BinaryTreeNode.new(node_val)
			end
		end
	end

	def inorder_display
		if self.left_node
			self.left_node.inorder_display
		end

		print "#{self.val} "

		if self.right_node
			self.right_node.inorder_display
		end
	end

	def preorder_display
		print "#{self.val} "

		if self.left_node
			self.left_node.preorder_display
		end

		if self.right_node
			self.right_node.preorder_display
		end
	end
	def postorder_display

		if self.left_node
			self.left_node.preorder_display
		end

		if self.right_node
			self.right_node.preorder_display
		end

		print "#{self.val} "
	end

	def level_order_display
		queue = []
		queue << self
		while queue.length > 0
			curr_node = queue[0]
			print "#{curr_node.val} "
			if curr_node.left_node
				queue << curr_node.left_node
			end
			if curr_node.right_node
				queue << curr_node.right_node
			end
			queue.shift
		end
	end

	#recursively call height on left and right nodes
	#basecase: when input == nil, return -1
	#return: the higher of the two heights (aka max height) + 1
	def height(root = self)
		if root == nil 
			return -1 # return -1 if nul, because we add one to in recursive call to account for the current node
		end

		left_height = height(root.left_node)
		right_height = height(root.right_node)

		if left_height > right_height
			answer = left_height
		else
			answer = right_height
		end

		return answer + 1
	end


	#4.2
	#recursively make nodes at the middle of subarrays
	def self.make_min_tree(sorted_arr)
		self.min_tree(sorted_arr, 0, sorted_arr.length - 1)
	end

	def self.min_tree(sorted_arr, startdex, enddex)
		p sorted_arr
		p startdex
		p enddex
		midex = ((enddex + startdex) / 2).floor #not the difference/ 2
		mid = sorted_arr[midex]
		p midex
		if startdex > enddex
			return nil
		end
		root = BinaryTreeNode.new(mid)
		root.left_node = self.min_tree(sorted_arr, startdex, midex-1)
		root.right_node = self.min_tree(sorted_arr, midex + 1, enddex)
		root
	end

	#drivercode: BinaryTreeNode.make_min_tree([1,2,3,4,5]).inorder_display

	#4.8
	#compare two paths
	# def first_ancestor(root, node1, node2)
	# 	path1 = path_to(root, node1)
	# 	path2 = path_to(root, node2)

	# 	curr_node = root
	# 	for i in 0..path1.length-1
	# 		if path1[i] != path2[i]
	# 			return path1[i-1]
	# 		end
	# 	end
	# 	false
	# end

	# def path_to(root, node1)
	# 	curr_node = root
	# 	container = []
	# 	while curr_node
	# 		if curr_node == node1
	# 			container << curr_node
	# 			break
	# 		elsif curr_node.val < node1.val
	# 			container << curr_node
	# 			curr_node = curr_node.right_node
	# 		elsif curr_node.val >= node1.val
	# 			container << curr_node
	# 			curr_node = curr_node.left_node
	# 		end
	# 	end
	# 	container
	# end

	#check if the nodes are on left side, right side or opposite sides, recurse
	#if the nodes are opposite sides, return the root
	def first_ancestor(root, node1, node2)
		if node1.val <= root.val && node2.val <= root.val
			first_ancestor(root.left_node, node1, node2)
		elsif node1.val > root.val && node2.val > root.val
			first_ancestor(root.right_node, node1, node2)
		else
			return root
		end
	end

end

class BinaryTree

	attr_reader :root

	def initialize(root_val)
		@root = BinaryTreeNode.new(root_val)
	end

	def insert(node_val)
		curr_node = @root
		curr_node.insert(node_val)
	end

	def inorder_display
		@root.inorder_display
		puts
	end

	def preorder_display
		@root.preorder_display
		puts
	end

	def postorder_display
		@root.postorder_display
		puts
	end

	def level_order_display
		@root.level_order_display
	end

	# return -1 if nul, because we add one to in recursive call to account for the current node
	def height
		@root.height
	end


	#4.3 - Linked List of every depth ** finish
	# recursively make list of linked list nodes, increment depth
	def linked_list_levels(node = LinkListNode.new(1), depth = 0, lists = [] )
		p node
	end

	#4.4 - Check if balanced
	#balanced means that no left and right subtree differ in length greater than 1
	#brute force: checking height of every left and right
	#recursive: basecase: if input == nil, return true - to account for leaf nodes
	#check height difference, return false if > 1, else return method for left && right nodes
	def is_balanced?(root = @root)
		if root == nil
			return true
		end

		if root.left_node && root.right_node
			height_diff = (root.left_node.height-root.right_node.height).abs
		elsif root.left_node
			height_diff = (root.left_node.height)
		elsif root.right_node
			height_diff = (root.right_node.height)
		end

		if height_diff > 1
			return false
		else
			return is_balanced?(root.left_node) && is_balanced?(root.right_node)
		end
	end
	#*can optimize

	#4.5 - Is Binary Search Tree?
	#check if left is less than and right is greater than recursively, basecase node == nil
	#alternative: if left subtree max is less than, if right subtree max is greater than
	#alternative: use range, and recurse
	#solve brute force later


	def is_binary?(root = self.root, bottom = (-1.0/0), top = (1.0/0))
		if root == nil
			return true #make it all the way down to the bottom, return true
		end
		if root.val <= top && root.val > bottom && is_binary?(root.left_node, bottom, root.val) && is_binary?(root.right_node, root.val, top)
			return true
		else
			return false
		end
	end
	#alternative: inorder traversal and then see if the values are in order

	#4.7
	def creation_arrays
		
	end

	#4.8
	def first_ancestor(node1, node2)
		@root.first_ancestor(@root, node1, node2)
	end

	#4.10
	#unique if preorder AND inorder are the same
	def is_subtree?(tree1, tree2 = self)
		in1 = []
		pre1 = []
		in2 = []
		pre2 = []
		inorder = ->(root, arr) {
			if root.left_node
				inorder.call(root.left_node, arr)
			end
			arr << root.val
			if root.right_node
				inorder.call(root.right_node, arr)
			end
		}		
		preorder = ->(root, arr) {
			arr << root.val
			if root.left_node
				preorder.call(root.left_node, arr)
			# else
			# 	arr << "X"
			end
			if root.right_node
				preorder.call(root.right_node, arr)
			# else
			# 	arr << "X"
			end
		}
		inorder.call(tree1.root, in1)
		preorder.call(tree1.root, pre1)
		inorder.call(tree2.root, in2)
		preorder.call(tree2.root, pre2)

		is_subarray= ->(arr1, arr2) {
			if arr1.length > arr2.length
				arr = arr1
				sub = arr2
			else
				arr = arr2
				sub = arr1
			end
			consecutive = 0
			for i in 0..arr.length-1
				if consecutive == sub.length-1
					return true
				end

				if arr[i] == sub[consecutive]
					consecutive += 1
				else
					consecutive = 0
				end
			end
			false
		}

		if is_subarray.call(in1, in2) && is_subarray.call(pre1,pre2)
			true
		else
			false
		end		
	end
	#opt: can add in character where nodes point to nil, this way you can use only preorder
end



first = BinaryTree.new(10)
first.insert(12)
first.insert(11)
first.insert(20)
first.insert(15)
first.insert(9)
first.insert(7)
first.insert(14)
first.inorder_display
first.preorder_display

second = BinaryTree.new(12)
second.insert(11)
second.insert(20)
second.insert(15)
second.insert(14)
second.insert(9)
second.insert(10)
second.insert(1)
second.insert(2)
second.inorder_display
second.preorder_display

p first.is_subtree?(second)



