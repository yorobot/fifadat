require_relative './fifadat-convert/lib/fifadat/convert'


cache_dir    = '/sports/cache.fifadat'
## convert_dir  = '/sports/cache.api.fifa'
convert_dir  = './tmp'


name   = 'at'
season = '2025/26'

Fifa._idSeason_by!( name: name, season: season )



convert( slug: name,
              season: season,
              indir: cache_dir,
               outdir: convert_dir )

convert_reports( slug: name,
              season: season,
              indir: cache_dir,
               outdir: convert_dir )


puts "bye"