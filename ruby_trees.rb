class BinaryTreeNode

	attr_accessor :val, :left_node, :right_node

	def initialize(val)
		@val = val
	end

	def insert(node_val)
		if node_val <= self.val
			if self.left_node == nil
				self.left_node = BinaryTreeNode.new(node_val)
			else
				curr_node = self.left_node
				curr_node.insert(node_val)
			end
		elsif node_val > self.val
			if self.right_node == nil
				self.right_node = BinaryTreeNode.new(node_val)
			else
				curr_node = self.right_node
				curr_node.insert(node_val)
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

end

first = BinaryTree.new(10)
first.insert(11)
first.insert(14)
first.insert(12)
first.insert(9)
first.insert(7)

first.inorder_display
first.preorder_display
first.postorder_display
# p first.root
# p first.root.left_node
# p first.root.left_node.right_node
# p first.root