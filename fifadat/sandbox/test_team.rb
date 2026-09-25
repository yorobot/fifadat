
## to run use:
##
##  $ ruby sandbox/test_team.rb    (in /fifadat/fifadat)

$LOAD_PATH.unshift( './lib' )


require 'fifadat'


outdir = "/sports/yorobot/fifadat/cache.json"


##   IdTeam: "4l5d2ebcjlj5rsxqfzx3wc2nh"
##   IdCountry: "AUT"
##  Admira Wacker
##
##   IdTeam: "30996"
##   IdCountry: "AUT"
##  Rapid Wien
##
##   IdTeam: "32759"
##   IdCountry: "AUT"
##     LASK Linz
##
##    IdTeam: "1896634"
##    IdCountry: "ENG"
##       Liverpool
##
##
##   note - the idStadium are missing (set to null) and not listed in team and match records!!!
##               "Stadium": null



url = Fifa::Metal.team_url( idTeam: '30996' )
fetch_json_if( url, "#{outdir}/teams/aut-rapid_wien.json" )

url = Fifa::Metal.team_url( idTeam: '32759' )
fetch_json_if( url, "#{outdir}/teams/aut-lask_linz.json" )

url = Fifa::Metal.team_url( idTeam: '4l5d2ebcjlj5rsxqfzx3wc2nh' )
fetch_json_if( url, "#{outdir}/teams/aut-admira_wacker.json" )

url = Fifa::Metal.team_url( idTeam: '1896634' )
fetch_json_if( url, "#{outdir}/teams/eng-liverpool.json" )

url = Fifa::Metal.team_url( idTeam: '33161' )
fetch_json_if( url, "#{outdir}/teams/eng-manchester_united.json" )



puts "bye"