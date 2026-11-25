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

### Git-hookit

Projektissa on [pre-commit](https://pre-commit.com/)-hookit, jotka ajavat CI:n tarkistuksia jo omalla koneella:

- **commit**: `pylint src`, jonka on mentävä läpi ennen kuin commit hyväksytään
- **push**: yksikkötestit (`pytest src/tests`), joiden on mentävä läpi ennen kuin push lähtee

Hookit eivät siirry gitin mukana, joten jokaisen on asennettava ne kerran omaan kloonaukseensa:

```
uv sync
uv run pre-commit install
```

Robot-testejä hookit eivät aja, vaan ne ajetaan CI:ssä.

Definition of Done määrittely:
[Definition of Done (DoD)](https://github.com/joonapasanen/kryptooniitti-viitesovellus/blob/main/DoD.md)

Pelisäännöt:
[Pelisäännöt](https://github.com/joonapasanen/kryptooniitti-viitesovellus/blob/main/pelisaannot.md)

Product Backlog:
[Product Backlog](https://github.com/users/joonapasanen/projects/1/views/1)

Sprint 1 Backlog:
[Sprint 1 Backlog](https://github.com/users/joonapasanen/projects/1/views/2)

Sprint 2 Backlog:
[Sprint 2 Backlog](https://github.com/users/joonapasanen/projects/1/views/3)

OKD-klusteri URL:
[OKD-klusteri](https://route-ohjelmistotuotanto-lahiopetus-2026-2.ext.okd-cs-test-0.k8s.cs.helsinki.fi)
