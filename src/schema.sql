CREATE TABLE "references" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT NOT NULL
);

CREATE TABLE books (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  cite_key TEXT NOT NULL UNIQUE,
  -- BibTeX @book required fields
  author TEXT NOT NULL,
  title TEXT NOT NULL,
  publisher TEXT NOT NULL,
  year INTEGER NOT NULL,
  -- optional fields
  volume TEXT,
  series TEXT,
  address TEXT,
  edition TEXT,
  month TEXT,
  note TEXT
);
