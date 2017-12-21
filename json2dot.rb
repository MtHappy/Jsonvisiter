require './lexer'

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

    $arw += makelabel("Json")
    label = $nodeno
    $nodeno+=1

    case @token
      when :lbra
        $arw += makelabel("Object")
        $arw += arrow("Json#{label}", "Object#{$nodeno}")

        object
      when :lbracket
        $arw += makelabel("Array")
        $arw += arrow("Json#{label}", "Array{$nodeno}")
        $nodeno+=1
        array
      end
  end

  def object

    label = $nodeno
    $nodeno+=1

    $arw += makelabel("Lbra")
    $arw += arrow("Object#{label}", "Lbra#{$nodeno}")
    $nodeno+=1
    checktoken("lbra", :lbra)

    $arw += makelabel("Members")
    $arw += arrow("Object#{label}", "Members#{$nodeno}")

    members

    $arw += makelabel("Rbra")
    $arw += arrow("Object#{label}", "Rbra#{$nodeno}")
    $nodeno+=1
    checktoken("rbra", :rbra)

  end

  def members
    case @token
    when :string
      label = $nodeno
      $nodeno+=1

      $arw += makelabel("Memberlist")
      $arw += arrow("Members#{label}", "Memberlist#{$nodeno}")
      
      memberlist
    end
  end

  def memberlist
    case @token
    when :string
      label = $nodeno
      $nodeno+=1

      $arw += makelabel("Pair")
      $arw += arrow("Memberlist#{label}", "Pair#{$nodeno}")
      
      pair

      while @token == :comma do

        $arw += makelabel("Comma")
        $arw += arrow("Memberlist#{label}", "Comma#{$nodeno}")
        $nodeno+=1
        checktoken("params", :comma)

        $arw += makelabel("Pair")
        $arw += arrow("Memberlist#{label}", "Pair#{$nodeno}")
        
        pair
      end
    end
  end

  def pair
    label = $nodeno
    $nodeno+=1

    $arw += makelabel("String(#{@lexime[1...-1]})")
    $arw += arrow("Pair#{label}", "String(#{@lexime[1...-1]})#{$nodeno}")
    $nodeno+=1
    checktoken("pair", :string)

    $arw += makelabel("Colon")
    $arw += arrow("Pair#{label}", "Colon#{$nodeno}")
    $nodeno+=1
    checktoken("colon", :colon)

    $arw += makelabel("Value")
    $arw += arrow("Pair#{label}", "Value#{$nodeno}")
    
    value

  end

  def array
    label = $nodeno
    $nodeno+=1

    $arw += makelabel("Lbracket")
    $arw += arrow("Array#{label}", "Lbracket#{$nodeno}")
    $nodeno+=1
    checktoken("lbracket", :lbracket)

    $arw += makelabel("Elements")
    $arw += arrow("Array#{label}", "Elements#{$nodeno}")
    
    element

    $arw += makelabel("Rbracket")
    $arw += arrow("Array#{label}", "Rbracket#{$nodeno}")
    $nodeno+=1
    checktoken("rbracket", :rbracket)
  end

  def element
    label = $nodeno
    $nodeno+=1

    case @token
    when :string, :int, :float, :true, :false, :null, :lbra, :lbracket

      $arw += makelabel("Elementlist")
      $arw += arrow("Elements#{label}", "Elementlist#{$nodeno}")
      
      elementlist
    end
  end

  def elementlist
    label = $nodeno
    $nodeno+=1

    $arw += makelabel("Value")
    $arw += arrow("Elementlist#{label}", "Value#{$nodeno}")
    
    value

    case @token
    when :comma
      while @token == :comma do

        $arw += makelabel("Comma")
        $arw += arrow("Elementlist#{label}", "Comma#{$nodeno}")
        $nodeno+=1
        checktoken("comma", :comma)

        $arw += makelabel("Value")
        $arw += arrow("Elementlist#{label}", "Value#{$nodeno}")
        
        value
      end
    end
  end

  def value
    label = $nodeno
    $nodeno+=1

    case @token
      when :string
        $arw += makelabel("String(#{@lexime[1...-1]})")
        $arw += arrow("Value#{label}", "String(#{@lexime[1...-1]})#{$nodeno}")
        $nodeno+=1
        checktoken("string", :string)
      when :int
        $arw += makelabel("Int(#{@lexime})")
        $arw += arrow("Value#{label}", "Int(#{@lexime})#{$nodeno}")
        $nodeno+=1
        checktoken("int", :int)
      when :float
        $arw += makelabel("Float(#{@lexime})")
        $arw += arrow("Value#{label}", "Float(#{@lexime})#{$nodeno}")
        $nodeno+=1
        checktoken("float", :float)
      when :true
        $arw += makelabel("True")
        $arw += arrow("Value#{label}", "True#{$nodeno}")
        $nodeno+=1
        checktoken("true", :true)
      when :false
        $arw += makelabel("False")
        $arw += arrow("Value#{label}", "False#{$nodeno}")
        $nodeno+=1
        checktoken("false", :false)
      when :null
        $arw += makelabel("Null")
        $arw += arrow("Value#{label}", "Null#{$nodeno}")
        $nodeno+=1
        checktoken("null", :null)
      when :lbra
        $arw += makelabel("Object")
        $arw += arrow("Value#{label}", "Object#{$nodeno}")
        
        object
      when :lbracket
        $arw += makelabel("Array")
        $arw += arrow("Value#{label}", "Array#{$nodeno}")
        
        array
      else
        errormsg("value", @token, :string, :int, :float,
                 :true, :false, :null, :object, :array)
      end
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

  def arrow(s, d)
    "  " + '"' + s + '" -> "' + d + '";' + "\n"
  end

  def makelabel(l)
    "  " + '"' + l + $nodeno.to_s + '"' + '[label = "' + l + '"];' + "\n"
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

$arw = "digraph {\n"
$nodeno = 0
p.parse
$arw += "}\n"
puts $arw