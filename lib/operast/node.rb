###
### $Rev$
### $Release: $
### $Copyright$
### $License$
###


module Operast


  ## abstract
  module Node

    def +(arg);   Expression.new('+', self, arg);    end
    def -(arg);   Expression.new('-', self, arg);    end
    def *(arg);   Expression.new('*', self, arg);    end
    def /(arg);   Expression.new('/', self, arg);    end
    def %(arg);   Expression.new('%', self, arg);    end
    def &(arg);   Expression.new('&', self, arg);    end
    def |(arg);   Expression.new('|', self, arg);    end
    def ^(arg);   Expression.new('^', self, arg);    end
    def >(arg);   Expression.new('>', self, arg);    end
    def <(arg);   Expression.new('<', self, arg);    end
    def >=(arg);  Expression.new('>=', self, arg);   end
    def <=(arg);  Expression.new('<=', self, arg);   end
    def ==(arg);  Expression.new('==', self, arg);   end
    def =~(arg);  Expression.new('=~', self, arg);   end
    def <<(arg);  Expression.new('<<', self, arg);   end
    def >>(arg);  Expression.new('>>', self, arg);   end
    def **(arg);  Expression.new('**', self, arg);   end
    def [](arg);  Expression.new('[]', self, arg);   end
    def <=>(arg); Expression.new('<=>', self, arg);  end

    def ~();      UniExpression.new('~',  self);   end
    def +@();     UniExpression.new('+@', self);   end
    def -@();     UniExpression.new('-@', self);   end

    if RUBY_VERSION >= '1.9'
      eval "def !=(arg); Expression.new('!=', self, arg); end"
    end

  end


  class Expression
    include Node

    def initialize(token, left, right)
      @token = token
      @left  = left
      @right = right
    end

    attr_accessor :token, :left, :right

    alias :op :token

  end


  class UniExpression < Expression

    def initialize(token, left)
      super(token, left, nil)
    end

  end


  class Variable
    include Node

    def initialize(name)
      @name = name
    end

    attr_accessor :name

    def token
      return :variable
    end

  end


end

