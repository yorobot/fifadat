




def build_goals( recs, players:,  penalties: false )

    ## note - filter out penalties (from shoot-out)!!
    ##    min > 120  (e.g. 121, etc.)
    ##  note - use period (more reliable)
    ##   period 11 is PENALTY_SHOOTOUT!!
    if penalties == false
       recs = recs.select { |rec| rec['Period'] != 11 }
    end


    recs = recs.map  { |h| Goal.build( h, players: players ) }

    ## note - sort by minutes; goals may not be sorted
    recs = recs.sort { |l,r| l.minute <=> r.minute }
    recs
end
