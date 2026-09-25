=begin
[{"IdStage": "286472",
    "IdSeason": "286466",
    "SeasonName":
     [{"Locale": "en-GB", "Description": "FIFA Club World Cup Morocco 2022™"}],
    "IdCompetition": "107",

    "SequenceOrder": 6,
    "Name": [{"Locale": "en-GB", "Description": "Final"}],
    "StartDate": "2023-02-11T19:00:00Z",
    "EndDate": "2023-02-11T19:00:00Z",
    "StageLevel": null,
    "Type": 0,  add ---??
    "Properties": {"IdIFES": "286472"},
    "IsUpdateable": null},
=end



class Stage
def self.build( h )
   name       = desc( h['Name'] )
   seq        = h['SequenceOrder']
   level      = h['StageLevel']      ## note - is optional

   start_date = nil
   end_date   = nil

   if h['StartDate'] && h['EndDate']
     ## note - start/end dates are utc (NOT local)
     start_date = parse_date_utc( h['StartDate'] )   ## expects  ...:00Z format
     end_date   = parse_date_utc( h['EndDate'] )     ## expects  ...:00Z format

     ## check if HH::MM is 00:00
     ##    only use date for now; ignore time
     ##     report warn(ing) if time present!!!
     if start_date.hour != 0 || start_date.min != 0 ||
        end_date.hour != 0   || end_date.min != 0
        ## issue warn   start/end_date with HH:MM (NOT 00:00)
        puts "!! warn:  stage start/end_date with HH:MM  (expected 00:00)"
        pp h
     end
    else
       ##    maybe add to log later - why? why not?
       ## puts "!! warn:  stage witouout start/end_date"
       ## pp h
   end

   new( name: name,
        seq: seq,
        start_date: start_date ? start_date.to_date : nil,
        end_date:   end_date   ? end_date.to_date : nil,
        level: level )
end



##
##  note - seq might be same for different stages e.g.
##        "seq": 2,
##         "name": "Relegation Round",
##
##      "seq": 2,
##      "name": "Championship Round",
attr_reader :name, :seq, :level,
            :start_date, :end_date

attr_accessor :count

def initialize( name:, seq:,
                level: nil,
                start_date: nil,
                end_date: nil
                )
    @name = name
    @seq  = seq    # e.g. 1,2,3,4,5
    @start_date = start_date
    @end_date   = end_date
    @level     = level
    @count = 0    ## match (usage/reference) count(er)
end


def as_json(*)
      h = {
            'seq'     => seq,
            'name'    => name
           }

      h['start_date'] = start_date.strftime('%Y-%m-%d')    if start_date
      h['end_date']   = end_date.strftime('%Y-%m-%d')      if end_date

      h['level'] = level   if level
      h['count'] = count
      h
end


end   # class Stage