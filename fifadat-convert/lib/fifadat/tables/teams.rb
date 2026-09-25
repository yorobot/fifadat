


class Teams        ## use/change to TeamsRegistry, TeamsLookup, etc
   def initialize
      @recs = {}
   end

   def add_matches( matches )
      ## note -   if team nil - will (auto-)add nil team (<nil>,?,?,?)
      matches.each do |m|
        rec1 = _add( Team.build( m['Home'] ) )
        rec2 = _add( Team.build( m['Away'] ) )

        stage_name = desc(m['StageName'])
        rec1.count[stage_name] += 1
        rec2.count[stage_name] += 1
      end
   end



   def _add( new_rec )
      rec =  @recs[ new_rec.id ]
      if rec.nil?
          rec = new_rec
          @recs[ new_rec.id ] = new_rec
      else
          ## assert attributes equal - why? why not?
          assert( new_rec == rec,
                  "team records NOT matching - #{rec.pretty_inspect} != #{new_rec.pretty_inspect}")
      end
      rec
   end


   def find!( h )
      ##  team1 = teams.find( m['HomeTeam'] )
      ##  team2 = teams.find( m['AwayTeam'] )
      ##  use lookup by  "IdTeam": "33161" for now - why? why not?

      ## check for nil - why? why not?
       rec = @recs[ h['IdTeam'] ]
       raise ArgumentError, "team not found using #{h.pretty_inspect}  "  if rec.nil?
       rec
   end




   def as_json( id: false )  ## note ignore remove id for now
        @recs.values.as_json
   end

   def size() @recs.size; end

end  # class Teams
