###
### $Rev$
### $Release: $
### $Copyright$
### $License$
###


require 'operast/node'


module Operast


  class Translator

    def translate_expression(expr)
      raise NotImeplementedError.new("#{self.class.name}#translate_expression(): not implemented yet.")
    end

    def translate_uni_expression(expr)
      raise NotImeplementedError.new("#{self.class.name}#translate_uni_expression(): not implemented yet.")
    end

    def translate_variable(expr)
      raise NotImeplementedError.new("#{self.class.name}#translate_variable(): not implemented yet.")
    end

    def translate_object(arg)
      return arg.to_s
    end

    def translate_integer(arg)
      return translate_object(arg)
    end

    def translate_float(arg)
      return translate_object(arg)
    end

    def translate_string(arg)
      return translate_object(arg)
    end

    def translate_boolean(arg)
      return translate_object(arg)
    end

    def translate_nil(arg)
      return translate_object(arg)
    end

  end


  class Expression

    def __accept_translator__(translator)
      return translator.translate_expression(self)
    end

  end


  class UniExpression

    def __accept_translator__(translator)
      return translator.translate_uni_expression(self)
    end

  end


  class Variable

    def __accept_translator__(translator)
      return translator.translate_variable(self)
    end

  end


end


class Object

  def __accept_translator__(translator)
    return translator.translate_object(self)
  end

end


class Integer

  def __accept_translator__(translator)
    return translator.translate_integer(self)
  end

end


class Float

  def __accept_translator__(translator)
    return translator.translate_float(self)
  end

end


class String

  def __accept_translator__(translator)
    return translator.translate_string(self)
  end

end


class TrueClass

  def __accept_translator__(translator)
    return translator.translate_boolean(self)
  end

end


class FalseClass

  def __accept_translator__(translator)
    return translator.translate_boolean(self)
  end

end


class NilClass

  def __accept_translator__(translator)
    return translator.translate_nil(self)
  end

end


class Time

  def __accept_translator__(translator)
    return translator.translate_time(self)
  end

end
