class Node
    @@nodeno = 0

    def initialize(label, lexime,*children)
        @label = label
        @lexime = lexime
        @children = children
    end
  
    def show
        s = ""
        if @children == [] then
          
          case @label
            when 'String','Int', 'Float'
              s += makelabel("#{@label}(#{@lexime})")
            else
              s += makelabel(@label)
            end
        else
          labelno = @@nodeno
          s += makelabel(@label)

          @children.each{|c|
              if c != nil then
                  s += arrow("#{@label}#{labelno}", "#{c.getlabel}#{@@nodeno}")
                  s += c.show
                  @@nodeno += 1
              end
          }
        end
        s
    end
    
    def getlabel
      @label
    end
    
    def arrow(s, d)
      "  " + '"' + s + '" -> "' + d + '";' + "\n"
    end

    def makelabel(l)
      "  " + '"' + l + @@nodeno.to_s + '"' + '[label = "' + l + '"];' + "\n"
    end
end