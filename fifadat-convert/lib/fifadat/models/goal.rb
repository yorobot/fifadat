
class Goal


## add alias _build_all or _build_collection or ?? - why? why not?
def self._build_ary( recs, players:,
                           penalties: false )

    ## note - filter out penalties (from shoot-out)!!
    ##    min > 120  (e.g. 121, etc.)
    ##  note - use period (more reliable)
    ##   period 11 is PENALTY_SHOOTOUT!!
    if penalties == false
       recs = recs.select { |rec| rec['Period'] != 11 }
    end


    recs = recs.map  { |h| build( h, players: players ) }

    ## note - sort by minutes; goals may not be sorted
    recs = recs.sort { |l,r| l.minute <=> r.minute }
    recs
end


def self.build( h, players: )

    ## split into minute
    ##  and offset (stoppage/injury time)
    ##  e.g. 90'+11'

     h = errata_autofix_goal( h )

     minute_str = h['Minute']

     period = h['Period']

     ##   note - penalty shootout gets excluded upstream!!
     ##  include penalty shootout (11) - why? why not?
     ## assert(  [3,5,7,9].include?(period),
     ##             "goal in period 3/5/7/9 expected; got #{h.pretty_inspect}" )

    ##  quick fix:
    ## check for weird minute 0 e.g.
    ##   Germany-Austria 1934
    if minute_str == "0'"
       h['Minute'] = "1'"
    end

    if minute_str.nil? || minute_str.empty?
           puts "!! minute in goal is nil or empty:"
           pp h
           exit 1
    end

    minute = _build_minute( h )


    rec = {}

      idPlayer = h['IdPlayer']

      if idPlayer.nil?
         puts "!! no idPlayer for goal (live):"
         pp h
          ##exit 1
          ## use 'N.N.'

          rec[ :player ] = Player::PLAYER_NIL  ## 'N.N.'

      else
        rec[ :player ] = players.find!( idPlayer )
      end

     rec[ :minute] = minute


      ## check for goal type (og) or (p)
      ##  1 -  "penalty"
      ##  2 -  "regular"
      ##  3 -  "own goal"

      type =  h['Type']
      rec[ :pen ] = true  if type == 1
      rec[ :og ]  = true  if type == 3

      new( **rec )
end





attr_reader :player, :minute,
            :pen, :og

def initialize(
     player:,
     minute:,
     pen: false, og: false)
  @player = player
  @minute = minute
  @pen    = pen
  @og     = og
end


def as_json(*)
      h = {
            'name'     => player.name,
            'minute'   => minute,
          }

       h['og']    = og   if og
       h['pen']   = pen  if pen
       h
end


end  # class Goal