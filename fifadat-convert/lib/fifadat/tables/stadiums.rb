


class Stadiums
   def initialize
      @recs = {}
   end

   def add_matches( matches )  ## rename to add_matches - why? why not?
     matches.each_with_index do |m|
       stadium = Stadium.build( m['Stadium'] )
       rec = _add( stadium )

       ## update match counter by team
       team_name = desc(m['Home']['TeamName'])
       rec.count[ team_name ] += 1
     end
   end



   def _add( new_rec )
      rec =  @recs[ new_rec.id ]
      if rec.nil?
          rec = new_rec
          @recs[ new_rec.id] = new_rec
      else
          ## assert attributes equal - why? why not?
         assert( new_rec == rec,
                  "stadium records NOT matching - #{rec.pretty_inspect} != #{new_rec.pretty_inspect}")
      end
      rec
   end



  def find!( h )
      if h
        name  = desc( h['Name'] )
        city  = desc( h['CityName'] )
        ## auto-generate id
        ##  use slug of name plus id_city
        ## add city name
        ##  fix- add   0-9 & dash(-) to name too - why? why not?
        id  =       name.downcase.gsub( /[^a-z]/, '' )
        id += "_" + city.downcase.gsub( /[^a-z]/, '' )
      else
        puts "warn: empty stadium lookup:"
        pp h
        id = '<nil>'
      end

      ## check for nil - why? why not?
       rec = @recs[ id ]
       if rec.nil?
          puts "#{@recs.size} stadiums:"
          pp @recs.keys
          raise ArgumentError, "stadium not found using >#{id}< - #{h.pretty_inspect}"
       end
       rec
   end



   def as_json( id: false )  ## note ignore remove id for now
        @recs.values.as_json
   end

   def size() @recs.size; end

end  # class Stadiums
