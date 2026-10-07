

##
##   read & build match report


def convert_reports( slug:, season:,
                         indir: '.',
                         outdir: './tmp' )

   season = Season(season)

   data =  read_json_v2( "#{indir}/#{slug}/#{season.to_path}_matches.json" )
   matches = data['Results']  ## only use results (match) array
   puts "==> convert reports - #{matches.size} match(es) in #{slug} #{season}"


   ## read in stages
   ##   incl.  SequenceOrder, StageLevel (optional)
   stages = Stages.read( "#{indir}/#{slug}/misc/#{season.to_path}_stages.json" )
   stages.add_matches( matches )

   teams = Teams.new
   teams.add_matches( matches )

   stadiums = Stadiums.new
   stadiums.add_matches( matches )




   report_dir = "#{indir}/#{slug}/matches/#{season.to_path}"
   timeline_dir = "#{indir}/#{slug}/timelines/#{season.to_path}"



   matches.each_with_index do |m, i|

       print "."
       print i+1    if (i+1) %10 == 0


       ## note skip if SCHEDULED == 1
       ##   0 =>   FINISHED/complete (OK)
       ##   1 =>   SCHEDULED/not yet played
       ##   2 =>   LIVE
       ##   7 =>   POSTPONED

       next if m['MatchStatus'] == 1 ||
               m['MatchStatus'] == 2 ||
               m['MatchStatus'] == 7


      live     = _read_report( m, report_dir: report_dir )

      ## no report found; continue
      next  if live.nil?

      ## check for optional timeline
      timeline = _read_timeline( m, timeline_dir: timeline_dir )


      data = {
               meta: {
                  name: desc(live['SeasonName']),
                  slug: slug,
                  season: season.to_s,
                  generated: Time.now.to_s,
               }
            }

      rec    = Match.build( live,   teams:    teams,
                                    stadiums: stadiums,
                                    stages:   stages )


      if _live_goals?( live )
         ## try  update of score via goals from (match) report
         rec.score = _update_score( rec.score, live: live, timeline: timeline )
      end


      if _live_players?( live )
        report = MatchReport.build( live, timeline )

        data = data.merge( rec.as_json, report.as_json )

        ## build basename e.g  2026-07-15_ARG-ENG
        basename = _report_basename( m )
        outpath = "#{outdir}/#{season.to_path}/#{slug}/#{basename}.json"
        write_json( outpath, data )


      else
         puts "!! warn - skipping generate match report; no players found in (live) match report #{_report_basename(m)} with coverage #{live['CoverageLevel']}"
      end
   end

   print " DONE\n"
end
