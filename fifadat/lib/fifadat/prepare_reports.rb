
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


      ### note - date is always utc without timezone even if local!!
      ##         local is utc (plus/minus offset)!!!
      ##  e.g.
      ##     "Date":      "2026-08-02T15:00:00Z",
      ##     "LocalDate": "2026-08-02T17:00:00Z",
      dateTime       = parse_date_utc( m['Date'] )         ## utc
      localDateTime  = parse_date_utc( m['LocalDate'] )


      ## pp m['Home']
      teamName1   = desc( m['Home']['TeamName'] )
      teamCode1   = m['Home']['Abbreviation']

      ## pp m['Away']
      teamName2   = desc( m['Away']['TeamName'] )
      teamCode2   = m['Away']['Abbreviation']

      stageName   = desc( m['StageName'] )
      ##  "MatchDay": null,
      matchday    = m['MatchDay'] || '∅'
      groupName   = desc( m['GroupName'] )

      print "[#{i+1}/#{matches.size}]  "
      print   MATCH_STATUS[m['MatchStatus']]||"???-#{m['MatchStatus']}"
      print  "/"
      print   RESULT_TYPE[m['ResultType']]||"???-#{m['ResultType']}"
      print "  #{teamName1} (#{teamCode1}) v #{teamName2} (#{teamCode2})"
      print " | #{stageName} - #{matchday}"
      print ", #{groupName}"     if groupName
      print " | #{localDateTime}"
      print "\n"



      outpath = "#{outdir}/#{name}/matches/#{season.to_path}/#{localDateTime.strftime('%Y-%m-%d')}_#{teamCode1}-#{teamCode2}__#{idMatch}.json"

      url = Fifa::Metal.live_url( idCompetition: idCompetition,
                                  idSeason:      idSeason,
                                  idStage:       idStage,
                                  idMatch:       idMatch )

      fetch_json_if( url, outpath, force: force ) do |m|
               ### note - check match status
               ##   if match status is 1 - scheduled
               ##                   or 2 - live or
               ##                      7 - postponeed
               ##  warn and do NOT save (return false)

               if m['MatchStatus'] == 1 ||
                  m['MatchStatus'] == 2 ||
                  m['MatchStatus'] == 7
                  puts "!! WARN -  skip writing (live) match report <#{outpath}>"
                  puts "     matchStatus is #{MATCH_STATUS[m['MatchStatus']]}"
                  false
               else
                  true
               end
              end


      ###
      ##   add timeline (only)  if score incl. penalty shoot-out
      resultType = m['ResultType']
      if resultType == 2      ## WIN_ON_PENS

        ## download timeline
        outpath = "#{outdir}/#{name}/timelines/#{season.to_path}/#{localDateTime.strftime('%Y-%m-%d')}_#{teamCode1}-#{teamCode2}__#{idMatch}.json"

#        url = Fifa::Metal.timeline_url( idCompetition: idCompetition,
#                                idSeason:      idSeason,
#                                idStage:       idStage,
#                                idMatch:       idMatch )
        url = Fifa::Metal.timeline_url( idMatch:idMatch )

       fetch_json_if( url, outpath, force: force )
    end
  end
end
