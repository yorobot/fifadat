

## tip: to test run:
##   $ ruby sandbox/test_at.rb


##
## note - always use latest (local) if present
$LOAD_PATH.unshift( '/sports/yorobot/fifadat/fifadat/lib' )
$LOAD_PATH.unshift( '/sports/yorobot/fifadat/fifadat-convert/lib' )

require 'fifadat/convert'


cache_dir   = '/sports/cache.fifadat'
convert_dir = './tmp'     ##  '/sports/cache.api.fifa'

slug   =  'at.cup'
season =  '2025/26'

convert( slug: slug, season: season,
                indir:  cache_dir,
                outdir: convert_dir )




puts "bye"