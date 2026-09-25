
class Goal


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
         puts "!! no idPlayer for goal!"
         pp h
          ##exit 1
          ## use 'N.N.'

          rec[ :name ] = 'N.N.'

      else
        player = players.find!( idPlayer )
        rec[ :name ] = player[ :name ]
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



attr_reader :name, :minute,
            :pen, :og

def initialize(
     name:,
     minute:,
     pen: false, og: false)
  @name   = name
  @minute = minute
  @pen    = pen
  @og     = og
end


def as_json(*)
      h = {
            'name'     => name,
            'minute'   => minute,
          }

       h['og']    = og   if og
       h['pen']   = pen  if pen
       h
end


end  # class Goal