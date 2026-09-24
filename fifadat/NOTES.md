# Notes on (unofficial) FIFA API




```
q: what's the difference between

   - live_url( idCompetition:, idSeason:, idStage:, idMatch: )
      "#{BASE_URL}/live/football/#{idCompetition}/#{idSeason}/#{idStage}/#{idMatch}?language=en"

     get_live_match
    Get rich detail for one match: starting lineups, substitutes, officials, attendance, and weather, plus live score and status.
    Works for any match state (a not-yet-started match has an empty lineup and a null score).


used for  ??


   - timeline_url( idCompetition:, idSeason:, idStage:, idMatch: )
       "#{BASE_URL}/timelines/#{idCompetition}/#{idSeason}/#{idStage}/#{idMatch}?language=en"

      get_match_timeline",
    Get one match's event timeline in order: goals, cards, substitutions, and other key events.


used for ??

```
