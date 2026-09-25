


class Stages

   def self.read( path )
       data = read_json_v2( path )
       obj = new
       obj.add( data['Results'] )
       obj
   end


   def initialize
      @recs = {}
   end

   def add( recs )    ## rename to collect - why? why not?
      recs.each { |h| _add( Stage.build(h)) }
   end


   def _add( new_rec )
      rec =  @recs[ new_rec.name ]
      if rec.nil?
          @recs[ new_rec.name ] = new_rec
      else
          raise ArgumentError, "duplicate stage entry: #{new_rec.pretty_inspect}"
      end
   end


   ## add match stats
   def add_matches( matches )
        matches.each do |m|
          name = desc( m['StageName'] )
          rec  = find!( name )
          rec.count += 1
        end
   end


   def find!( name )
       rec = @recs[ name ]
       raise ArgumentError, "no stage w/ name >#{name}< found; sorry"  if rec.nil?
       rec
   end

   def as_json(*)
        ## note - sort by seq
        @recs.values.sort do |l,r|
             l.seq <=> r.seq
         end.as_json
   end

   def size() @recs.size; end

end  # class Stages
