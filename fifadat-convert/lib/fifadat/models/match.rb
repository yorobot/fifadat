

class Match


def self.build( m, teams:, stadiums:, stages: )   ## use _fill/build_match_basics() or such ???
    rec = {}

       ## 0 =>   FINISHED/complete (OK)
       ## 1 =>   SCHEDULED/not yet played
       status = m['MatchStatus']
       timed  = m['TimeDefined']
       rec[:timed] = timed    ### note - keep timed flag too - why? why not?


       if status == 1 && timed    ## note: use TIMED (instead of SCHEDULED)
          rec[:status] = 'TIMED'
       else
          rec[:status] = MATCH_STATUS[ status ] || "#{status}-???"
       end



       rec[:stage]  = stages.find!( desc( m['StageName'] ))


       ## check optional  group, matchday, (match) num
       ##    note - matchday is a string!! (check if always a number)
       ##      ## convert to int if str - why? why not??
       group = desc( m['GroupName'] )
       rec[:group]  = group   if group

       matchday  = m['MatchDay']
       rec[:matchday]  = matchday.to_i(10)  if matchday

       num  = m['MatchNumber']
       rec[:num]  = num   if num


## e.g. if timed == false  (in at)
##     "Date":      "2027-02-27T00:00:00Z",
##     "LocalDate": "2027-02-27T01:00:00Z",

       dateTime       = parse_date_utc( m['Date'] )
       localDateTime  = parse_date_utc( m['LocalDate'] )

       if timed
         ##  pass along as is for now - why? why not
         ##   note - Date is date_utc and
         ##      LocalDate is date_local (also in utc BUT different HH:MM or possible day)
         ## note - also in utc, that is, timezone is Z (not +03:00 or such!!!)

         ## note - use datetime  - why? why not?
         ##
         ## note - cut-off/remove seconds
         rec[:datetime_utc]   = dateTime.strftime( '%Y-%m-%dT%H:%MZ' )

         ## note - use  20:30 UTC+1  or 20:30 UTC-3  for timezone format for now
         rec[:date_local] = localDateTime.strftime( '%Y-%m-%d' )
         rec[:time_local] = _fmt_time_local( dateTime, localDateTime )
       else
         ## note - uses
         ## todo/fix - assert  that utc  hour/minute is 00:00 e.g.
         ##   "2027-02-27T00:00:00Z"
         rec[:date_local] = dateTime.strftime( '%Y-%m-%d' )
       end



       if m['HomeTeam'] && m['AwayTeam']   ## assume match reports (json-style)
         team1 = teams.find!( m['HomeTeam'] )
         team2 = teams.find!( m['AwayTeam'] )
       else
         team1 =  teams.find!( m['Home'] )
         team2 =  teams.find!( m['Away'] )
       end

       rec[:team1] = team1
       rec[:team2] = team2

  #####
  #  handle score
  ## m = (full) match hash incl.  IdMatch, etc.
  ##  returns string e.g.  4-4  or 4-3 a.e.t etc

   ##
   ## fix-fix-fix
   ##   use a score class!!!
   ##   see openliga etc.

     score = _parse_score( m )
     rec[:score] = score      unless score.empty?


       ## check - never in use?
       rec[:home]  = true    if m['IsHome']


       ## add country to stadium too - why? why not?
       rec[:stadium] = stadiums.find!( m['Stadium'] )


       attendance = m['Attendance']
       rec[:attendance] = attendance.to_i(10)   if attendance


      new( **rec )
end


attr_reader :status,
            :team1, :team2,
            :stage, :group, :matchday, :num,
            :datetime_utc,
            :date_local,
            :time_local, :timed,
            :stadium, :home, :attendance

attr_accessor :score,
              :goals1, :goals2,
              :penalties,
              :sentoff1, :sentoff2,
              :referees


def initialize(
      status:,
      team1:,
      team2:,
      score: nil,

      stage: nil,
      group: nil,
      matchday: nil,
      num: nil,

      datetime_utc: nil,
      date_local: nil,
      time_local: nil,
      timed: nil,

      stadium: nil,
      home: nil,
      attendance: nil)
  @status = status
  @team1 = team1
  @team2 = team2
  @score = score

  @stage    = stage
  @group    = group
  @matchday = matchday
  @num      = num

  @datetime_utc = datetime_utc
  @date_local = date_local
  @time_local = time_local
  @timed = timed

  @stadium = stadium
  @home = home
  @attendance = attendance
end



def as_json(*)
      h = {
            'status'    => status,
            'stage'     => stage.name,
          }

       h['matchday']  = matchday     if matchday
       h['num']       = num          if num
       h['group']     = group        if group

       if timed
          h['datetime_utc'] = datetime_utc
          h['date_local'] = date_local
          h['time_local'] = time_local
       else
          h['date_local'] = date_local
       end

       h['team1']  = team1.name
       h['team2']  = team2.name

       h['score'] = score     if score


       if stadium
         h['stadium'] = { 'name' => stadium.name,
                          'city' => stadium.city }
       end

       h['attendance']  if attendance



       if goals1 || goals2
         h['goals1']  = (goals1 || []).as_json
         h['goals2']  = (goals2 || []).as_json
       end

       h['penalities']   if penalties

       if sentoff1 || sentoff2
         h['sentoff1']  = sentoff1 || []
         h['sentoff2']  = sentoff2 || []
       end


       h['referees'] = referees    if referees
    h
end

end  # class Match