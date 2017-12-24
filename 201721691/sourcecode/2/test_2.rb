require './lexer'
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

$arw = "digraph {\n"
p.parse
$arw += "}\n"
puts $arw