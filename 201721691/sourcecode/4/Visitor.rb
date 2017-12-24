class Json2dotVisitor
    @@nodeno = 0
    
    def initialize
        @nodes = {Json_node => lambda{|n|
                      s = ''
                      labelno = @@nodeno
                      s += makelabel(n.label)
                      @@nodeno += 1
                      s += arrow("#{n.label}#{labelno}", "#{n.children.label}#{@@nodeno}")
                      s += n.children.accept(self)
                      s
                  },
                  Object_node => lambda{|n|
                      s = ''
                      labelno = @@nodeno
                      s += makelabel(n.label)
                      @@nodeno += 1
                      
                      s += arrow("#{n.label}#{labelno}", "#{n.children[0].label}#{@@nodeno}")
                      s += n.children[0].accept(self)
                    
                      s += arrow("#{n.label}#{labelno}", "#{n.children[1].label}#{@@nodeno}")
                      s += n.children[1].accept(self)
                    
                      s += arrow("#{n.label}#{labelno}", "#{n.children[2].label}#{@@nodeno}")
                      s += n.children[2].accept(self)
                      s
                  },
                  Members_node => lambda{|n|
                      s = ''
                      if n.children == [] then
                          s += makelabel(n.label)
                          @@nodeno += 1
                      else
                          labelno = @@nodeno
                          s += makelabel(n.label)
                          @@nodeno += 1
                          s += arrow("#{n.label}#{labelno}", "#{n.children[0].label}#{@@nodeno}")
                          s += n.children[0].accept(self)
                      end
                      s
                  },
                  Memberlist_node => lambda{|n|
                      s = ''
                      labelno = @@nodeno
                      s += makelabel(n.label)
                      @@nodeno += 1
                      
                      n.children.each{|c|
                          if c != nil then
                              s += arrow("#{n.label}#{labelno}", "#{c.label}#{@@nodeno}")
                              s += c.accept(self)

                          end
                      }
                      s
                  },
                  Pair_node => lambda{|n|
                      s = ''
                      labelno = @@nodeno
                      s += makelabel(n.label)
                      @@nodeno += 1
                      
                      s += arrow("#{n.label}#{labelno}", "#{n.children[0].label}#{@@nodeno}")
                      s += n.children[0].accept(self)
                    
                      s += arrow("#{n.label}#{labelno}", "#{n.children[1].label}#{@@nodeno}")
                      s += n.children[1].accept(self)
                    
                      s += arrow("#{n.label}#{labelno}", "#{n.children[2].label}#{@@nodeno}")
                      s += n.children[2].accept(self)
                      s
                  },
                  Array_node => lambda{|n|
                      s = ''
                      labelno = @@nodeno
                      s += makelabel(n.label)
                      @@nodeno += 1
                      
                      s += arrow("#{n.label}#{labelno}", "#{n.children[0].label}#{@@nodeno}")
                      s += n.children[0].accept(self)
                    
                      s += arrow("#{n.label}#{labelno}", "#{n.children[1].label}#{@@nodeno}")
                      s += n.children[1].accept(self)
                    
                      s += arrow("#{n.label}#{labelno}", "#{n.children[2].label}#{@@nodeno}")
                      s += n.children[2].accept(self)
                      s
                  },
                  Elements_node => lambda{|n|
                      s = ''
                      
                      if n.children == [] then
                          s += makelabel(n.label)
                          @@nodeno += 1
                      else
                          labelno = @@nodeno
                          s += makelabel(n.label)
                          @@nodeno += 1
                          s += arrow("#{n.label}#{labelno}", "#{n.children[0].label}#{@@nodeno}")
                          s += n.children[0].accept(self)
                      end
                      s
                  },
                  Value_node => lambda{|n| 
                      s = ''
                      labelno = @@nodeno
                      s += makelabel(n.label)
                      @@nodeno += 1
                      s += arrow("#{n.label}#{labelno}", "#{n.children.label}#{@@nodeno}")
                      s += n.children.accept(self)
                      s
                  },
                  Elementlist_node => lambda{|n|
                      s = ''
                      labelno = @@nodeno
                      s += makelabel(n.label)
                      @@nodeno += 1
                    
                      n.children.each{|c|
                          if c != nil then
                              s += arrow("#{n.label}#{labelno}", "#{c.label}#{@@nodeno}")
                              s += c.accept(self)

                          end
                      }
                      s
                  },
                  True_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  },
                  False_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  },
                  LBRA_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  },
                  RBRA_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  },
                  LBRACKET_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  },
                  RBRACKET_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  },
                  Comma_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  },
                  Colon_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  },
                  Null_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  },
                  Int_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  },
                  Float_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  },
                  String_node => lambda{|n| 
                      s = makelabel("#{n.label}")
                      @@nodeno += 1
                      s
                  }
                }
    end

    def visit(n)
        @nodes[n.class].call(n)
    end
    
    def arrow(s, d)
        "  " + '"' + s + '" -> "' + d + '";' + "\n"
    end

    def makelabel(l)
        "  " + '"' + l + @@nodeno.to_s + '"' + '[label = "' + l + '"];' + "\n"
    end
end