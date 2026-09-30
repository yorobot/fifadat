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

    fetch_json_if( Fifa::Metal.stages_url( idSeason: idSeason ),
               "#{outdir}/#{name}/misc/#{season.to_path}_stages.json", force: force )

    fetch_json_if( Fifa::Metal.squads_url( idCompetition: idComp,
                                         idSeason:      idSeason ),
               "#{outdir}/#{name}/misc/#{season.to_path}_squads.json", force: force )

end



def prepare_reports( name:,
                     season:,
                     outdir: '.',
                     force: false )

  ## download match reports (via live/football)
    season = Season(season)

     data = read_json( "#{outdir}/#{name}/#{season.to_path}_matches.json" )
     matches = data['Results']


    puts "==> prepare reports - #{matches.size} match(es) in #{name} #{season}"



    matches.each_with_index do |m, i|
      idCompetition = m['IdCompetition']
      idSeason      = m['IdSeason']
      idStage       = m['IdStage']
      idMatch       = m['IdMatch']


      ## note - skip if teams not yet know
      ##  e.g. Home & Away is null
      ##  e.g.    "Home": null,
      ##          "Away": null,

      ## todo/fix - check for MatchStatus and ResultType too
      ##  e.g. MatchStatus = 1  -- future
      ##       ResultType  = 0  -- not played yet

    ##      if not yet played!!!
   #         1-scheduled and
   #         2-live
   #         7-postponed !!!! (too)
   #    return empty score!!!
      if m['MatchStatus'] == 1 ||
         m['MatchStatus'] == 2 ||
         m['MatchStatus'] == 7
           ## skip scheduled/live matches (not yet played)
           next
      end




      if m['Home'].nil? || m['Away'].nil?
         puts "[#{i+1}/#{matches.size}]  ??  ??, #{stageName}  (SKIPPED - TO BE DONE)"
         next
      end


      ### fix-fix-fix - use parse_date_utc !!!
      dateTime       = parse_date( m['Date'] )    ## utc
      localDateTime  = parse_date( m['LocalDate'] )


      ## pp m['Home']
      teamName1   = desc( m['Home']['TeamName'] )
      teamCode1   = m['Home']['Abbreviation']

      ## pp m['Away']
      teamName2   = desc( m['Away']['TeamName'] )
      teamCode2   = m['Away']['Abbreviation']

      stageName   = desc( m['StageName'] )
      matchday    = m['MatchDay']

      print "[#{i+1}/#{matches.size}]  "
      print   MATCH_STATUS[m['MatchStatus']]||"???-#{m['MatchStatus']}"
      print  "/"
      print   RESULT_TYPE[m['ResultType']]||"???-#{m['ResultType']}"
      print "  #{teamName1} (#{teamCode1}) v #{teamName2} (#{teamCode2}) | #{stageName} - #{matchday} | #{localDateTime}"
      print "\n"

      outpath = "#{outdir}/#{name}/matches/#{season.to_path}/#{localDateTime.strftime('%Y-%m-%d')}_#{teamCode1}-#{teamCode2}__#{idMatch}.json"

      url = Fifa::Metal.live_url( idCompetition: idCompetition,
                                  idSeason:      idSeason,
                                  idStage:       idStage,
                                  idMatch:       idMatch )

      fetch_json_if( url, outpath, force: force )


      ###
      ##   add timeline (only)  if score incl. penalty shoot-out
      resultType = m['ResultType']
      if resultType == 2    ## win on pens

        ## download timeline
        outpath = "#{outdir}/#{name}/timelines/#{season.to_path}/#{localDateTime.strftime('%Y-%m-%d')}_#{teamCode1}-#{teamCode2}__#{idMatch}.json"

        url = Fifa::Metal.timeline_url( idCompetition: idCompetition,
                                idSeason:      idSeason,
                                idStage:       idStage,
                                idMatch:       idMatch )

       fetch_json_if( url, outpath, force: force )
    end
  end
end
