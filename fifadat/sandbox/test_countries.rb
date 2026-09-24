
## to run use:
##
##  $ ruby sandbox/test_countries.rb    (in /fifadat/fifadat)

$LOAD_PATH.unshift( './lib' )


require 'fifadat'


outdir = "/sports/yorobot/fifadat/cache.json"

url = Fifa::Metal.countries_url
fetch_json( url, "#{outdir}/countries.json" )

url = Fifa::Metal.confederations_url
fetch_json( url, "#{outdir}/confederations.json" )


puts "bye"