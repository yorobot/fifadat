

def build_team( h )

   if h
      name = desc( h['TeamName'] )

      ##  name = norm_team( name )

      rec = {
           id:      h['IdTeam'],
           name:    name,
           code:    h['Abbreviation'],
           country: h['IdCountry'],     ## change to cc (country code) - why? why not?
        }

     rec
   else    ## assume nil - dummy record
     rec =  {
         id:     '<nil>',
         name:    '?',
         code:    '?',   ## use nil - why? why not?
         country: '?' ## use nil - why? why not?
            }
      rec
   end
end
