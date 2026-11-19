CREATE TABLE "references" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT NOT NULL
);

CREATE TABLE "articles" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  citation_key TEXT NOT NULL UNIQUE,
  author TEXT NOT NULL,
  title TEXT NOT NULL,
  journal TEXT NOT NULL,
  year INTEGER NOT NULL,
  volume TEXT,
  number TEXT,
  pages TEXT,
  month TEXT,
  note TEXT,
  key_field TEXT
)