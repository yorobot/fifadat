# Notes on fifa countries / members?

get an official list via the (unofficial) api,
try <https://api.fifa.com/api/v3/countries?count=500&language=en>
resulting in 235 record(s) -- incl. historic countries (& codes) e.g.

``` json
 {
  "IdCountry":     "AUT",
  "Name":          "Austria",
  "Iso3166Alpha2": "AT",
  "Iso3166Alpha3": "AUT",
  "Alias": [{"Locale": "en-GB", "Description": "Austria"}]
 }
```

reformatted:

```
AFG | Afghanistan         | AF AFG
ALB | Albania             | AL ALB
ALG | Algeria             | DZ DZA
ASA | American Samoa      | AS ASM
AND | Andorra             | AD AND
ANG | Angola              | AO AGO
AIA | Anguilla            | AI AIA
ATG | Antigua and Barbuda | AG ATG
ARG | Argentina           | AR ARG
ARM | Armenia             | AM ARM
ARU | Aruba               | AW ABW
AUS | Australia           | AU AUS
AUT | Austria             | AT AUT
AZE | Azerbaijan          | AZ AZE
BAH | Bahamas             | BS BHS
BHR | Bahrain             | BH BHR
BAN | Bangladesh          | BD BGD
BRB | Barbados            | BB BRB
BLR | Belarus             | BY BLR
BEL | Belgium             | BE BEL
BLZ | Belize              | BZ BLZ
BEN | Benin               | BJ BEN
BER | Bermuda             | BM BMU
BHU | Bhutan              | BT BTN
BOL | Bolivia             | BO BOL
BIH | Bosnia and Herzegovina | BA BIH
BOT | Botswana            | BW BWA
BRA | Brazil              | BR BRA
VGB | British Virgin Islands | VG VGB
BRU | Brunei Darussalam   | BN BRN
BUL | Bulgaria            | BG BGR
BFA | Burkina Faso        | BF BFA
BDI | Burundi             | BI BDI
CAM | Cambodia            | KH KHM
CMR | Cameroon            | CM CMR
CAN | Canada              | CA CAN
CPV | Cape Verde Islands · Cabo Verde | CV CPV
CAY | Cayman Islands      | KY CYM
CTA | Central African Republic | CF CAF
CHA | Chad                | TD TCD
CHI | Chile               | CL CHL
CHN | China PR            | CN CHN
TPE | Chinese Taipei      | TW TWN
COL | Colombia            | CO COL
COM | Comoros             | KM COM
CGO | Congo               | CG COG
COD | Congo DR            | CD COD
COK | Cook Islands        | CK COK
CRC | Costa Rica          | CR CRI
CRO | Croatia             | HR HRV
CUB | Cuba                | CU CUB
CUW | Curaçao             | CW CUW
CYP | Cyprus              | CY CYP
CZE | Czechia             | CZ CZE
TCH | Czechoslovakia      | CS CSK
CIV | Côte d'Ivoire       | CI CIV
DEN | Denmark | DK DNK
DJI | Djibouti | DJ DJI
DMA | Dominica | DM DMA
DOM | Dominican Republic | DO DOM
INH | Dutch East Indies |
ECU | Ecuador | EC ECU
EGY | Egypt | EG EGY
SLV | El Salvador | SV SLV
ENG | England | EN ENG
EQG | Equatorial Guinea | GQ GNQ
ERI | Eritrea | ER ERI
EST | Estonia | EE EST
ETH | Ethiopia | ET ETH
FRO | Faroe Islands | FO FRO
FIJ | Fiji | FJ FJI
FIN | Finland | FI FIN
FRA | France | FR FRA
FGU | French Guyana · French Guiana | GF GUF
GAB | Gabon | GA GAB
GAM | Gambia · The Gambia | GM GMB
GEO | Georgia | GE GEO
GDR | German DR |
GER | Germany | DE DEU
FRG | Germany FR · FR Germany |
GHA | Ghana | GH GHA
GIB | Gibraltar | GI GIB
GBR | Great Britain | GB GBR
GRE | Greece | GR GRC
GRN | Grenada | GD GRD
GLP | Guadeloupe | GP GLP
GUM | Guam | GU GUM
GUA | Guatemala | GT GTM
GUI | Guinea | GN GIN
GNB | Guinea-Bissau | GW GNB
GUY | Guyana | GY GUY
HAI | Haiti | HT HTI
HON | Honduras | HN HND
HKG | Hong Kong · Hong Kong, China | HK HKG
HUN | Hungary | HU HUN
ISL | Iceland | IS ISL
IND | India | IN IND
IDN | Indonesia | ID IDN
IRN | Iran · IR Iran | IR IRN
IRQ | Iraq | IQ IRQ
ISR | Israel | IL ISR
ITA | Italy | IT ITA
JAM | Jamaica | JM JAM
JPN | Japan | JP JPN
JOR | Jordan | JO JOR
KAZ | Kazakhstan | KZ KAZ
KEN | Kenya | KE KEN
PRK | Korea DPR · DPR Korea | KP PRK
KOR | Korea Republic | KR KOR
KOS | Kosovo | XK XKX
KUW | Kuwait | KW KWT
KGZ | Kyrgyz Republic | KG KGZ
LAO | Laos | LA LAO
LVA | Latvia | LV LVA
LBN | Lebanon | LB LBN
LES | Lesotho | LS LSO
LBR | Liberia | LR LBR
LBY | Libya | LY LBY
LIE | Liechtenstein | LI LIE
LTU | Lithuania | LT LTU
LUX | Luxembourg | LU LUX
MAC | Macau, China | MO MAC
MAD | Madagascar | MG MDG
MWI | Malawi | MW MWI
MAS | Malaysia | MY MYS
MDV | Maldives | MV MDV
MLI | Mali | ML MLI
MLT | Malta | MT MLT
MTQ | Martinique | MQ MTQ
MTN | Mauritania | MR MRT
MRI | Mauritius | MU MUS
MEX | Mexico | MX MEX
MDA | Moldova | MD MDA
MCO | Monaco | MC MCO
MNG | Mongolia | MN MNG
MNE | Montenegro | ME MNE
MSR | Montserrat | MS MSR
MAR | Morocco | MA MAR
MOZ | Mozambique | MZ MOZ
MYA | Myanmar | MM MMR
NAM | Namibia | NA NAM
NEP | Nepal | NP NPL
NED | Netherlands | NL NLD
ANT | Netherlands Antilles | AN ANT
NCL | New Caledonia | NC NCL
NZL | New Zealand | NZ NZL
NCA | Nicaragua | NI NIC
NIG | Niger | NE NER
NGA | Nigeria | NG NGA
NIU | Niue | NU NIU
MKD | North Macedonia | MK MKD
VDR | North Vietnam |
NIR | Northern Ireland |
MNP | Northern Marianas · Northern Mariana Islands | MP MNP
NOR | Norway | NO NOR
OMA | Oman | OM OMN
PAK | Pakistan | PK PAK
PLE | Palestine | PS PSE
PAN | Panama | PA PAN
PNG | Papua New Guinea | PG PNG
PAR | Paraguay | PY PRY
PER | Peru | PE PER
PHI | Philippines | PH PHL
POL | Poland | PL POL
POR | Portugal | PT PRT
PUR | Puerto Rico | PR PRI
QAT | Qatar | QA QAT
IRL | Republic of Ireland | IE IRL
REU | Reunion · Réunion | RE REU
ROU | Romania | RO ROU
RUS | Russia | RU RUS
RWA | Rwanda | RW RWA
SAA | Saar · Saarland |
MAF | Saint Martin · St Martin | MF MAF
SAM | Samoa | WS WSM
SMR | San Marino | SM SMR
KSA | Saudi Arabia | SA SAU
SCO | Scotland |
SEN | Senegal | SN SEN
SRB | Serbia | RS SRB
SCG | Serbia and Montenegro |
SEY | Seychelles | SC SYC
SLE | Sierra Leone | SL SLE
SGP | Singapore | SG SGP
SXM | Sint-Maarten · Sint Maarten | SX SXM
SVK | Slovakia | SK SVK
SVN | Slovenia | SI SVN
SOL | Solomon Islands | SB SLB
SOM | Somalia | SO SOM
RSA | South Africa | ZA ZAF
SSD | South Sudan | SS SSD
URS | Soviet Union |
ESP | Spain | ES ESP
SRI | Sri Lanka | LK LKA
SKN | St. Kitts and Nevis · St Kitts and Nevis | KN KNA
LCA | St. Lucia · St Lucia | LC LCA
VIN | St. Vincent and the Grenadines · St Vincent and the Grenadines | VC VCT
SDN | Sudan | SD SDN
SUR | Suriname | SR SUR
SWZ | Swaziland · Eswatini | SZ SWZ
SWE | Sweden | SE SWE
SUI | Switzerland | CH CHE
SYR | Syria | SY SYR
STP | São Tomé e Príncipe · São Tomé and Príncipe | ST STP
TAH | Tahiti | PF PYF
TJK | Tajikistan | TJ TJK
TAN | Tanzania | TZ TZA
THA | Thailand | TH THA
TLS | Timor-Leste | TL TLS
TOG | Togo | TG TGO
TGA | Tonga | TO TON
TRI | Trinidad and Tobago | TT TTO
TUN | Tunisia | TN TUN
TUR | Turkey · Türkiye | TR TUR
TKM | Turkmenistan | TM TKM
TCA | Turks and Caicos Islands | TC TCA
VIR | US Virgin Islands | VI VIR
USA | USA | US USA
UGA | Uganda | UG UGA
UKR | Ukraine | UA UKR
UAE | United Arab Emirates | AE ARE
UVO | Upper Volta |
URU | Uruguay | UY URY
UZB | Uzbekistan | UZ UZB
VAN | Vanuatu | VU VUT
VAT | Vatican | VA VAT
VEN | Venezuela | VE VEN
VIE | Vietnam | VN VNM
WAL | Wales |
YEM | Yemen | YE YEM
YMD | Yemen PDR |
YUG | Yugoslavia |
ZAI | Zaire |
ZAM | Zambia | ZM ZMB
ZIM | Zimbabwe | ZW ZWE
```


## members

211 members (as of 2026)

<https://en.wikipedia.org/wiki/List_of_FIFA_members>



### historic & other

from countries.json:

```
- SAA,   Saar · Saarland            → None (?)
- GDR,   German DR                  → None (?)
- FRG,   Germany FR · FR Germany    → Germany
- SCG,   Serbia and Montenegro      → Serbia
- YUG,   Yugoslavia                 → Serbia
- URS,   Soviet Union               → Russia
- TCH,   Czechoslovakia             → Czechia

- VDR,   North Vietnam              → Vietnam
- ZAI,   Zaire                      → DR Congo
- UVO,   Upper Volta                → Burkina Faso
- INH,   Dutch East Indies          → Indonesia
- YMD,   Yemen PDR                  → Yemen
- ANT,   Netherlands Antilles       → Curaçao


- GBR,   Great Britain
- VAT,   Vatican
- MCO,   Monaco
...
```




---

Historic FIFA members primarily refer to national football associations that have ceased to exist due to political changes, mergers, or the dissolution of their respective countries. In most cases, FIFA recognizes a specific successor state to inherit the historical records and statistics of these defunct teams. The major historical FIFA members include:

| Defunct FIFA Member        | Active Period | Successor Team Recognized by FIFA |
|----------------------------|-----------|---|
| Soviet Union               | 1946–1991 | Russia |
| Czechoslovakia             | 1906–1993 | Czech Republic |
| Yugoslavia (Kingdom / SFR) | 1923–1992 | Serbia |
| East Germany               | 1952–1990 | None (Merged into the current German DFB) |
| Saarland                   | 1950–1956 | None (Merged into West Germany's DFB) |
| North Yemen                | 1980–1990 | Yemen (Merged with South Yemen) |
| South Yemen                | 1967–1990 | Yemen (Merged with North Yemen) |
| Serbia and Montenegro      | 1992–2006 | Serbia |
| Netherlands Antilles       | 1932–2010 | Curaçao |
| CIS (Commonwealth of Independent States) | 1992 | Transitional team post-USSR, succeeded by Russia |

**Historical Names & Rebranding**
Some historic associations did not dissolve but went through significant political changes and renamed their national teams. Examples include:

- Burma (now Myanmar)
- Ceylon (now Sri Lanka)
- Dahomey (now Benin)
- New Hebrides (now Vanuatu)
- Upper Volta (now Burkina Faso)
- Zaire (now DR Congo)


### sovereign (UN-recognized) countries (BUT not fifa members)

193 un members (as of 2026)

There are 9 generally recognized sovereign countries (including UN member states and permanent observers) that are not members of FIFA.
These nations fall into three main categories:

**1. The European Microstates**

- Vatican City: The world's smallest sovereign country does not have a professional league or adequate facilities to join. They field a national team of Swiss Guards, priests, and papal officials for occasional unofficial friendlies.
- Monaco: While Monaco has a famous club team (AS Monaco) that competes at the highest level in the French league, the sovereign principality does not have its own independent national team affiliated with UEFA or FIFA.

**2. The Pacific Island Nations (Oceania)**

Six sovereign island nations in Oceania lack full FIFA membership, primarily due to geographic isolation, limited funding, or a lack of regulatory infrastructure:

- Kiribati (Associate member of the regional OFC, but not FIFA)
- Tuvalu (Associate member of the regional OFC, but not FIFA)
- Federated States of Micronesia
- Marshall Islands (Formed its football association recently and played its first matches, aiming for future membership)
- Nauru
- Palau

**3. The United Kingdom (Technicality)**

- United Kingdom: The UK as a collective entity is not a member of FIFA. Instead, because the British invented the modern rules of the game before FIFA existed, they hold four separate individual memberships for their constituent countries: England, Scotland, Wales, and Northern Ireland.



**Non-FIFA Regional Members**

Additionally, some independent territories like Bonaire, Guadeloupe, and Martinique are full members of their regional confederations (like CONCACAF) but are not members of FIFA. This means they can play in regional tournaments like the Gold Cup, but they cannot qualify for the FIFA World Cup.


---

FIFA handles the historical statistics, titles, and records of defunct countries using a strict legal succession model. When a country dissolves or splits, FIFA officially designates a single successor team to absorb 100% of that defunct nation's historical records.
The system relies on specific mechanisms to handle these records on modern platforms:

**1. The Successor State Rule**
Instead of wiping out historical records or splitting a team's past trophies among its newly independent territories, FIFA maps the historical achievements directly to one legal heir. This is usually tied to whichever new football association retained the original federation’s administrative seat, assets, or broader international legal succession.
Because of this, modern records are displayed on official platforms as follows:

- The Soviet Union (USSR) → Russia: Russia officially inherits all Soviet achievements, including their 1960 European Championship victory and historical World Cup finishes.
- Yugoslavia → Serbia: Serbia inherits all historical data from both the Kingdom/Socialist Federal Republic of Yugoslavia and the transitional state of Serbia & Montenegro.
- Czechoslovakia → Czech Republic: The Czech Republic is credited by FIFA with Czechoslovakia's historical records, including their two World Cup final appearances in 1934 and 1962.

**2. Historical Rebranding vs. Continuity**
If a country changes its name or undergoes an internal regime change without a territorial breakdown, FIFA treats it as the same continuous legal entity.

- Germany: The records of West Germany (1954–1990) are seamlessly combined with modern Germany's records because the current German Football Association (DFB) is simply the same legal body continuing forward. East Germany (1952–1990), however, is kept as an independent, frozen block of data because its federation dissolved and its players were absorbed into the existing DFB.
- Democratic Republic of the Congo: All statistics earned under the name Zaire (such as their 1974 World Cup appearance) remain tied to the country today under its modern name.

**The Controversy Behind the Method**
While this approach keeps databases orderly, it is highly debated by historians. For example, when the Soviet Union played in the 1986 World Cup, 14 out of the 22 players on the roster were actually Ukrainian (including star player Igor Belanov). Yet, because of the legal succession model, FIFA's historical ledger credits those performances entirely to Russia,
meaning modern nations like Ukraine, Croatia, or Slovakia technically started their official FIFA statistical history entirely from zero.
