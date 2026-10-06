


def convert( slug:, season:,
                indir: '.',
                outdir: './tmp' )

   season = Season(season)


   ### fix-fix-fix  change to read_json_results or ??? - why? why not?
   matches =  read_json_v2( "#{indir}/#{slug}/#{season.to_path}_matches.json" )
   matches = matches['Results']  ## only use results (match) array

   ## pp matches
   puts "==> convert - #{matches.size} match(es) in #{slug} #{season}"


   ## read in stages
   ##   incl.  SequenceOrder, StageLevel (optional)
   stages = Stages.read( "#{indir}/#{slug}/misc/#{season.to_path}_stages.json" )
   stages.add_matches( matches )

   teams = Teams.new
   teams.add_matches( matches )

   stadiums = Stadiums.new
   stadiums.add_matches( matches )



    data = {}

    ## add slug & seasons (add name to be done!!)
    data[:meta] = { slug:      slug,
                    season:    season.to_s,
                    generated: Time.now.to_s,
                    version:   FifadatConvert::VERSION,
                    teams:    teams.size,
                    matches:  matches.size,
                    stages:   stages.size,
                    stadiums:  stadiums.size,
                  }

   data[:stages]   = stages.as_json
   data[:teams]    = teams.as_json
   data[:stadiums] = stadiums.as_json



   ## for match-by-match live reports
   report_dir   = "#{indir}/#{slug}/matches/#{season.to_path}"
   timeline_dir = "#{indir}/#{slug}/timelines/#{season.to_path}"


   recs = []
   matches.each_with_index do |m, i|

       ## add/track id too - why? why not?
       ##  rec[:id]  = m['IdMatch']


        ## add/fill-up match basic
       rec = Match.build( m,  teams:    teams,
                              stadiums: stadiums,
                              stages:   stages )

   ###
   ##   note - skip check for match events / goals etc.
   ##      if not yet played!!!
   #         1-scheduled and
   #         2-live
   #         7-postponed (too)
   #    return empty score!!!
      if !(m['MatchStatus'] == 1 ||
           m['MatchStatus'] == 2 ||
           m['MatchStatus'] == 7)



      ### get match (live) details
      ###
       ##   check if match report & timeline exits
      ##    optional for now!!

      live     = _read_report( m, report_dir: report_dir )
      timeline = _read_timeline( m, timeline_dir: timeline_dir )


        ###
        ###  note live might be empty / not available!!!

        if live.nil?
            puts "!!warn - no match report for #{_report_basename(m)}"
        else

          ## try  update of score via goals from (match) report
          score_more =  _build_report_score( live, timeline )
           if score_more
             rec.score = {}.merge( rec.score||{}, score_more )
          end


          ## reuse generated output from report
          report =  MatchReport.build( live, timeline )

          ############
          ## add goals

          if report.goals1.empty? && report.goals2.empty?
             ## skip if no goals
          else
            rec.goals1 = report.goals1
            rec.goals2 = report.goals2
          end


          #########
          ## add penalties
          rec.penalties = report.penalties   if report.penalties &&
                                               !report.penalties.empty?


         sentoff1 = report.sentoff1
         sentoff2 = report.sentoff2
         rec.sentoff1 = sentoff1    unless sentoff1.empty?
         rec.sentoff2 = sentoff2    unless sentoff2.empty?

         ###
         ##  add referees
         rec.officials = report.officials   if report.officials && !report.officials.empty?
         end
      end



      recs << rec
   end
   data[:matches] = recs.as_json



    outpath =  "#{outdir}/#{season.to_path}/#{slug}.json"
    write_json( outpath, data)
    puts "  written to >#{outpath}<"

    true
end
