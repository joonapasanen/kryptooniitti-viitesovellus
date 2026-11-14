# kryptooniitti-viitesovellus

Ohjelmistotuotanto kurssin miniprojekti

## Käynnistysohjeet

Vaatii Python 3.14:n ja [uv](https://docs.astral.sh/uv/):n.

1. Asenna riippuvuudet: `uv sync`
2. Luo projektin juureen `.env`-tiedosto:

   ```
   DATABASE_URL=sqlite:///database.db
   SECRET_KEY=<salainen avain>
   ```

3. Alusta tietokanta (poistaa olemassa olevat taulut): `uv run python src/db_helper.py`
4. Käynnistä sovellus: `uv run python src/index.py` → <http://localhost:5001>

Testit: `uv run pytest src/tests` (yksikkötestit), `bash run_robot_tests.sh` (Robot-testit, vaatii kerran `uv run rfbrowser install chromium`) ja `uv run pylint src`.

Definition of Done määrittely:
[Definition of Done (DoD)](https://github.com/joonapasanen/kryptooniitti-viitesovellus/blob/main/DoD.md)

Pelisäännöt:
[Pelisäännöt](https://github.com/joonapasanen/kryptooniitti-viitesovellus/blob/main/pelisaannot.md)
