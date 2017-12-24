require './lexer'

class Node
    @@nodeno = 0

    def initialize(lexime,*children)
        @label = ''
        @lexime = lexime
        @children = children
    end

    def arrow(s, d)
        "  " + '"' + s + '" -> "' + d + '";' + "\n"
    end

    def makelabel(l)
        "  " + '"' + l + @@nodeno.to_s + '"' + '[label = "' + l + '"];' + "\n"
    end
    
    def getlabel()
        @label
    end
end

class Other_node < Node
  
    def initialize(lexime,*children)
        super(lexime,*children)
    end

    def show
        s = ''
        if @children == [] then
            s += makelabel(@label)
            @@nodeno += 1
        else
            labelno = @@nodeno
            s += makelabel(@label)
            @@nodeno += 1
            
            @children.each{|c|
                if c != nil then
                    s += arrow("#{@label}#{labelno}", "#{c.getlabel()}#{@@nodeno}")
                    s += c.show
                
                end
            }
        end
        s
    end
end

class Json_node < Other_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Json'
    end
    
end

class Object_node < Other_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Object'
    end
end

class Members_node < Other_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Members'
    end
end

class Memberlist_node < Other_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Memberlist'
    end
end

class Pair_node < Other_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Pair'
    end
end 

class Array_node < Other_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Array'
    end
end 

class Elements_node < Other_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Elements'
    end
end

class Value_node < Other_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Value'
    end
end 

class Elementlist_node < Other_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Elementlist'
    end
end 

class T_node < Node
    def initialize(lexime,*children)
        super(lexime,*children)
    end

    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class True_node < T_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'True'
    end
end

class False_node < T_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'False'
    end
end

class LBRA_node < T_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'LBRA'
    end
end

class RBRA_node < T_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'RBRA'
    end
end

class LBRACKET_node < T_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'LBRACKET'
    end
end

class RBRACKET_node < T_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'RBRACKET'
    end
end

class Comma_node < T_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Comma'
    end
end

class Colon_node < T_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Colon'
    end
end
      
class Null_node < T_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = 'Null'
    end
end
      
class Number_node < Node
    def initialize(lexime,*children)
        super(lexime,*children)
    end

    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class Int_node < Number_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = "Int(#{lexime})"
    end
end

class Float_node < Number_node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = "Float(#{lexime})"
    end
end

class String_node < Node
    def initialize(lexime,*children)
        super(lexime,*children)
        @label = "String(#{lexime[1..-2]})"
    end

    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

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

private

  def json
    children = []

    case @token
    when :lbra
      children << object
    when :lbracket
      children << array
    else
      errormsg('json', @token, "{#{:Object}}","[#{:Array}]")
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
    
    case @token
    when :string
      children = memberlist
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