require './json_lexer'
require './Parser'

l = []

File.open("example0.json") do |io|
  while line = io.gets

=begin
strAry = line.split(" ")

strAry.each do |str|
	str.chomp!
	str.strip!
l << str
end
=end
	l << line
  end
end

puts l.join('*')

#字句解析器
mylex = JsonLexer.new(l)
p = Parser.new(mylex)
p.parse