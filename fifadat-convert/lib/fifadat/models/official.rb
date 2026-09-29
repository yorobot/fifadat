
=begin

=begin
   "Officials":
     [{"IdCountry": "BRA",
       "OfficialId": "361561",
       "NameShort": [{"Locale": "en-GB", "Description": "Wilton SAMPAIO"}],
       "Name": [{"Locale": "en-GB", "Description": "Wilton SAMPAIO"}],
       "OfficialType": 1,
       "TypeLocalized": [{"Locale": "en-GB", "Description": "Referee"}]},
      {"IdCountry": "PAR",
       "OfficialId": "416159",
       "NameShort":
        [{"Locale": "en-GB", "Description": "Juan Gabriel BENITEZ"}],
       "Name": [{"Locale": "en-GB", "Description": "Juan Gabriel Benítez"}],
       "OfficialType": 4,
       "TypeLocalized":
        [{"Locale": "en-GB", "Description": "Fourth official"}]}],


  "Officials":
     [{"IdCountry": "URU",
       "OfficialId": "61038",
       "NameShort": [{"Locale": "en-GB", "Description": "Domingo LOMBARDI"}],
       "Name": [{"Locale": "en-GB", "Description": "Domingo LOMBARDI"}],
       "OfficialType": 1,
       "TypeLocalized": [{"Locale": "en-GB", "Description": "Referee"}]},
      {"IdCountry": "BEL",
       "OfficialId": "60664",
       "NameShort": [{"Locale": "en-GB", "Description": "Henry CRISTOPHE"}],
       "Name": [{"Locale": "en-GB", "Description": "Henry CRISTOPHE"}],
       "OfficialType": 2,
       "TypeLocalized":
        [{"Locale": "en-GB", "Description": "Assistant Referee 1"}]},
      {"IdCountry": "BRA",
       "OfficialId": "61289",
       "NameShort": [{"Locale": "en-GB", "Description": "Gilberto REGO"}],
       "Name": [{"Locale": "en-GB", "Description": "Gilberto REGO"}],
       "OfficialType": 3,
       "TypeLocalized":
        [{"Locale": "en-GB", "Description": "Assistant Referee 2"}]}],

=end


class Official

  TYPE_OFFICIAL = {
    1 => 'Referee',
    2 => 'Assistant Referee 1',
    3 => 'Assistant Referee 2',
  }


def self.build( h )
    name = desc( h['Name'] )

    ## fix - use norm_official
    ## name = norm_official( name )

    idCountry = h['IdCountry']
    type      = h['OfficialType']

    assert( is_alpha?(name), "official name alpha expected; got #{pp_alpha(name)}" )

    assert( [1,2,3,4,5,6,7,8,9,10].include?( type ), "official type 1/2/3/4/5/6/7/8/9/10 expected; got #{type}" )

    rec = {   id:  h['OfficialId'],
              name:      name,
              country:   idCountry,
              type:      TYPE_OFFICIAL[type]  ## change type to literal string
           }

    new(**rec)
end

def self._build_ary( recs )  ## use referees?

    ## skip fourth official (4) for now
    recs = recs.select { |h|  [1,2,3].include?( h['OfficialType'] ) }

    ## sort by type 1/2/3
    ##  1 - referee
    ##  2 - assistant referee 1
    ##  3 - assistant referee 2
    ##  4 - fourth official
    ##  5 - video assistant referee (var)
    ##  6 - reserve referee
    ##  7 - offside var
    ##  8 - assistant var
    ##  9 - support var
    ## 10 - reserve assistant referee
    recs = recs.sort { |l,r|  l['OfficialType'] <=> r['OfficialType'] }


    recs = recs.map  { |h| build( h ) }

    recs
end

attr_reader :id, :name, :country, :type

def initialize( id:, name:, country:, type:)
  @id   = id
  @name    = name
  @country = country
  @type    = type
end

   def as_json(*)
      h = {
            'name'      => name,
            'country'   => country,
            'type'      => type,
          }
      h
   end





end # class Official