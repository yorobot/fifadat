

def _parse_score( m )
   h = { }

   ###
   #  note: for match status
   #       1-scheduled and
   #       2-live
   #       7-postponed
   #    return empty score!!!

   return h    if m['MatchStatus'] == 1 ||
                  m['MatchStatus'] == 2 ||
                  m['MatchStatus'] == 7


#
# add quick fix for club world cup?!
#      elsif  resultType == 1  ||  ## assume 1 - regular (90 mins+stoppage/injury time)
#              resultType == 4  ||
#        m['IdMatch'] == '400019191'  ##  fix for pachuca vs salzburg !!!
#   has resultType == 0!!!

   m = errata_autofix_score( m )


  resultType  = m['ResultType']
   ## add score[:type] - why? why not?
   h[:type] =  RESULT_TYPE[resultType] || "???-#{resultType}"


  score =  if m['HomeTeam'] && m['AwayTeam']  ## assume inside (match) report
             [m['HomeTeam']['Score'], m['AwayTeam']['Score']].compact
          else   ## assume (seasons) matches list
            ## note - report has no "inline/flat" HomeTeamScore/AwayTeamScore
             [m['HomeTeamScore'], m['AwayTeamScore']].compact
          end


   ## is score after extra-time or not?
   ##    note - CANNOT tell for resultType 2!!!

   if score.empty?
       ## do nothing
   else
     if [1,4].include?( resultType )
        ##  1 - regular - 90min
        ##  4 - regular - 90min (on aggregate)
        h[:ft] = score
     elsif [3,5,8].include?( resultType )
         ## 3 - aet (for sure)
         ## 5 - aet [on aggregate] (for sure)
         ## 8 -  golden goal in extra time  (aet/gg)
         ##   fix/fix/fix  - add gold_goal flag for 8!!!
        h[:et] = score   ## assume after extra-time !!!
     elsif resultType == 2
         ### note - 2 win on pens
         ## 2 - win on pens  (with or WITHOUT aet!!)

        ## check for competition for now
        ##    incl. south american
        if false   ## add some competitions here
           h[:ft] = score
        else
           h[:et] = score
        end
     else
        h[:score] = score
     end
    end


    penScore = [m['HomeTeamPenaltyScore'],  m['AwayTeamPenaltyScore']].compact
    aggScore = [m['AggregateHomeTeamScore'],m['AggregateAwayTeamScore']].compact


    ## note - worldcup has penScore [0,0] for all matches, for example!!!
     if penScore.empty? || penScore == [0,0]
     else
        h[:p] = penScore
     end

     h[:agg] = aggScore   if !aggScore.empty?
     h
end



def _build_report_score( live, timeline=nil )



    _scores = _build_score_from_goals( live )


    score = nil

     case live['ResultType']
     when 1,4
         ## 1 => 'REGULAR',
         ## 4 => 'REGULAR/AGG',  ##  aggregate (1st/2nd leg) - regular
        ## add ht
        ##  assert ft match
        score      = {  ht: _scores[:ht][:score],
                         ft: _scores[:ft][:score]
                      }
     when 3,5,8
       score       = {   ht: _scores[:ht][:score],
                         ft: _scores[:ft][:score],
                         et: _scores[:et][:score],
                      }
     when 2
        ##  todo/fix - pull in timeline check too to check
        ##     if any events recorded for extra time!!
        score      = {   ht: _scores[:ht][:score],
                         ft: _scores[:ft][:score],
                      }

        ## note - only incl. extra-time (et) if a goal scored in extra time
        score[:et] = _scores[:et][:score]   unless _scores[:et][:minutes].empty?
     end

     score
end



def _build_score_from_goals( m )
   ##
   ## 5 periods - 3 (1ST_HALF), 5 (2ND_HALF),
   ##             7 (EXTRA_TIME_1ST_HALF), 9 (EXTRA_TIME_2ND_HALF),
   ##             11 (PENALTY_SHOOTOUT) possibly
   ##
   goals = {
      count: 0,
      score: [0,0],
      ht:   { score: [0,0], minutes: [] },
      ft:   { score: [0,0], minutes: [] },
      et:   { score: [0,0], minutes: [] },
      p:    { score: [0,0], minutes: [] },
   }

   ## note - quick fix
   ##            add  period 2  for USA v Belgium (PKO) - worldcup

   ## note - i is 0|1  -  array index for team
   [m['HomeTeam']['Goals'],
    m['AwayTeam']['Goals']].each_with_index do |recs,i|
      recs.each do |h|

        h = errata_autofix_goal( h )

        period = h['Period']
        ## include penalty shootout (11) - why? why not?
        assert(  [3,5,7,9,11].include?(period),
                  "goal in period 3/5/7/9/11 expected; got #{h.pretty_inspect} in match #{m.pretty_inspect}" )

        minute = h['Minute']
        key =  case period
               when 3    then  :ht
               when 5    then  :ft
               when 7, 9 then  :et
               when 11   then  :p
               else
                raise ArgumentError,
                  "goal in period 3/5/7/9/11 expected; got #{h.pretty_inspect}"
               end

        goals[:count] += 1
        goals[:score][i] += 1   unless key == :p
        goals[key][:score][i] += 1
      end
   end

   ## use/calc cummulative score  (BUT not for penalties)
   goals[:ft][:score][0] += goals[:ht][:score][0]
   goals[:ft][:score][1] += goals[:ht][:score][1]

   goals[:et][:score][0] += goals[:ft][:score][0]
   goals[:et][:score][1] += goals[:ft][:score][1]

   goals
end
