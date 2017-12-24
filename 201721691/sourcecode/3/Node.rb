class Node
    
    @@nodeno = 0
  
    def arrow(s, d)
        "  " + '"' + s + '" -> "' + d + '";' + "\n"
    end
    
    def makelabel(l)
        "  " + '"' + l + @@nodeno.to_s + '"' + '[label = "' + l + '"];' + "\n"
    end
end

class Json_node < Node
    
    attr_reader :label,:children
    
    def initialize(children)
        @children = children
        @label = 'Json'
    end
  
    def show
        s = ''
        labelno = @@nodeno
        s += makelabel(@label)
        @@nodeno += 1
        s += arrow("#{@label}#{labelno}", "#{@children.label}#{@@nodeno}")
        s += @children.show
        s
    end
end

class Object_node < Node
    attr_reader :label,:children
  
    def initialize(*children)
        @children = children
        @label = 'Object'
    end
  
    def show
        s = ''
        labelno = @@nodeno
        s += makelabel(@label)
        @@nodeno += 1
        
        s += arrow("#{@label}#{labelno}", "#{@children[0].label}#{@@nodeno}")
        s += @children[0].show
      
        s += arrow("#{@label}#{labelno}", "#{@children[1].label}#{@@nodeno}")
        s += @children[1].show
      
        s += arrow("#{@label}#{labelno}", "#{@children[2].label}#{@@nodeno}")
        s += @children[2].show
        s
    end
end

class Members_node < Node
    attr_reader :label,:children
  
    def initialize(*children)
        @children = children
        @label = 'Members'
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
            s += arrow("#{@label}#{labelno}", "#{@children[0].label}#{@@nodeno}")
            s += @children[0].show
        end
        s
    end
    
end

class Memberlist_node < Node
    attr_reader :label,:children
  
    def initialize(*children)
        @children = children
        @label = 'Memberlist'
    end
    
    def show
        s = ''
        labelno = @@nodeno
        s += makelabel(@label)
        @@nodeno += 1
        
        @children.each{|c|
            if c != nil then
                s += arrow("#{@label}#{labelno}", "#{c.label}#{@@nodeno}")
                s += c.show

            end
        }
        s
    end
    
end

class Pair_node < Node
    attr_reader :label,:children
  
    def initialize(*children)
        @children = children
        @label = 'Pair'
    end
    
    def show
        s = ''
        labelno = @@nodeno
        s += makelabel(@label)
        @@nodeno += 1
        
        s += arrow("#{@label}#{labelno}", "#{@children[0].label}#{@@nodeno}")
        s += @children[0].show
      
        s += arrow("#{@label}#{labelno}", "#{@children[1].label}#{@@nodeno}")
        s += @children[1].show
      
        s += arrow("#{@label}#{labelno}", "#{@children[2].label}#{@@nodeno}")
        s += @children[2].show
        s
    end
        
end 

class Array_node < Node
    attr_reader :label,:children
  
    def initialize(*children)
        @children = children
        @label = 'Array'
    end
  
    def show
        s = ''
        labelno = @@nodeno
        s += makelabel(@label)
        @@nodeno += 1
        s += arrow("#{@label}#{labelno}", "#{@children[0].label}#{@@nodeno}")
        s += @children[0].show
        s += arrow("#{@label}#{labelno}", "#{@children[1].label}#{@@nodeno}")
        s += @children[1].show
        s += arrow("#{@label}#{labelno}", "#{@children[2].label}#{@@nodeno}")
        s += @children[2].show
        s
    end
    
end 

class Elements_node < Node
    attr_reader :label,:children
  
    def initialize(*children)
        @children = children
        @label = 'Elements'
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
            s += arrow("#{@label}#{labelno}", "#{@children[0].label}#{@@nodeno}")
            s += @children[0].show
        end
        s
    end
    
end

class Value_node < Node
    attr_reader :label,:children
  
    def initialize(children)
        @children = children
        @label = 'Value'
    end
  
    def show
        s = ''
        labelno = @@nodeno
        s += makelabel(@label)
        @@nodeno += 1
        s += arrow("#{@label}#{labelno}", "#{@children.label}#{@@nodeno}")
        s += @children.show
        s
    end
    
end 

class Elementlist_node < Node
    attr_reader :label,:children
  
    def initialize(*children)
        @children = children
        @label = 'Elementlist'
    end
  
    def show
        s = ''
        labelno = @@nodeno
        s += makelabel(@label)
        @@nodeno += 1
        
        @children.each{|c|
            if c != nil then
                s += arrow("#{@label}#{labelno}", "#{c.label}#{@@nodeno}")
                s += c.show
            end
        }
        s
    end
end 

class True_node < Node
    attr_reader :label,:children
    
    def initialize()
        @label = 'True'
    end
  
    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class False_node < Node
    attr_reader :label,:children
    
    def initialize()
        @label = 'False'
    end
  
    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class LBRA_node < Node
    attr_reader :label,:children
    
    def initialize()
        @label = 'LBRA'
    end
  
    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class RBRA_node < Node
    attr_reader :label,:children
    
    def initialize()
        @label = 'RBRA'
    end
  
    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class LBRACKET_node < Node
    attr_reader :label,:children
    
    def initialize()
        @label = 'LBRACKET'
    end
  
    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class RBRACKET_node < Node
    attr_reader :label,:children
    
    def initialize()
        @label = 'RBRACKET'
    end
  
    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class Comma_node < Node
    attr_reader :label,:children
    
    def initialize()
        @label = 'Comma'
    end
  
    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class Colon_node < Node
    attr_reader :label,:children
    
    def initialize()
        @label = 'Colon'
    end
  
    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end
      
class Null_node < Node
    attr_reader :label,:children
    
    def initialize()
        @label = 'Null'
    end
  
    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class Int_node < Node
    attr_reader :label,:children
    
    def initialize(lexime)
        @label = "Int(#{lexime})"
    end
  
    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class Float_node < Node
    attr_reader :label,:children
    
    def initialize(lexime)
        @label = "Float(#{lexime})"
    end
  
    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end

class String_node < Node
    attr_reader :label,:children
    
    def initialize(lexime)
        @label = "String(#{lexime[1..-2]})"
    end

    def show
        s = makelabel("#{@label}")
        @@nodeno += 1
        s
    end
end
