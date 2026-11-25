from sqlalchemy import text

from config import db
from entities.references import Reference
from util import UserInputError, validate_year

FIELDS = [
    "cite_key",
    "author",
    "title",
    "year",
    "publisher",
    "journal",
    "booktitle",
    "pages",
    "volume"
]


def build_filter_conditions(filters):
    conditions = []
    parameters = {}
    for field in ("r_type", "year"):
        if filters.get(field):
            conditions.append(f"{field} = :{field}")
            parameters[field] = filters[field]
    for field in ("author", "title"):
        if filters.get(field):
            conditions.append(f"{field} LIKE :{field}")
            parameters[field] = f"%{filters[field]}%"

    where = f"WHERE {' AND '.join(conditions)} " if conditions else ""
    return where, parameters


def get_references(filters=None):
    where, parameters = build_filter_conditions(filters or {})
    result = db.session.execute(
        text(
            'SELECT id, cite_key, author, content, '
            'r_type, title, year, publisher, journal, '
            'booktitle, pages, volume '
            f'FROM "references" {where}ORDER BY id'
        ),
        parameters,
    )
    return [
        Reference(
            reference.id,
            reference.cite_key,
            reference.author,
            reference.content,
            r_type=reference.r_type,
            title=reference.title,
            year=reference.year,
            publisher=reference.publisher,
            journal=reference.journal,
            booktitle=reference.booktitle,
            pages=reference.pages,
            volume=reference.volume,
        )
        for reference in result
    ]

def validate_reference_type(ref_type):
    if ref_type not in ("book", "article", "inproceedings"):
        raise UserInputError("Unknown reference type error")


def prepare_authors(form):
    authors = [
        name.strip()
        for name in form.getlist("author")
        if name.strip()
    ]
    if not authors:
        raise UserInputError("At least one author is required")
    return " and ".join(authors)


def prepare_reference_data(ref_type, form):
    validate_reference_type(ref_type)
    validate_year(form.get("year"))

    parameters = {field: form.get(field) or None for field in FIELDS}
    author = prepare_authors(form)
    parameters["author"] = author
    parameters["r_type"] = ref_type
    parameters["content"] = f"{author}: {form.get('title')}"
    if ref_type == "article":
        start = (form.get("pages_start") or "").strip()
        end = (form.get("pages_end") or "").strip()

        if not start or not end:
            raise UserInputError("Both page numbers are required")

        parameters["pages"] = f"{start}--{end}"
    return parameters


def create_reference(ref_type, form):
    parameters = prepare_reference_data(ref_type, form)
    db.session.execute(
        text("""INSERT INTO "references"
            (content, r_type, cite_key, author, title, year, publisher, journal, booktitle, pages, volume)
            VALUES (:content, :r_type, :cite_key, :author, :title, :year, :publisher, :journal,
            :booktitle, :pages, :volume)"""),
            parameters,
    )
    db.session.commit()

def update_reference(reference_id, form):
    ref_type = form.get("r_type")
    parameters = prepare_reference_data(ref_type, form)
    parameters["id"] = reference_id

    result = db.session.execute(
        text("""UPDATE "references"
            SET content = :content,
                r_type = :r_type,
                cite_key = :cite_key,
                author = :author,
                title = :title,
                year = :year,
                publisher = :publisher,
                journal = :journal
            WHERE id = :id"""),
        parameters,
    )

    if result.rowcount == 0:
        db.session.rollback()
        raise UserInputError("Reference not found")

    db.session.commit()

def remove_reference(reference_id):
    db.session.execute(
        text('DELETE FROM "references" WHERE id = :id'),
        {"id": reference_id},
    )
    db.session.commit()
