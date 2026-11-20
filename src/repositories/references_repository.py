from sqlalchemy import text

from config import db
from entities.references import Reference
from util import validate_year

FIELDS = ["cite_key", "author", "title", "year", "publisher", "journal"]


def get_references():
    result = db.session.execute(
        text(
            'SELECT id, cite_key, author, content '
            'FROM "references" ORDER BY id'
        )
    )
    return [
        Reference(
            reference.id,
            reference.cite_key,
            reference.author,
            reference.content,
        )
        for reference in result
    ]

def create_reference(ref_type, form):
    if ref_type not in ("book", "article"):
        raise Exception("Unknown reference type error")

    validate_year(form.get("year"))

    parameters = {f: form.get(f) or None for f in FIELDS}
    authors = [
        name.strip()
        for name in form.getlist("author")
        if name.strip()
    ]
    if not authors:
        raise Exception("At least one author is required")

    author = "; ".join(authors)
    parameters["author"] = author
    parameters["r_type"] = ref_type
    parameters["content"] = f"{author}: {form.get('title')}"

    db.session.execute(
        text("""INSERT INTO "references"
            (content, r_type, cite_key, author, title, year, publisher, journal)
            VALUES (:content, :r_type, :cite_key, :author, :title, :year, :publisher, :journal)"""),
            parameters,
    )
    db.session.commit()

def remove_reference(reference_id):
    db.session.execute(
        text('DELETE FROM "references" WHERE id = :id'),
        {"id": reference_id},
    )
    db.session.commit()
