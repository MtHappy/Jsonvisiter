require './lexer'
require './Node_naive'

class Parser
  @lexime = "";

  def initialize(l)
    @lexer = l
  end

  def parse
    @lexer.lex{|t,l|
      @lexime = l
      @token = t
    }
    json
  end

  def json
    children = []

    case @token
    when :lbra
      children << object
    when :lbracket
      children << array
    end
    
    Node.new("Json", @lexime,*children)
  end

  def object
    children = []
    
    children << Node.new("LBRA", @lexime)
    checktoken("lbra", :lbra)
    children << members
    children << Node.new("RBRA", @lexime)
    checktoken("rbra", :rbra)
    
    Node.new("Object", @lexime,*children)
  end

  def members
    children = []
    case @token
    when :string
      children << memberlist
    end
    Node.new("Members", @lexime,*children)
  end

  def memberlist
    children = []   
    children << pair
    
    case @token
    when :comma
      while @token == :comma do
        children << Node.new("Comma", @lexime)
        checktoken("params", :comma)
        children << pair
      end
    end
    
    Node.new("Memberlist",*children)
  end

  def pair
    children = []
    children << Node.new("String(#{@lexime[1..-2]})", @lexime[1..-2])
    checktoken("String", :string)
    children << Node.new("Colon", @lexime)
    checktoken("colon", :colon)
    children << value
    
    Node.new("Pair",*children)
  end

  def array
    children = []
    children << Node.new("LBRACKET", @lexime)
    checktoken("lbracket", :lbracket)
    children << element
    children << Node.new("RBRACKET", @lexime)
    checktoken("rbracket", :rbracket)
    
    Node.new("Array", @lexime, *children)
  end

  def element
    children = []
    case @token
    when :string, :int, :float, :true, :false, :null, :lbra, :lbracket
      children << elementlist
    end
    
    Node.new("Element", @lexime, *children)
  end

  def elementlist
    children = []
    children << value
    case @token
    when :comma
      while @token == :comma do
        children << Node.new("Comma", @lexime)
        checktoken("comma", :comma)
        children << value
      end
    end
    Node.new("Elementlist", @lexime,*children)
  end

  def value
    children = []
    
    case @token
    when :string
      children << Node.new("String(#{@lexime[1..-2]})", @lexime[1..-2])
      checktoken("string", :string)
    when :int
      children << Node.new("Int(#{@lexime})", @lexime)
      checktoken("int", :int)
    when :float
      children << Node.new("Float(#{@lexime})", @lexime)
      checktoken("float", :float)
    when :true
      children << Node.new("True", @lexime)
      checktoken("true", :true)
    when :false
      children << Node.new("False", @lexime)
      checktoken("false", :false)
    when :null
      children << Node.new("Null", @lexime)
      checktoken("null", :null)
    when :lbra
      children << object
    when :lbracket
      children << array
    else
      errormsg("value", @token, :string, :int, :float,
               :true, :false, :null, :object, :array)
    end
    
    Node.new("Value", @lexime, *children)
  end

  def checktoken(f, expected)
    if @token == expected
      @lexer.lex(){|t,l|
        @lexime = l
        @token=t
      }
    else
      errormsg(f, @token, expected)
    end
  end

  def errormsg(f, et, *tokens)
    tks = tokens.join(" or ")
    puts "syntax error (#{f}(#{et})) : #{tks} is expected."
    exit(1)
  end
end

l = []

File.open("example0.json") do |io|
  while line = io.gets
    l << line
  end
end

#字句解析器
mylex = JsonLexer.new(l)
p = Parser.new(mylex)
puts "digraph {\n#{p.parse.show}}\n"