

def log( msg )
   ## append msg to ./fifadat.log
   ##
   ##  change to /logs-fifadat.txt or such - why? why not?
   ##     keep .txt extension; prefer over .log - why? why not?
   timestamp = Time.now.strftime( '%a %b %d %h:%m %Y' )

   File.open( './logs-fifadat.txt', 'a:utf-8' ) do |f|
     f.write( "[Fifadat] #{timestamp} - " + msg )
     f.write( "\n" )
   end
end
