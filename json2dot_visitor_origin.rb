require './lexer'

class SampleNode
	attr_reader :val
	def initialize(val)
		@val = val
	end

	def accept(v)
		v.visit(self)
	end
end

class SampleVisitor
	def initialize
		@nodes = {SampleNode => lambda{|n| n.val}, ...}
	end

	def visit(n)
		@nodes[n.class].call(n)
	end
end

tree = SampleNode.new(SampleNode_a.new(hoge))
puts tree.accept(SampleVisitor.new)