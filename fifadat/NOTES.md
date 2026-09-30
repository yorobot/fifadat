# Notes on (unofficial) FIFA API


more api wrappers:

- <https://github.com/stiles/world-cup>

```
def fetch_squad(id_team: str, season: str | None = None) -> list[dict]:
    season = season or config.SEASON_ID
    url = f"{config.API_BASE}/teams/{id_team}/squad"
    params = {
        "idCompetition": config.COMPETITION_ID,
        "idSeason": season,
        "language": config.LANGUAGE,
    }

# Older tournaments often have no squad data; treat as empty.
```




- <https://github.com/CuberL/fifa-data-skill>

- <https://github.com/JantaoDev/FifaApi>  - 8 years old (uses https://api.fifa.com/api/v1)!!

- <https://github.com/purushothamgk/fifa-live-blog/blob/main/API.md>
   - <https://github.com/purushothamgk/fifa-live-blog/blob/main/server.js>


```
async function apiSquad(res, teamId, competitionId, seasonId) {
  if (![teamId, competitionId, seasonId].every((value) => /^[a-zA-Z0-9-]+$/.test(value || ""))) {
    return json(res, 400, { error: "Invalid squad request" });
  }
  const data = await fifa(
    `/teams/${teamId}/squad?idCompetition=${competitionId}&idSeason=${seasonId}&language=en`,
    5 * 60_000,
  );
  const players = (data.Players || []).map((player) => ({
    id: String(player.IdPlayer),
    name: localized(player.PlayerName, localized(player.ShortName, "Player")),
    shirtNumber: player.JerseyNum,
    position: localized(player.PositionLocalized, "Player"),
    picture: player.PlayerPicture?.PictureUrl || player.PictureUrl || "",
  }));
  json(res, 200, { teamId, team: localized(data.TeamName, "Team"), players });
}


const ACTIVE_PERIODS = new Set([3, 4, 5, 6, 7, 8, 9, 11]);
isLive: ACTIVE_PERIODS.has(period)

FIFA Upstream APIs
The UI should call the Matchwire endpoints above rather than these upstream endpoints directly. They are documented here for backend ownership and troubleshooting.

Base URL:

https://api.fifa.com/api/v3

Endpoints used:

GET /calendar/matches?language=en&count=500&from={YYYY-MM-DD}
GET /live/football/{competitionId}/{seasonId}/{stageId}/{matchId}?language=en
GET /timelines/{matchId}?language=en
GET /calendar/{competitionId}/{seasonId}/{stageId}/standing?language=en&count=200
```



<https://givevoicetofootball.github.io/api/>

```

To get the details of a specific season:
API_ROOT/seasons/278491

To get ALL Stages of the season:
API_ROOT/stages?idSeason=278491&idCompetition=108

To get all the Squad of the season:
API_ROOT/teams/squads/all/108/278491

To retrieve all players:
API_ROOT/players/seasons/278491?count=1000

To retrieve all coaches:
API_ROOT/coaches/season/278491

To get ALL matches:
API_ROOT/calendar/matches?idSeason=278491&idCompetition=108&count=100

To get matches for a specific stage:
API_ROOT/calendar/matches?idSeason=278491&idCompetition=108&idStage=278493

To get the standings for a Stage:
API_ROOT/calendar/108/278491/278493/Standing

To get the standings for a specific Group:
API_ROOT/calendar/108/278491/278493/Standing?idGroup=278497

To get the line-ups of a Match:
API_ROOT/live/football/108/278491/278493/300424860?language=en-GB

To get the timeline (live events) of a Match:
API_ROOT/timelines/108/278491/278493/300424860?language=en-GB

```




```
Build the FIFA match-centre URL using:
https://www.fifa.com/en/match-centre/match/{competitionId}/{seasonId}/{stageId}/{id}
```


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
