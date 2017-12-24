require './lexer'
require './Node'
require './Perser'
require 'optparse'

params = ARGV.getopts('f:')

l = []

File.open(params["f"]) do |io|
  while line = io.gets
	   l << line
  end
end

#字句解析器
mylex = JsonLexer.new(l)
p = Parser.new(mylex)

puts "digraph {\n#{p.parse.show}}\n"