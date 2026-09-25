
class Stadium


def self.build( h )
   if h
     ## note - for now stadiums have no ids!!!!!
     ##    check if any ids found
     id         = h['IdStadium']
     id_country = h['IdCountry']

     ## same with city - no ids really in use
     ##    id_city    = h['IdCity']

     name      = desc( h['Name'] )
     city_name = desc( h['CityName'] )

     if name.nil?
       puts "stadium without name:"
       pp h
       exit 1
     end

     ## name, city_name = norm_stadium( name, city_name: city_name )

     new( id: id,
          name: name,
          city: city_name,
          country: id_country,
          street: h['Street']
          )

   else    ## assume nil - dummy record
       STADIUM_NIL
   end
end



attr_reader :id, :name, :street, :city, :country
attr_accessor :count
def initialize( name:, country:, city:,
                 street: nil,
                 id: nil )
   @name = name
   @country = country
   @city = city
   @street = street

    if id.nil?
        ## auto-generate id
        ##  use slug of name plus id_city
        ## add city name
        ##  fix- add   0-9 & dash(-) to name too - why? why not?
        id  =       name.downcase.gsub( /[^a-z]/, '' )
        id += "_" + city.downcase.gsub( /[^a-z]/, '' )
    end
   @id  = id

   ## note - count matches by (home) teams!!!
   @count = Hash.new(0)
end


## dummy/nil record
STADIUM_NIL = self.new(  id:      '<nil>',
                         name:    '?',
                         city:    '?',   ## use nil - why? why not?
                         country: '?'    ## use nil - why? why not?
                      )


def ==(other)
    return false   unless other.is_a?(Stadium)

    ## note - ignore street (and always empty id) for now!!!
    self.name    == other.name &&
    self.city    == other.city &&
    self.country == other.country
end


def as_json(*)
      h = {
            'name'     => name
          }

       h['street']    = street   if street
       h['city']      = city     if city
       h['country']   = country  if country

       h['count'] = count
       h
end



end # class Stadium