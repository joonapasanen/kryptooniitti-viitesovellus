from sqlalchemy import text

from config import db
from entities.references import Reference

FIELDS = ["cite_key", "author", "title", "year", "publisher", "journal"]


def get_references():
    result = db.session.execute(
        text('SELECT id, content FROM "references" ORDER BY id')
    )
    return [Reference(reference.id, reference.content) for reference in result]

def create_reference(ref_type, form):
    if ref_type not in ("book", "article"):
        raise Exception("Unknown reference type error")

    parameters = {f: form.get(f) or None for f in FIELDS}
    parameters["r_type"] = ref_type
    parameters["content"] = f"{form.get('author')}: {form.get('title')}"

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
