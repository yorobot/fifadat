##
## note - always use latest (local) version if present
$LOAD_PATH.unshift( '/sports/rubycocos/webclient/webclient/lib' )
$LOAD_PATH.unshift( '/sports/rubycocos/webclient/webget/lib' )

require 'cocos'   ## check if incl webclient already?
require 'webclient'

require 'season-formats'



require_relative 'fifadat/json'    ## read_json_v2, fetch_json, fetch_json_if, etc.



###
##  our own code
require_relative 'fifadat/version'

require_relative 'fifadat/helper'
require_relative 'fifadat/config'
require_relative 'fifadat/api'
require_relative 'fifadat/types'

require_relative 'fifadat/prepare'   ## "all-in-one" prepare (download cache) helpers etc.


puts Fifadat.banner  ## say hello
