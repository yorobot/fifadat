# Todos


```
[56/56]  Austria Lustenau Sturm Graz, 8th Finals, 2026-10-29T18:00:00+00:00
GET https://api.fifa.com/api/v3/live/football/1ncmha8yglhyyhg6gtaujymqf/eo5snp7elk2w8i80n3nhq8wt0/eoz5pflm46xuukoqujpkoyhp0/5scxiqpcznhe93l6mhb3cbr4k?language=en...
OK - fetching https://api.fifa.com/api/v3/live/football/1ncmha8yglhyyhg6gtaujymqf/eo5snp7elk2w8i80n3nhq8wt0/eoz5pflm46xuukoqujpkoyhp0/5scxiqpcznhe93l6mhb3cbr4k?language=en
  sleeping 1 sec(s)...
  132 match(es) in season 2026/27
yorobot/fifadat/lib/fifadat/pp/convert.rb:83:in `block in convert': undefined method `merge' for nil (NoMethodError)

           rec[:score] = rec[:score].merge( score_more )
                                    ^^^^^^
        from yorobot/fifadat/lib/fifadat/pp/convert.rb:52:in `each'
        from yorobot/fifadat/lib/fifadat/pp/convert.rb:52:in `each_with_index'
        from yorobot/fifadat/lib/fifadat/pp/convert.rb:52:in `convert'
        from yorobot/fifadat/lib/fifadat/tool.rb:167:in `block (2 levels) in main'
        from yorobot/fifadat/lib/fifadat/tool.rb:165:in `each'
        from yorobot/fifadat/lib/fifadat/tool.rb:165:in `block in main'
        from yorobot/fifadat/lib/fifadat/tool.rb:162:in `each'
        from yorobot/fifadat/lib/fifadat/tool.rb:162:in `main'
        from bin/fifadat:14:in `<main>'
```


```
- [ ] remove empty results
  e.g.
   cache.fifadat/interconticup/2026_matches.json

{"ContinuationToken": null, "ContinuationHash": null, "Results": []}
```