###
### $Rev$
### $Release: $
### $Copyright$
### $License$
###


module Operast


  class SqlTranslator < Translator

    @@op_table = {
      '+'   => ' + ',
      '-'   => ' - ',
      '*'   => ' * ',
      '/'   => ' / ',
      '%'   => ' % ',
      '&'   => ' and ',
      '|'   => ' or ',
      '^'   => ' <> ',
      '>'   => ' > ',
      '<'   => ' < ',
      '>='  => ' >= ',
      '<='  => ' <= ',
      '=='  => ' = ',
      '=~'  => ' like ',
      '<<'  => nil,
      '>>'  => nil,
      '**'  => :'**',
      '[]'  => nil,
      '<=>' => ' <> ',
      '~'   => 'not ',
      '+@'  => '+ ',
      '-@'  => '- ',
      '!='  => ' <> ',
      'in'  => true,
    }

    def initialize
      @op_table = @@op_table
    end

    def translate(node)
      @buf = ''
      return node.__accept_translator__(self)
    end

    def translate_expression(expr)
      token = expr.token
      if token == '=='
        @buf << '('
        expr.left.__accept_translator__(self)
        if expr.right.nil?
          @buf << ' is null)'
        else
          @buf << ' = '
          expr.right.__accept_translator__(self)
          @buf << ')'
        end
      elsif token == '^' || token == '<=>' || token == '!='
        @buf << '('
        expr.left.__accept_translator__(self)
        if expr.right.nil?
          @buf << ' is not null)'
        else
          @buf << ' <> '
          expr.right.__accept_translator__(self)
          @buf << ')'
        end
      elsif token == '**'
        @buf << 'power('
        expr.left.__accept_translator__(self)
        @buf << ','
        expr.right.__accept_translator__(self)
        @buf << ')'
      elsif token == 'in'
        @buf << '('
        expr.left.__accept_translator__(self)
        right = expr.right
        if right.is_a?(Array)
          @buf << " in ("
          right.each_with_index do |x, i|
            @buf << ',' if i > 0
            x.__accept_translator__(self)
          end
          @buf << "))"
        elsif right.is_a?(Range)
          @buf << " between "
          right.min.__accept_translator__(self)
          @buf << " and "
          right.max.__accept_translator__(self)
          @buf << ")"
        else
          raise ArgumentError.new("in?: Array or Range expected but #{right.class.name} passed.")
        end
      else
        op = @op_table[expr.token]  or raise ArgumentError.new("#{expr.token}: unsupported operator.")
        @buf << '('
        expr.left.__accept_translator__(self)
        @buf << op
        expr.right.__accept_translator__(self)
        @buf << ')'
      end
      return @buf
    end

    def translate_uni_expression(expr)
      op = @op_table[expr.token]  or raise ArgumentError.new("#{expr.token}: unsupported operator.")
      @buf << op
      expr.left.__accept_translator__(self)
      return @buf
    end

    def translate_variable(var)
      @buf << var.name
      return @buf
    end

    def translate_object(arg)
      @buf << arg.to_s
    end

    def translate_integer(arg)
      @buf << arg.to_s
    end

    def translate_float(arg)
      @buf << arg.to_s
    end

    def translate_string(arg)
      @buf << "'#{arg.gsub('\'', '\\\\\'')}'"
    end

    def translate_boolean(arg)
      @buf << arg.to_s
    end

    def translate_nil(arg)
      @buf << 'null'
    end

    def translate_time(arg)
      @buf << arg.strftime("'%Y-%m-%d %H:%M:%S'")
    end

  end


  class Variable

    def in?(arg)
      case arg
      when Array, Range ;  return Expression.new('in', self, arg)
      else ;  raise ArgumentError.new("in?: Array or Range expected but #{arg.class.name} passed.")
      end
    end

  end


end
