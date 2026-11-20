CREATE TABLE "references" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT NOT NULL,
  r_type TEXT NOT NULL,
  -- required fields
  cite_key TEXT NOT NULL UNIQUE,
  author TEXT NOT NULL,
  title TEXT NOT NULL,
  year INTEGER NOT NULL,
  publisher TEXT,
  journal TEXT 
  -- Optional 

);



