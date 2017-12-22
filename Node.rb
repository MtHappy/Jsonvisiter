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