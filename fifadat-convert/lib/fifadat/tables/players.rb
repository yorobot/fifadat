#
# note - players here are for lineup (subs+bookings) and incl. starter/bench AND pos etc.
#               do NOT use for team squads




class Players
   def initialize
      @recs = {}
   end

   def add( recs )    ## rename to collect - why? why not?
      recs.each do |h|
          rec = _add( Player.build(h))
          rec.count += 1    ## track usage - why? why not?
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
                  "player records NOT matching - #{rec.pretty_inspect} != #{new_rec.pretty_inspect}")
      end

      rec
   end



   def find( id_player )
       rec = @recs[ id_player ]
       rec
   end

   def find!( id_player )
       rec = @recs[ id_player ]
       raise ArgumentError, "no player w/ id >#{id_player}< found; sorry"  if rec.nil?
       rec
   end




   ###
   ## todo/check
   ##    add alias (or rename) starter  ??
   ##   add new subs to  status == 2  - why? why not?
   def lineup
      recs = @recs.values.select { |rec| rec.starter? }

      ## recs = recs.map {|rec| rec.except( :id, :status, :count ) }
      recs
   end

   def bench
      recs = @recs.values.select { |rec| rec.bench? }

      ## recs = recs.map {|rec| rec.except( :id, :status, :count ) }
      recs
   end




   def redcards
      recs = @recs.values.select { |rec| rec.red? }
      recs = recs.map { |rec| rec.r }
      recs
   end

   def yellowcards
      recs = @recs.values.select { |rec| rec.yellow? }
      recs = recs.map { |rec| rec.y }
      recs
   end

   def yellowredcards
      recs = @recs.values.select { |rec| rec.yellowred? }
      recs = recs.map { |rec| rec.yr }
      recs
   end



   def add_bookings( bookings )  ##  yellow/red cards
      bookings.each do |b|

         card = b['Card']
         assert( [0,1,2,3].include?( card ), "card 0/1/2/3 expected; got #{b.pretty_inspect}")

         ##
         ## what is card 0?  ignore for now
         ##  Palmeiras v FC Porto  0-0   - 2025-06-15T18:00:00+00:00
         ## !! ASSERT FAILED - card 1/2/3 expected; got {"Card"=>0,
         ## "Period"=>5,
         ## "IdEvent"=>nil,
         ## "EventNumber"=>nil,
         ## "IdPlayer"=>"495048",
         ## "IdCoach"=>nil,
         ## "IdTeam"=>"1884426",
         ## "Minute"=>"72'",
         ## "Reason"=>nil}
         next if card == 0


         idPlayer = b['IdPlayer']

         ## booking (card) for coach or stuff!!!!
         ##   skip for now
         next   if idPlayer.nil? && (b['IdCoach'] || b['IdStaff'])


         player = @recs[ idPlayer ]
         assert( player, "booking player not found; sorry - #{b.pretty_inspect}" )

           ## note - parse & reformat minute for keep same format
          ## _fmt_minute( *_parse_minute( b['Minute'] ))
         minute = _build_minute( b )

          if card == 1      ## yellow
             player.y =  Player::Card.new( player: player, type: 'Y', minute: minute )
          elsif card == 2   ## red
             player.r =  Player::Card.new( player: player, type: 'R', minute: minute )
          elsif card == 3   ## yellow/red
             player.yr = Player::Card.new( player: player, type: 'YR', minute: minute )
          end
      end
   end



   def dump
      pp @recs.values
      puts "  #{@recs.size} player(s)"
   end

   def size() @recs.size; end

end  # class Players
