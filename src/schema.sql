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

CREATE TABLE "articles" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  -- Required fields
  cite_key TEXT NOT NULL UNIQUE,
  author TEXT NOT NULL,
  title TEXT NOT NULL,
  journal TEXT NOT NULL,
  year INTEGER NOT NULL,
  -- Optional article fields
  volume TEXT,
  issue_number TEXT, -- Renamed from "number" to "issue_number" to avoid confusion with the "id" field
  pages TEXT,
  month TEXT,
  note TEXT,
  key_field TEXT, -- Renamed from "key" to "key_field" to avoid confusion with the "id" field
  crossref TEXT,
  -- Additional standard BibTeX fields
  address TEXT,
  annote TEXT,
  booktitle TEXT,
  chapter TEXT,
  edition TEXT,
  editor TEXT,
  howpublished TEXT,
  institution TEXT,
  organization TEXT,
  publisher TEXT,
  school TEXT,
  series TEXT,
  entry_type TEXT -- Renamed from "type" to "entry_type" to avoid confusion with the "id" field
);

