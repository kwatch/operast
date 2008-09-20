#!/usr/bin/ruby

###
### $Rev$
### $Release: $
### $Copyright$
### $License$
###

require 'rubygems'

spec = Gem::Specification.new do |s|
  ## package information
  s.name        = "operast"
  s.author      = "makoto kuwata"
  s.email       = "kwa(at)kuwata-lab.com"
  s.rubyforge_project = 'operast'
  s.version     = "$Release$"
  s.platform    = Gem::Platform::RUBY
  s.homepage    = "http://www.rubyforge.org/projects/operast/"
  s.summary     = "convert Ruby expression into other language"
  s.description = <<-'END'
  Operast is a library to convert Ruby expression into other language.
  Currently, only SQL is supported.
  For example:
  * 'x == 1' is converted into 'x = 1'
  * 'x = nil' into 'x is null'
  * '(x > 0) & (x < 10)' into '(x > 0) and (x < 10)'
  * 'x =~ "%pattern%"' into "x like '%pattern%'"
  * 'x.in? [10,20,30]' into 'x in (10,20,30)'
  * 'x.in? 10..30' into 'x between 10 and 30'
  END

  ## files
  files = []
  files += Dir.glob('lib/**/*')
  #files += Dir.glob('bin/*')
  #files += Dir.glob('examples/**/*')
  #files += Dir.glob('test/**/*')
  #files += Dir.glob('doc/**/*')
  #files += Dir.glob('examples/**/*')
  files += %w[README.rdoc CHANGES.txt MIT-LICENSE setup.rb operast.gemspec]
  files += Dir.glob('doc-api/**/*')
  s.files       = files
  #s.test_file   = 'test/test_all.rb'
end

# Quick fix for Ruby 1.8.3 / YAML bug   (thanks to Ross Bamford)
if (RUBY_VERSION == '1.8.3')
  def spec.to_yaml
    out = super
    out = '--- ' + out unless out =~ /^---/
    out
  end
end

if $0 == __FILE__
  Gem::manage_gems
  Gem::Builder.new(spec).build
end
