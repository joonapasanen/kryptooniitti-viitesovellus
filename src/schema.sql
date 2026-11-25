CREATE TABLE "references" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT NOT NULL,
  r_type TEXT NOT NULL,
  -- required fields for each reference type
  cite_key TEXT NOT NULL UNIQUE,
  author TEXT NOT NULL,
  title TEXT NOT NULL,
  year INTEGER NOT NULL,
  publisher TEXT,
  journal TEXT,
  booktitle TEXT,
  pages TEXT,
  volume TEXT
);
