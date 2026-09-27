###
# prepare a countries page / report / summary
#  to run use:
#
#   $  ruby sandbox/countries.rb

require 'cocos'


def assert( test, msg )
    if test
    else
        puts "!! ASSERT FAILED - #{msg}"
        exit 1
    end
end

def desc( data )   ## get description
    return nil if data.nil? || (data.is_a?(Array) && data.empty?)

    row = data[0]   ## assume first entry is en-GB
    locale = row['Locale']
    assert( locale == 'en-GB' || locale == 'en-gb',
              "locale en-GB expected in data[0] - got #{data}")

    row['Description']
end






path = "/sports/yorobot/fifadat/cache.json/countries.json"

##  note - use ['Results'] as root
data  = read_json( path )['Results']

puts "  #{data.size} record(s)"
##  235 record(s)


data.each do |h|

  code = h['IdCountry']
  name = h['Name']
  alpha2 = h['Iso3166Alpha2']
  alpha3 = h['Iso3166Alpha3']
  altname  = desc( h['Alias'] )


  print "#{code} | #{name}"
  print " · #{altname}"  if name != altname

  print " | #{alpha2} #{alpha3}"
  print "\n"
end


puts "bye"