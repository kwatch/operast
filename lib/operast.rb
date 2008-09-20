###
### $Rev$
### $Release: $
### $Copyright$
### $License$
###


require 'operast/node'
require 'operast/translator'
#require 'operast/translator/sql'

if __FILE__ == $0
  require 'operast/translator/sql'
  t = Operast::SqlTranslator.new
  x = Operast::Variable.new('x')
  y = Operast::Variable.new('y')

  p t.translate(x)                     #=> "x"
  p t.translate(x + 1)                 #=> "(x + 1)"
  p t.translate(x + y)                 #=> "(x + y)"
  p t.translate(x * y + 2)             #=> "((x * y) + 2)"
  p t.translate(x + y * 2)             #=> "(x + (y * 2))"
  p t.translate(x ** y)                #=> "power(x,y)"
  p t.translate(x > 0)                 #=> "(x > 0)"
  p t.translate(y < 1)                 #=> "(y < 1)"
  p t.translate(x <= Time.mktime(2008,1,1))  #=> "(x <= '2008-01-01 00:00:00')"
  p t.translate(x == 0)                #=> "(x = 0)"
  p t.translate(y ^ "who's who")       #=> "(y <> 'who\\'s who')"
  p t.translate(y <=> 3.14)            #=> "(y <> 3.14)"
  p t.translate(x != y)                #=> "(x <> y)"  (ruby 1.9 only)
  p t.translate((x > 0) & (y < 1))     #=> "((x > 0) and (y < 1))"
  p t.translate((x == 0) | (y ^ 1))    #=> "((x = 0) or (y <> 1))"
  p t.translate(~ (x == 1))            #=> "not (x = 1)"
  p t.translate(x == nil)              #=> "(x is null)"
  p t.translate(x <=> nil)             #=> "(x is not null)"
  p t.translate(x =~ '%pattern%')      #=> "(x like '%pattern%')"
  p t.translate(x.in?([10,20,30]))     #=> "(x in (10,20,30))"
  p t.translate(x.in?(10..30))         #=> "(x between 10 and 30)"
end
