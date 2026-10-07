
## try  update of score via goals from (match) report
##       and possibly use timeline to check for extra-time etc.



def _update_score( score, live: , timeline: nil )

    _scores = _build_score_from_goals( live )


     case live['ResultType']
     when 1,4
         ## 1 => 'FT',
         ## 4 => 'FT/AGG',  ##  aggregate (1st/2nd leg) - regular
        ## add ht
        ##  assert ft match score
        score_more      = {  ht: _scores[:ht][:score],
                             ft: _scores[:ft][:score]
                          }
        score = {}.merge( score||{}, score_more )
     when 3,5,8    ## AET
         ## add ht,ft
         ##  assert et match score
        score_more       = {   ht: _scores[:ht][:score],
                               ft: _scores[:ft][:score],
                               et: _scores[:et][:score],
                          }
        score = {}.merge( score||{}, score_more )
     when 2    ## WIN_ON_PENS
        ##  todo/fix - pull in timeline check too to check
        ##     if any events recorded for extra time!!
        score_more      = {   ht: _scores[:ht][:score],
                              ft: _scores[:ft][:score],
                           }
        score = {}.merge( score||{}, score_more )

        ##  note - only incl. extra-time (et) if a goal scored in extra time
        if _scores[:et][:minutes].size > 0
            ##  and add extra time score (no longer assumed ambigious)
            ## remove reported score
            ##   assert reported is same as et !!!
           score_more = { et: _scores[:et][:score] }
           score = {}.merge( score.except(:reported), score_more )
        else
            _periods = _build_periods( live )
            if _periods[:count] > 0
                if _periods[:et][:subs]     > 0 ||
                   _periods[:et][:bookings] > 0
                    ## assume extra-time
                    ##    use reported score for et
                    score_more = { et: score[:reported] }
                    score = {}.merge( score.except(:reported), score_more )
                else
                   puts "!! warn -  cannot resolve WIN_ON_PENS - extra-time yes/no? - #{_periods[:count]} subs/bookings found w/ none in extra-time"
                end
            else
              ## todo/fix - add check via periods in timeline!!!
              ##   warn - cannot resolve WIN_ON_PENS - extra-time yes/no?
              puts "!! warn -  cannot resolve WIN_ON_PENS - extra-time yes/no? - no subs/bookings found"
            end
        end
     end


     score
end



## get periods for bookings and substitutions
def _build_periods( m )
   periods = {
      count: 0,
      ht:   { subs: 0, bookings: 0 },
      ft:   { subs: 0, bookings: 0 },
      et:   { subs: 0, bookings: 0 },
      p:    { subs: 0, bookings: 0 },
   }

   [m['HomeTeam']['Bookings'],
    m['AwayTeam']['Bookings']].each_with_index do |recs,i|
      recs.each do |h|

        period = h['Period']
        ## include penalty shootout (11) - why? why not?
        assert(  [3,5,7,9,11].include?(period),
                  "booking in period 3/5/7/9/11 expected; got #{h.pretty_inspect} in match #{m.pretty_inspect}" )

        key =  case period
               when 3    then  :ht
               when 5    then  :ft
               when 7, 9 then  :et
               when 11   then  :p
               else
                raise ArgumentError,
                  "booking in period 3/5/7/9/11 expected; got #{h.pretty_inspect}"
               end

        periods[:count] += 1
        periods[key][:bookings] += 1
      end
   end


  [m['HomeTeam']['Substitutions'],
    m['AwayTeam']['Substitutions']].each_with_index do |recs,i|
      recs.each do |h|

        period = h['Period']
        ## include penalty shootout (11) - why? why not?
        assert(  [3,5,7,9,11].include?(period),
                  "sub in period 3/5/7/9/11 expected; got #{h.pretty_inspect} in match #{m.pretty_inspect}" )

        key =  case period
               when 3    then  :ht
               when 5    then  :ft
               when 7, 9 then  :et
               when 11   then  :p
               else
                raise ArgumentError,
                  "sub in period 3/5/7/9/11 expected; got #{h.pretty_inspect}"
               end

        periods[:count] += 1
        periods[key][:subs] += 1
      end
   end


   periods
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
