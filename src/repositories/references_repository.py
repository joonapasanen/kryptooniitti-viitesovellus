from sqlalchemy import text

from config import db
from entities.references import Reference


def get_references():
    result = db.session.execute(
        text('SELECT id, content FROM "references" ORDER BY id')
    )
    return [Reference(reference.id, reference.content) for reference in result]


def create_reference(content):
    db.session.execute(
        text('INSERT INTO "references" (content) VALUES (:content)'),
        {"content": content},
    )
    db.session.commit()

def remove_reference(reference_id):
    db.session.execute(
        text('DELETE FROM "references" WHERE id = :id'),
        {"id": reference_id},
    )
    db.session.commit()
