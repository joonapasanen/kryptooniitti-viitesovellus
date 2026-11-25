from dataclasses import dataclass


@dataclass
class Reference:  # pylint: disable=too-many-instance-attributes
    id: int
    cite_key: str
    author: str
    content: str
    # BibTeX fields
    r_type: str | None = None
    title: str | None = None
    year: int | None = None
    publisher: str | None = None
    journal: str | None = None
    booktitle: str | None = None
    pages: str | None = None
    volume: str | None = None

    def __str__(self):
        return self.content
