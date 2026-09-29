
# TYPE_PLAYER_POS = {
#   0 => 'GK',
#   1 => 'DF',
#   2 => 'MF',
#   3 => 'FW',
#   4 => '??',
#   5 => '??',
#   6 => '??'
# }

def build_player( h )
   name       = desc( h['PlayerName'] )

   if name.nil?
     ## "PlayerName"=>[],
     ## "ShortName"=>[{"Locale"=>"en-gb", "Description"=>"S. Lainer"}],

     ## hack:
     ##  use shortname
      name = desc( h['ShortName'] )
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


   short_name = desc( h['ShortName'] )

   ##
   ##  todo/check - add IdCountry if available??


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

  rec
end
