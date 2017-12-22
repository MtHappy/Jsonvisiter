require './lexer'

class Parser
  @lexime = "";

  def initialize(l)
    @lexer = l
  end

  def parse
    @lexer.lex{|t, l|
      @lexime = l
      @token = t
    }
    json
  end

  def json
    case @token
      when :lbra
        object
      when :lbracket
        array
      else
        errormsg('json', @token, "{#{:Object}}","[#{:Array}]")
      end
  end

  def object
    checktoken("lbra", :lbra)
    members
    checktoken("rbra", :rbra)
  end

  def members
    case @token
    when :string
      memberlist
    end
  end

  def memberlist
    pair
    while @token == :comma do
      checktoken("params", :comma)
      pair
    end
  end

  def pair
    checktoken("string", :string)
    checktoken("colon", :colon)
    value
  end

  def array
    checktoken("lbracket", :lbracket)
    element
    checktoken("rbracket", :rbracket)
  end

  def element
    case @token
    when :string, :int, :float, :true, :false, :null, :lbra, :lbracket
      elementlist
    end
  end

  def elementlist
    value
    case @token
    when :comma
      while @token == :comma do
        checktoken("comma", :comma)
        value
      end
    end
  end

  def value
    case @token
      when :string
        checktoken("string", :string)
      when :int
        checktoken("int", :int)
      when :float
        checktoken("float", :float)
      when :true
        checktoken("true", :true)
      when :false
        checktoken("false", :false)
      when :null
        checktoken("null", :null)
      when :lbra
        object
      when :lbracket
        array
      else
        errormsg("value", @token, :string, :int, :float,
                 :true, :false, :null, :object, :array)
      end
  end

  def checktoken(f, expected)
    if @token == expected
      @lexer.lex(){|t,l|
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
p.parse