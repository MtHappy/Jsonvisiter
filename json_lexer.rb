class JsonLexer
  def initialize(f)
    @srcf=f
    @line=""
    @linenumber=0
  end

  attr_reader :linenumber

  def lex()
    if /^\s+/ =~ @line
      @line = $'
    end
    while @line.empty? do
      @line = @srcf.gets
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
      yield $&
      token = :colon
    when /\A\[/
      yield $&
      token = :lbracket
    when /\A\]/
      yield $&
      token = :rbracket
    when /\A\{/
      yield $&
      token = :lbra
    when /\A\}/
      yield $&
      token = :rbra
    when /\A\,/
      yield $&
      token = :comma
    when /\"[^"]*\"/
      yield $&
      token = :string
    when /\A[+-]?\d+\.\d+([eE][-+]?[0-9]+)?/
      yield $&
      token = :float
    when /\A[+-]?\d+/
      yield $&
      token = :int
    when /\Afalse/
      yield $&
      token = :false
    when /\Atrue/
      yield $&
      token =  :true
    when /\Anull/
      yield $&
      token = :null
    when /\A\s/
      # ignore
      token = :whitespace
    when /\A\S/
      # ignore
      token = :other
    end
    @line = $'
    puts "matched is #{token}(#{$&})"
    return token
  end
end
