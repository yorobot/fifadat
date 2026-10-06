
###
## collect more meta data


def collect_matchstatus( matches )
    counter = Hash.new(0)

    matches.each do |m|
      matchStatus = m['MatchStatus']
      resultType  = m['ResultType']

      key  = ""
      key +=    if matchStatus == 1 && m['TimeDefined']  ## special scheduled case (use timed)
                    'TIMED'
                else
                    MATCH_STATUS[matchStatus] || "???-#{matchStatus}"
                end
      key += "-"
      key +=  RESULT_TYPE[resultType] ||"???-#{resultType}"

      counter[key] += 1

    end

    counter
end