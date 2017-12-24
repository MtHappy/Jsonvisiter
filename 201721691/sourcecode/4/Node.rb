class Node
    
    def accept(v)
        v.visit(self)
    end
end

class Json_node < Node
    attr_reader :label,:children
  
    def initialize(children)
        @children = children
        @label = "Json"
    end
end

class Object_node < Node
    attr_reader :label,:children

    def initialize(*children)
        @children = children
        @label = "Object"
    end
end

class Memberlist_node < Node
    attr_reader :label,:children

    def initialize(*children)
        @children = children
        @label = "Memberlist"
    end
end

class Members_node < Node
    attr_reader :label,:children

    def initialize(*children)
        @children = children
        @label = "Members"
    end
end

class Pair_node < Node
    attr_reader :label,:children

    def initialize(*children)
        @children = children
        @label = "Pair"
    end
end

class Array_node < Node
    attr_reader :label,:children

    def initialize(*children)
        @children = children
        @label = "Array"
    end
end

class Elements_node < Node
    attr_reader :label,:children

    def initialize(*children)
        @children = children
        @label = "Elements"
    end
end

class Value_node < Node
    attr_reader :label,:children

    def initialize(children)
        @children = children
        @label = "Value"
    end
end

class Elementlist_node < Node
    attr_reader :label,:children

    def initialize(*children)
        @children = children
        @label = "Elmentlist"
    end
end

class True_node < Node
    attr_reader :label

    def initialize()
        @label = "True"
    end
end

class False_node < Node
    attr_reader :label
    
    def initialize()
        @label = "False"
    end
end

class LBRA_node < Node
    attr_reader :label

    def initialize()
        @label = "LBRA"
    end
end

class RBRA_node < Node
    attr_reader :label

    def initialize()
        @label = "RBRA"
    end
end

class LBRACKET_node < Node
    attr_reader :label

    def initialize()
        @label = "LBRACKET"
    end
end

class RBRACKET_node < Node
    attr_reader :label

    def initialize()
        @label = "RBRACKET"
    end
end

class Comma_node < Node
    attr_reader :label

    def initialize()
        @label = "Comma"
    end
end

class Colon_node < Node
    attr_reader :label

    def initialize()
        @label = "Colon"
    end
end

class Null_node < Node
    attr_reader :label

    def initialize()
        @lebel = "Null"
    end
end
  
class Int_node < Node
    attr_reader :label

    def initialize(lexime)
        @label = "Int(#{lexime})"
    end
end

class Float_node < Node
    attr_reader :label

    def initialize(lexime)
        @label = "Float(#{lexime})"
    end
end

class String_node < Node
    attr_reader :label

    def initialize(lexime)
        @label = "String(#{lexime[1..-2]})"
    end
end