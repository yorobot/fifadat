
def build_stage( h )
   name       = desc( h['Name'] )
   seq        = h['SequenceOrder']
   level      = h['StageLevel']      ## note - is optional

   rec = {
        ##  id:          h['IdStage'],   ## convert to number - why? why not?
           seq:             seq,
           name:            name,
   }


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

      rec[:start_date] = start_date.strftime('%Y-%m-%d')
      rec[:end_date]   = end_date.strftime('%Y-%m-%d')
   else
       ##    maybe add to log later - why? why not?
       ## puts "!! warn:  stage witouout start/end_date"
       ## pp h
   end

   rec[:count] = 0

  rec[:level] = level   if level

  rec
end
