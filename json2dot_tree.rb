require './lexer'
require './Node'

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
    
    Json_node.new(@lexime,*children)
  end

  def object
    
    children = []
    
    children << LBRA_node.new(@lexime)
    checktoken("lbra", :lbra)
    children << members
    children << RBRA_node.new(@lexime)
    checktoken("rbra", :rbra)
    
    Object_node.new(@lexime,*children)
  end

  def members
    children = []
    case @token
    when :string
      children << memberlist
    end
    Members_node.new(@lexime,*children)
  end

  def memberlist
    children = []   
    children << pair
    
    case @token
    when :comma
      while @token == :comma do
        children << Comma_node.new(@lexime)
        checktoken("params", :comma)
        children << pair
      end
    end
    
    Memberlist_node.new(@lexime,*children)
  end

  def pair
    children = []
    children << String_node.new(@lexime)
    checktoken("String", :string)
    children << Colon_node.new(@lexime)
    checktoken("colon", :colon)
    children << value
    
    Pair_node.new(@lexime,*children)
  end

  def array
    children = []
    children << LBRACKET_node.new(@lexime)
    checktoken("lbracket", :lbracket)
    children << element
    children << RBRACKET_node.new(@lexime)
    checktoken("rbracket", :rbracket)
    
    Array_node.new(@lexime, *children)
  end

  def element
    children = []
    case @token
    when :string, :int, :float, :true, :false, :null, :lbra, :lbracket
      children << elementlist
    end
    
    Elements_node.new(@lexime, *children)
  end

  def elementlist
    children = []
    children << value
    case @token
    when :comma
      while @token == :comma do
        children << Comma_node.new(@lexime)
        checktoken("comma", :comma)
        children << value
      end
    end
    Elementlist_node.new(@lexime,*children)
  end

  def value
    children = []
    
    case @token
    when :string
      children << String_node.new(@lexime)
      checktoken("string", :string)
    when :int
      children << Int_node.new(@lexime)
      checktoken("int", :int)
    when :float
      children << Float_node.new(@lexime)
      checktoken("float", :float)
    when :true
      children << True_node.new(@lexime)
      checktoken("true", :true)
    when :false
      children << False_node.new(@lexime)
      checktoken("false", :false)
    when :null
      children << Null_node.new(@lexime)
      checktoken("null", :null)
    when :lbra
      children << object
    when :lbracket
      children << array
    else
      errormsg("value", @token, :string, :int, :float,
               :true, :false, :null, :object, :array)
    end
    
    Value_node.new(@lexime, *children)
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

#puts p.parse
puts "digraph {\n#{p.parse.show}}\n"