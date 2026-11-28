import unittest

from bibtex import escape, reference_to_bibtex, references_to_bibtex
from entities.references import Reference


def make_book(**overrides):
    fields = {
        "r_type": "book",
        "title": "Clean Code",
        "year": 2009,
        "publisher": "Prentice Hall",
    }
    fields.update(overrides)
    return Reference(1, "Martin2009", "Robert Martin", "content", **fields)


def make_article(**overrides):
    fields = {
        "r_type": "article",
        "title": "Structured Programming",
        "year": 1974,
        "journal": "ACM Computing Surveys",
    }
    fields.update(overrides)
    return Reference(2, "Knuth1974", "Donald Knuth", "content", **fields)

def make_inproceedings(**overrides):
    fields = {
        "r_type": "inproceedings",
        "title": "Structured Programming",
        "year": 1974,
        "booktitle": "Proceedings of the ACM Conference",
    }
    fields.update(overrides)
    return Reference(3, "Knuth1974Conference", "Donald Knuth", "content", **fields)


class TestEscape(unittest.TestCase):
    def test_plain_text_is_unchanged(self):
        self.assertEqual(escape("Clean Code"), "Clean Code")

    def test_special_characters_are_escaped(self):
        self.assertEqual(escape("100% & {x} $ # _"), r"100\% \& \{x\} \$ \# \_")

    def test_backslash_is_escaped(self):
        self.assertEqual(escape("C:\\path"), r"C:\textbackslash{}path")

    def test_number_is_converted_to_string(self):
        self.assertEqual(escape(2009), "2009")


class TestReferenceToBibtex(unittest.TestCase):
    def test_book(self):
        expected = (
            "@book{Martin2009,\n"
            "  author = {Robert Martin},\n"
            "  title = {Clean Code},\n"
            "  publisher = {Prentice Hall},\n"
            "  year = {2009},\n"
            "}"
        )
        self.assertEqual(reference_to_bibtex(make_book()), expected)

    def test_article(self):
        expected = (
            "@article{Knuth1974,\n"
            "  author = {Donald Knuth},\n"
            "  title = {Structured Programming},\n"
            "  journal = {ACM Computing Surveys},\n"
            "  year = {1974},\n"
            "}"
        )
        self.assertEqual(reference_to_bibtex(make_article()), expected)

    def test_inproceedings(self):
        expected = (
            "@inproceedings{Knuth1974Conference,\n"
            "  author = {Donald Knuth},\n"
            "  title = {Structured Programming},\n"
            "  booktitle = {Proceedings of the ACM Conference},\n"
            "  year = {1974},\n"
            "}"
        )
        self.assertEqual(reference_to_bibtex(make_inproceedings()), expected)

    def test_missing_fields_are_omitted(self):
        result = reference_to_bibtex(make_book(publisher=None))
        self.assertNotIn("publisher", result)
        self.assertNotIn("journal", result)

    def test_empty_string_field_is_omitted(self):
        result = reference_to_bibtex(make_book(publisher=""))
        self.assertNotIn("publisher", result)

    def test_field_values_are_escaped(self):
        result = reference_to_bibtex(make_book(title="100% Done & Dusted"))
        self.assertIn(r"title = {100\% Done \& Dusted},", result)


class TestReferencesToBibtex(unittest.TestCase):
    def test_empty_list_gives_empty_string(self):
        self.assertEqual(references_to_bibtex([]), "")

    def test_entries_are_separated_by_blank_line(self):
        result = references_to_bibtex([make_book(), make_article()])
        entries = result.split("\n\n")
        self.assertEqual(len(entries), 2)
        self.assertTrue(entries[0].startswith("@book{Martin2009,"))
        self.assertTrue(entries[1].startswith("@article{Knuth1974,"))
