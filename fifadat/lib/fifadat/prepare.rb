###
#  get matches and stages per season
##
##  download / prepare (fill-up local) cache


def prepare( name:,
             season:,
             outdir: '.',
             force: false )

 ###
 ### rename name to slug or such
 ##   e.g.   worldcup, clubworldcup, interconticup or such expected!!!

    season = Season(season)

    idComp   = Fifa._idComp_by!( name: name )

    idSeason = Fifa._idSeason_by!( name: name, season: season )

    fetch_json_if( Fifa::Metal.matches_url( idSeason: idSeason ),
                "#{outdir}/#{name}/#{season.to_path}_matches.json", force: force )

    fetch_json_if( Fifa::Metal.teams_url( idSeason: idSeason ),
               "#{outdir}/#{name}/misc/#{season.to_path}_teams.json", force: force )

    fetch_json_if( Fifa::Metal.stages_url( idSeason: idSeason ),
               "#{outdir}/#{name}/misc/#{season.to_path}_stages.json", force: force )

    fetch_json_if( Fifa::Metal.squads_url( idCompetition: idComp,
                                         idSeason:      idSeason ),
               "#{outdir}/#{name}/misc/#{season.to_path}_squads.json", force: force )

end
