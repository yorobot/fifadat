
$LOAD_PATH.unshift( '/sports/yorobot/fifadat/fifadat/lib' )
require 'fifadat'


## our own code
require_relative 'convert/version'
require_relative 'convert/tool'    ## fifadat command-line tool


require_relative 'convert/norm'
require_relative 'convert/errata'

require_relative 'convert/stages'
require_relative 'convert/teams'
require_relative 'convert/stadiums'
require_relative 'convert/players'

require_relative 'convert/officials'   ## aka referees
require_relative 'convert/goals'
require_relative 'convert/goals-calc_score'
require_relative 'convert/penalties'
require_relative 'convert/substitutions'


require_relative 'convert/build_match'
require_relative 'convert/build_report'
require_relative 'convert/convert'
require_relative 'convert/convert-reports'

require_relative 'convert/helper-date'
require_relative 'convert/helper-score'
require_relative 'convert/helper-minute'



puts FifadatConvert.banner    ## say hello
