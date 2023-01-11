## Projektarbete kurs TIG333, Göteborgs Universitet; Programmering av mobila appar i flutter.

# Appen är vidareutvecklad under projekt i kurs TIG330, Design och AI.

# Quizter Pettersson

En Quiz app som använder sig av ett öppet api med flersvarsfrågor. 
Stort tack till [The Trivia API](https://the-trivia-api.com/) och Will Fry som skapat det. 
Vi använder en databas från [Deta](https://deta.sh) för att lagra data till highscore. 


## Innan användning!!
För att highscore skall fungera behövs en nyckel till databasen.
- lib/auth/<example_top_secret.dart>. 
- Gör en kopia på samma plats. 
- Döp om till lib/auth<top_secret.dart>. 
- Använd demonyckel som databasKey för att testa spelet med Highscore.

Samma gäller för hint-funktionen, en API-nyckel till OpenAI krävs, i samma fil som ovan.
https://openai.com/api/
- Tilldela nyckeln till 'myHintKey'.

## Vi som gjort detta projekt är:
 - August Aublet
 - Gustaf Hasselgren
 - Mårten Jonsson
 - Ludvig Boström
 - Andreas Fredriksson
 - Josef Gunnarsson
