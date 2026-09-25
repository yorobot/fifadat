

class Team


def self.build( h )
   if h
      name = desc( h['TeamName'] )
      ##  name = norm_team( name )

      new( id:      h['IdTeam'],
           name:    name,
           code:    h['Abbreviation'],
           country: h['IdCountry']    ## change to cc (country code) - why? why not?
         )
   else    ## assume nil - dummy record
      TEAM_NIL
   end
end



attr_reader :id, :name, :code, :country

attr_accessor :count

def initialize( name:,
                id: nil,
                code: nil, country: nil )
    @name    = name
    @id      = id
    @code    = code
    @country = country

    @count = Hash.new(0)   ## match (reference/usage) count(er) by stage (name)!!
end


  ## shared dummy/nil record
  TEAM_NIL = self.new( id:      '<nil>',
                       name:    '?',
                       code:    '?',           ## use nil - why? why not?
                       country: '?' )          ## use nil - why? why not?



=begin
!! ASSERT FAILED - team records NOT matching -
{:id=>"44129",
 :name=>"Vasco da Gama",
 :code=>"VDG",
 :country=>"BRA",
 :count=>7}
 !=
 {:id=>"44129",
  :name=>"Vasco da Gama",
  :code=>"VAS",
  :country=>"BRA"}
=end


def ==(other)
    return false   unless other.is_a?(Team)

    ## check code too - why? why not?
    ##   note - ignore code for now
    self.id      == other.id &&
    self.name    == other.name &&
    self.country == other.country
end


def as_json(*)
      h = {
            'name'    => name,
            'code'    => code,
            'country' => country,
            'count'   => count,
            'id'      => id
          }
      h
end


end # class Team
