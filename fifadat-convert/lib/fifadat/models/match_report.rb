

##
##  holds details of match (kind of match sheet/report)
##

##  fix-fix-fix  move to tables - yes or rename MatchReportBuilder ?
## move to tables - why? why not?

##
##  fix-fix-fix rename to MatchDetails !!!
##     keep MatchReport/Sheet reserved for later


class MatchReport


def self.build( live, timeline=nil )
      players  = Players.new   ## all players (team1+team2)
      players.add( live['HomeTeam']['Players'] )
      players.add( live['AwayTeam']['Players'] )

      players1 = Players.new
      players1.add( live['HomeTeam']['Players'] )
      players2 = Players.new
      players2.add( live['AwayTeam']['Players'] )


      o = new
      ###
      ##  add goals
      o.goals1 = Goal._build_ary( live['HomeTeam']['Goals'], players: players )
      o.goals2 = Goal._build_ary( live['AwayTeam']['Goals'], players: players )


      ##########
      ##   add penalty kicks / penalties
      ##     note - requires timeline  !!!
      if live['ResultType'] == 2     ## win on pens
         if timeline.nil?
            ##
            team1_code = live['HomeTeam']['Abbreviation']
            team2_code = live['AwayTeam']['Abbreviation']
            puts "!! ERROR - no timeline for match #{team1_code} v #{team2_code} with win on penalties!!"
            exit 1
         else
            ### get timeline with penalty shoot-out details
            ##     note - requires team1/2_ids!!!
            team1_id = live['HomeTeam']['IdTeam']
            team2_id = live['AwayTeam']['IdTeam']

            pens = Penalty._build_ary( timeline['Event'],
                                         players: players,
                                         team1_id: team1_id,
                                         team2_id: team2_id )
            ## pp pens

            o.penalties = pens
         end
      end


      #######
      ##  add lineup/bench
      o.formation1 = live['HomeTeam']['Tactics']   ## e.g. "Tactics": "3-1-4-2"
      o.lineup1    = players1.lineup   ## starter XI (only excludes bench)
      o.bench1     = players1.bench    ## substitutes

      o.formation2 = live['AwayTeam']['Tactics']
      o.lineup2    = players2.lineup
      o.bench2     = players2.bench


      #####
      ## add bookings (yellow/red/red-yellow cards)
      players1.add_bookings( live['HomeTeam']['Bookings'])
      players2.add_bookings( live['AwayTeam']['Bookings'])



      ##
      ##  maybe collect cards on demand (not ahead of time) - why? why not?
      yellow1    = players1.yellowcards
      red1       = players1.redcards
      yellowred1 = players1.yellowredcards

      o.yellow1     = yellow1    unless yellow1.empty?
      o.red1        = red1       unless red1.empty?
      o.yellowred1  = yellowred1 unless yellowred1.empty?

      yellow2    = players2.yellowcards
      red2       = players2.redcards
      yellowred2 = players2.yellowredcards

      o.yellow2     = yellow2    unless yellow2.empty?
      o.red2        = red2       unless red2.empty?
      o.yellowred2  = yellowred2 unless yellowred2.empty?


      ## add substitutions (off/on - in/out)
      o.subs1   =  Sub._build_ary( live['HomeTeam']['Substitutions'], players: players1 )
      o.subs2   =  Sub._build_ary( live['AwayTeam']['Substitutions'], players: players2 )


      ## add referees
      officials = Official._build_ary( live['Officials'] )

      if officials.empty?
         puts "!! WARN no refs / officials found"
      else
         o.officials = officials
      end

      o
end



    attr_accessor :goals1,     :goals2,
                  :penalties,
                  :lineup1,    :lineup2,
                  :bench1,     :bench2,
                  :formation1, :formation2,
                  :yellow1,    :yellow2,
                  :yellowred1, :yellowred2,
                  :red1,       :red2,
                  :subs1,      :subs2,
                  :officials   # aka referees


   def initialize
     @goals1 =  [], @goals2 = []
     @penalties = nil   ## or use [] - why? why not?

     @lineup1 = [], @lineup2 = []
     @bench1  = [], @bench2  = []

     @formation1 = nil, @formation2 = nil

     @yellow1  = []
     @yellow2  = []
     @yellowred1 = []
     @yellowred2  = []
     @red1  = []
     @red2  = []

     @subs1  = [],       @subs2  = []

     @officials = nil
 end


  def sentoff1
     ## pp self
     sentoff1 =  (red1||[]) + (yellowred1||[])
     ## pp red1
     ## pp yellowred1
     ## pp sentoff1
     sentoff1.sort { |l,r|  l.minute <=> r.minute }  ## sort by minute
  end
  def sentoff2
     sentoff2 =  (red2||[]) + (yellowred2||[])
     sentoff2.sort { |l,r|  l.minute <=> r.minute }  ## sort by minute
  end



def as_json(*)
      h = {}

       if goals1 || goals2
         h['goals1']  = (goals1 || []).as_json
         h['goals2']  = (goals2 || []).as_json
       end

       h['penalities'] = penalties.as_json    if penalties

       h['formation1'] = formation1    if formation1
       h['lineup1']    = lineup1.as_json
       h['bench1']     = bench1.as_json

       h['formation2'] = formation2    if formation2
       h['lineup2']    = lineup2.as_json
       h['bench2']     = bench2.as_json

       h['yellow1']     = yellow1.as_json    if yellow1 && !yellow1.empty?
       h['yellow2']     = yellow2.as_json    if yellow2 && !yellow2.empty?
       h['yellowred1']  = yellowred1.as_json   if yellowred1 && !yellowred1.empty?
       h['yellowred2']  = yellowred2.as_json   if yellowred2 && !yellowred2.empty?
       h['red1']        = red1.as_json          if red1 && !red1.empty?
       h['red2']        = red2.as_json          if red2 && !red2.empty?

       h['subs1']     = subs1.as_json
       h['subs2']     = subs2.as_json

       h['referees'] = officials.as_json    if  officials

       h
end


end  ## class MatchReport