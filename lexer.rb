class JsonLexer

  def initialize(f)
    @srcf=f
    @line=""
    @linenumber=0
  end

  attr_reader :linenumber

  def lex()
    if @line == nil
      false
    else
      if /\A\s+/ =~ @line
        @line = $'
      end
      while @line.empty? do
        @line = @srcf.shift
        if @line == nil
          return :eof
        end
        @linenumber += 1
        if /\A\s+/ =~ @line
          @line = $'
        end
      end

      case @line
      when /\A\:/
        yield :colon, $&
      when /\A\[/
        yield :lbracket, $&
      when /\A\]/
        yield :rbracket, $&
      when /\A\{/
        yield :lbra, $&
      when /\A\}/
        yield :rbra, $&
      when /\A\,/
        yield :comma, $&
      when /\"[^"]*\"/
        yield :string, $&
      when /\A[+-]?\d+\.\d+([eE][-+]?[0-9]+)?/
        yield :float, $&
      when /\A[+-]?\d+/
        yield :int, $&
      when /\Afalse/
        yield :false, $&
      when /\Atrue/
        yield :true, $&
      when /\Anull/
        yield :null, $&
      end
      #puts "matched is (#{$&})"
      @line = $'
      #return token
    end
  end
end