
#
# note - players here are for lineup (subs+bookings) and incl. starter/bench AND pos etc.
#               do NOT use for team squads


# TYPE_PLAYER_POS = {
#   0 => 'GK',
#   1 => 'DF',
#   2 => 'MF',
#   3 => 'FW',
#   4 => '??',
#   5 => '??',
#   6 => '??'
# }


class Player


###
## keep Card nested here - why? why not?
class Card

   attr_reader :player, :type, :minute
   def initialize( player:, type:, minute: )
      @player = player
      @type   = type
      @minute = minute
   end

   ## only print name and minute for now - why? why not?
   def as_json(*)
      h = {
            'name'     => player.name,
            'minute'   => minute
          }
      h
   end
end  # class Card



def self._build_ary( recs )
    recs.map { |h| build( h ) }
end


def self.build( h )

   name       = desc( h['PlayerName'] )
   short_name = desc( h['ShortName'] )

   if name.nil?
     ## "PlayerName"=>[],
     ## "ShortName"=>[{"Locale"=>"en-gb", "Description"=>"S. Lainer"}],

     ## hack:
     ##  use shortname
      name = short_name
   end

   if name.nil?
      ## puts "name is nil:"
      ## pp h
      ## exit 1
      ##  report/log error/warn
      ##
      ## quick fix use N.N. for now
      name = 'N.N.'
   end

   ## name = norm_player( name )


   ##
   ##  todo/check - add IdCountry if available??

   ##  1 -  starter
   ##  2 -  bench

   status = h['Status']
   assert( [1,2].include?( status ), "player status 1,2 expected; got #{h.inspect}")

   ## what is pos 6 ??
   ## e.g.
   ##   !! ASSERT FAILED
   ## {"IdPlayer"=>"419456", "IdTeam"=>"32759", "ShirtNumber"=>4, "Status"=>1,
   ## "PlayerName"=>[{"Locale"=>"en-GB", "Description"=>"Ismaila COULIBALY"}],
   ##  "ShortName"=>[{"Locale"=>"en-GB", "Description"=>"Ismaila COULIBALY"}],
   ## "Position"=>6, "PlayerPicture"=>nil,
   ## "FieldStatus"=>2, "LineupX"=>nil, "LineupY"=>nil}
   ##
   ## what is pos 5 ??
   ##  e.g.
   ## {"IdPlayer"=>"7czui1ih46j3zitzysxvjqjv8", "IdTeam"=>"2000019848", "ShirtNumber"=>33,
   ##  "Status"=>1,
   ## "PlayerName"=>[{"Locale"=>"en-gb", "Description"=>"Maximilian Hennig"}],
   ## "ShortName"=>[{"Locale"=>"en-gb", "Description"=>"M. Hennig"}],
   ## "Position"=>5, "PlayerPicture"=>nil, "FieldStatus"=>2, "LineupX"=>nil, "LineupY"=>nil}
   ##
   ## what is pos 4 ??
   ##  {"IdPlayer"=>"254150", "IdTeam"=>"2000017585", "ShirtNumber"=>15,
   ## "Status"=>2, "SpecialStatus"=>nil, "Captain"=>false,
   ## "PlayerName"=>[{"Locale"=>"en-GB", "Description"=>"Nemanja RNIC"}],
   ## "ShortName"=>[{"Locale"=>"en-gb", "Description"=>"N. Rnić"}],
   ## "Position"=>4, "PlayerPicture"=>nil, "FieldStatus"=>1, "LineupX"=>nil, "LineupY"=>nil}


   pos = h['Position']
   assert( [0,1,2,3,4,5,6].include?( pos ), "player pos 0,1,2,3,4,5,6 expected; got #{h.inspect}" )

   ##    0 - is always goal keeper
   ##   check meaning of 1 to 6
   ##     on website !!!
   ##       pos is NOT (simply) matching tactics/formation (index number)!!

   rec = { id:      h['IdPlayer'],
           name:        name,
           short_name:  short_name,
           status:      status,
           pos:         pos,
        }

    ## check for shirtNumber too
    num = h['ShirtNumber']
    rec[:num]     = num  if num

    rec[:captain]  = true   if h['Captain']


    new( **rec )
end





attr_reader :id, :name, :short_name,
            :status, :pos,
            :captain, :num


attr_accessor :count,
              :y, :yr, :r     ## yello/yellowred/red cards




def initialize( id:,
                name:,
                status:,   ## 1 - starter, 2 - bench
                pos:,
                short_name: nil,
                captain: false,
                num: nil         ## shirt/jersey number
               )
    @id = id
    @name = name
    @short_name = name
    @status = status
    @pos  = pos
    @captain = captain
    @num  = num

    @count = 0

    @y  = nil
    @yr = nil
    @r  = nil
end

PLAYER_NIL = new( id:    '<nil>',
                  name:  'N.N.',
                  status: nil,
                  pos:    nil
                )


def starter?() status == 1; end
def bench?()   status == 2; end

## add alias yellow_card? or y? - why? why not?
def yellow?()     y.is_a?(Card); end
def yellowred?()  yr.is_a?(Card); end
def red?()        r.is_a?(Card); end




def ==(other)
    return false   unless other.is_a?(Player)

    self.name       == other.name &&
    self.short_name == other.short_name
end


def as_json(*)
      h = {
            'name'           => name,
            'short_name'     => short_name,
            'id'             => id,
            ##  use starter|bench !!!
            'status'         => status,
            ##  todo - map pos
            'pos'            => pos,
          }


       h['captain'] = captain  if captain
       h['num']     = num      if num
       h
end



end  # class Player