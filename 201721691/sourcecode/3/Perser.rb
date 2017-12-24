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
    
    case @token
    when :lbra
      children = object
    when :lbracket
      children = array
    else
      errormsg('json', @token, "{#{:Object}}","[#{:Array}]")
    end
    
    Json_node.new(children)
  end

  def object
    
    children = []
    
    children << LBRA_node.new()
    checktoken("lbra", :lbra)
    children << members
    children << RBRA_node.new()
    checktoken("rbra", :rbra)
    
    Object_node.new(*children)
  end

  def members
    children = []
    
    case @token
    when :string
      children << memberlist
    end
    Members_node.new(*children)
  end

  def memberlist
    children = []   
    children << pair
    
    case @token
    when :comma
      while @token == :comma do
        children << Comma_node.new()
        checktoken("params", :comma)
        children << pair
      end
    end
    
    Memberlist_node.new(*children)
  end

  def pair
    children = []
    children << String_node.new(@lexime)
    checktoken("String", :string)
    children << Colon_node.new()
    checktoken("colon", :colon)
    children << value
    
    Pair_node.new(*children)
  end

  def array
    children = []
    children << LBRACKET_node.new()
    checktoken("lbracket", :lbracket)
    children << element
    children << RBRACKET_node.new()
    checktoken("rbracket", :rbracket)
    
    Array_node.new(*children)
  end

  def element
    children = []
    case @token
    when :string, :int, :float, :true, :false, :null, :lbra, :lbracket
      children << elementlist
    end
    
    Elements_node.new(*children)
  end

  def elementlist
    children = []
    children << value
    case @token
    when :comma
      while @token == :comma do
        children << Comma_node.new()
        checktoken("comma", :comma)
        children << value
      end
    end
    Elementlist_node.new(*children)
  end

  def value
    
    case @token
    when :string
      children = String_node.new(@lexime)
      checktoken("string", :string)
    when :int
      children = Int_node.new(@lexime)
      checktoken("int", :int)
    when :float
      children = Float_node.new(@lexime)
      checktoken("float", :float)
    when :true
      children = True_node.new()
      checktoken("true", :true)
    when :false
      children = False_node.new()
      checktoken("false", :false)
    when :null
      children = Null_node.new()
      checktoken("null", :null)
    when :lbra
      children = object
    when :lbracket
      children = array
    else
      errormsg("value", @token, :string, :int, :float,
               :true, :false, :null, :object, :array)
    end
    
    Value_node.new(children)
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