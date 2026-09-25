
def build_stadium( h )
   if h
     id         = h['IdStadium']
     id_country = h['IdCountry']
 ##    id_city    = h['IdCity']

     name      = desc( h['Name'] )
     city_name = desc( h['CityName'] )


     if name.nil?
       puts "stadium without name:"
       pp h
       exit 1
     end

     ## name, city_name = norm_stadium( name, city_name: city_name )


     if id.nil?
        ## auto-generate id
        ##  use slug of name plus id_city
        ## add city name
        ##  fix- add   0-9 & dash(-) to name too - why? why not?
        id  =       name.downcase.gsub( /[^a-z]/, '' )
        id += "_" + city_name.downcase.gsub( /[^a-z]/, '' )
     end


   rec = { id:        id,
           name:      name,
           city:      city_name
         }

   rec[:street] = h['Street']   if h['Street']

   rec[:country] = id_country    ### fix - change to cc/country code - why? why not?

   rec
  else    ## assume nil - dummy record
     rec =  {
         id:      '<nil>',
         name:    '?',
         city:    '?',   ## use nil - why? why not?
         country: '?'    ## use nil - why? why not?
            }
      rec
   end
end
