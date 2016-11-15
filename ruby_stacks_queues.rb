class Stack
	def initialize
		@stack = []
		@min = []
	end

	def pop
		@min.pop
		@stack.pop
	end

	def push(data)
		if is_empty? == true || data < @min.last
			@min << data
		else
			@min << @min.last
		end

		@stack << data
		self
	end

	def peek
		@stack.last
	end

	def is_empty?
		if @stack.length == 0
			true
		else
			false
		end
	end

	def display
		p @stack
	end

	#3.2
	#min saved as variable, must update with push and pop
	#create min stack that stores the minimum value in sync with push and pop
	def min
		@min.last
	end

	#3.4 - implement queue
	#use two stacks, empty stack into other stack until X(the oldest element) is reached, add back into original stack
	
end

class Queue
	def initialize
		@queue = []
	end

	def add(data)
		@queue << data
		self
	end

	def remove
		@queue.shift(1)
	end

	def peek
		@queue.first
	end

	def is_empty?
		if @queue.length == 0
			true
		else
			false
		end
	end

	def display
		p @queue
	end
end

