
## to run use:
##
##  $ ruby sandbox/test_config.rb    (in /fifadat/fifadat)

$LOAD_PATH.unshift( './lib' )


require 'fifadat'

puts "==> COMPS"
pp Fifa::COMPETITIONS

puts
puts "==> CODES"
pp Fifa::CODES



puts "bye"