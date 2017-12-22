require './lexer'

class Json_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Json"
    end

    def accept(v)
        v.visit(self)
    end
end

class Object_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Object"
    end

    def accept(v)
        v.visit(self)
    end
end

class Memberlist_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Memberlist"
    end

    def accept(v)
        v.visit(self)
    end
end

class Members_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Members"
    end

    def accept(v)
        v.visit(self)
    end
end

class Pair_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Pair"
    end

    def accept(v)
        v.visit(self)
    end
end

class Array_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Array"
    end

    def accept(v)
        v.visit(self)
    end
end

class Elements_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Elements"
    end

    def accept(v)
        v.visit(self)
    end
end

class Value_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Value"
    end

    def accept(v)
        v.visit(self)
    end
end

class Elementlist_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Elmentlist"
    end

    def accept(v)
        v.visit(self)
    end
end

class True_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "True"
    end

    def accept(v)
        v.visit(self)
    end
end

class False_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "False"
    end

    def accept(v)
        v.visit(self)
    end
end

class LBRA_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "LBRA"
    end

    def accept(v)
        v.visit(self)
    end
end

class RBRA_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "RBRA"
    end

    def accept(v)
        v.visit(self)
    end
end

class LBRACKET_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "LBRACKET"
    end

    def accept(v)
        v.visit(self)
    end
end

class RBRACKET_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "RBRACKET"
    end

    def accept(v)
        v.visit(self)
    end
end

class Comma_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Comma"
    end

    def accept(v)
        v.visit(self)
    end
end

class Colon_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Colon"
    end

    def accept(v)
        v.visit(self)
    end
end

class Null_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @lebel = "Null"
    end

    def accept(v)
        v.visit(self)
    end
end
  
class Int_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Int(#{@lexime})"
    end

    def accept(v)
        v.visit(self)
    end
end

class Float_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "Float(#{@lexime})"
    end

    def accept(v)
        v.visit(self)
    end
end

class String_node
    attr_reader :lexime,:children,:label
    
    def initialize(l,*c)
        @lexime = l
        @children = c
        @label = "String(#{@lexime[1..-2]})"
    end

    def accept(v)
        v.visit(self)
    end
end

class Json2dotVisitor
    @@nodeno = 0
    
    def initialize
        @nodes = {Json_node => lambda{|n| other_node(n)},
                  Object_node => lambda{|n| other_node(n)},
                  Members_node => lambda{|n| other_node(n)},
                  Memberlist_node => lambda{|n| other_node(n)},
                  Pair_node => lambda{|n| other_node(n)},
                  Array_node => lambda{|n| other_node(n)},
                  Elements_node => lambda{|n| other_node(n)},
                  Value_node => lambda{|n| other_node(n)},
                  Elementlist_node => lambda{|n| other_node(n)},
                  True_node => lambda{|n| t_node(n)},
                  False_node => lambda{|n| t_node(n)},
                  LBRA_node => lambda{|n| t_node(n)},
                  RBRA_node => lambda{|n| t_node(n)},
                  LBRACKET_node => lambda{|n| t_node(n)},
                  RBRACKET_node => lambda{|n| t_node(n)},
                  Comma_node => lambda{|n| t_node(n)},
                  Colon_node => lambda{|n| t_node(n)},
                  Null_node => lambda{|n| t_node(n)},
                  Int_node => lambda{|n| number_node(n)},
                  Float_node => lambda{|n| number_node(n)},
                  String_node => lambda{|n| string_node(n)}
                }
    end

    def visit(n)
        @nodes[n.class].call(n)
    end
  
    def other_node(n)
        s = ''
        if n.children == [] then
            s += makelabel(n.label)
            @@nodeno += 1
        else
            labelno = @@nodeno
            s += makelabel(n.label)
            @@nodeno += 1
            
            n.children.each{|c|
                if c != nil then
                    s += arrow("#{n.label}#{labelno}", "#{c.label}#{@@nodeno}")
                    s += c.accept(self)
                end
            }
        end
        s
    end
    
    def t_node(n)
        s = makelabel("#{n.label}")
        @@nodeno += 1
        s
    end
    
    def number_node(n)
        s = makelabel("#{n.label}")
        @@nodeno += 1
        s
    end
    
    def string_node(n)
        s = makelabel("#{n.label}")
        @@nodeno += 1
        s
    end
    
    def arrow(s, d)
        "  " + '"' + s + '" -> "' + d + '";' + "\n"
    end

    def makelabel(l)
        "  " + '"' + l + @@nodeno.to_s + '"' + '[label = "' + l + '"];' + "\n"
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

puts "digraph {\n#{p.parse.accept(Json2dotVisitor.new)}}\n"
