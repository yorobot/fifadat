
$LOAD_PATH.unshift( '/sports/yorobot/fifadat/fifadat/lib' )
require 'fifadat'


# module JsonSerializable
#  def to_json(*args)
#    as_json.to_json(*args)
#  end
# end

###
##  add as_json  to Object/Array/Hash
class Object
  def as_json(*)
    self
  end
end

class Array
  def as_json(*)
    map { |v| v.as_json }
  end
end

class Hash
  def as_json(*)
    each_with_object({}) do |(k, v), h|
      h[k.to_s] = v.as_json
    end
  end
end




## our own code
require_relative 'convert/version'
require_relative 'convert/tool'    ## fifadat command-line tool


require_relative 'convert/norm'
require_relative 'convert/errata'

require_relative 'convert/players'

require_relative 'convert/officials'   ## aka referees
require_relative 'convert/goals'
require_relative 'convert/goals-calc_score'
require_relative 'convert/penalties'
require_relative 'convert/substitutions'


require_relative 'convert/build_report'
require_relative 'convert/convert'
require_relative 'convert/convert-reports'

require_relative 'convert/helper-date'
require_relative 'convert/helper-score'
require_relative 'convert/helper-minute'



require_relative 'models/stage'
require_relative 'models/team'
require_relative 'models/stadium'
require_relative 'models/match'
require_relative 'models/goal'


require_relative 'tables/stages'
require_relative 'tables/teams'
require_relative 'tables/stadiums'




puts FifadatConvert.banner    ## say hello
