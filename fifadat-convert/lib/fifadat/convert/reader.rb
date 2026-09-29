## use mk/build_report_basename - why? why not?
##     fix-fix-fix - change to _match_basename !!!
##        use by (match)report and (match)timeline !!!
def _report_basename( m )
      ### get match (live) details
      team1_code = m['Home']['Abbreviation']
      team2_code = m['Away']['Abbreviation']
      localDateTime  = parse_date_utc( m['LocalDate'] )

      ##  e.g.  2020-06-24_RAP-AUS__54545454
      basename = String.new
      basename += localDateTime.strftime('%Y-%m-%d')    ##   i) date
      basename += "_#{team1_code}-#{team2_code}"        ##  ii) team1 v team2

      basename
end



def _read_timeline( m, timeline_dir: )
      return nil     if m['Home'].nil? || m['Away'].nil?

      basename = _report_basename( m )
      basename += "__#{m['IdMatch']}"

      path = "#{timeline_dir}/#{basename}.json"

      ## note - skip if no match report available!!!
      if File.file?( path )
         timeline = read_json_v2( path )
         timeline
      else
         nil
      end
end

def _read_report( m, report_dir: )
      return nil     if m['Home'].nil? || m['Away'].nil?

      ##  e.g.  2020-06-24_RAP-AUS__54545454
      #   note - add match id for "raw" match reports!!!
      basename = _report_basename( m )
      basename += "__#{m['IdMatch']}"

      ## #{indir}/#{slug}/matches/#{season.to_path}
      path = "#{report_dir}/#{basename}.json"

      ## note - skip if no match report available!!!
      if File.file?( path )
         live = read_json_v2( path )
         live
      else
         nil
      end
end
