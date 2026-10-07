

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
        ## if false   ## add some competitions here
        ##   h[:ft] = score
        ##else
        ##   h[:et] = score
        ## end
        h[:reported] = score
     else
        h[:reported] = score
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
