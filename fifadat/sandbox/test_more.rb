
## to run use:
##
##  $ ruby sandbox/test_more.rb    (in /fifadat/fifadat)

$LOAD_PATH.unshift( './lib' )


require 'fifadat'


outdir = "/sports/yorobot/fifadat/cache.json"


idSeason = '1ypt1hmmrdjdek7yieatpskyc'  ## at 2026/27
url = Fifa::Metal.teams_url( idSeason: idSeason )
fetch_json_if( url, "#{outdir}/teams/at_2026-27.json" )


idSeason = '99jev9kv55deht65t6myggxlg'  ## uefa.cl 2026/27
url = Fifa::Metal.teams_url( idSeason: idSeason )
fetch_json_if( url, "#{outdir}/teams/uefa.cl_2026-27.json" )



idSeason      = '1ypt1hmmrdjdek7yieatpskyc'  ## at 2026/27
idTeam        = '30996' ## rapid wien
idCompetition = '2000000005'

url = Fifa::Metal.squad_url( idTeam: idTeam, idCompetition: idCompetition, idSeason: idSeason )
fetch_json_if( url, "#{outdir}/teams/at_2026-27--rapid_wien.json" )



puts "bye"