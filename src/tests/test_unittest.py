import unittest
from util import validate_reference, validate_year, UserInputError
from entities.references import Reference


class TestReferenceValidator(unittest.TestCase):
    def test_long_reference_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(str("a") * 101)

    def test_short_reference_error(self):
        with self.assertRaises(UserInputError):
            validate_reference("abc")

    def test_valid_reference(self):
        validate_reference("This is valid")

    def test_correct_year(self):
        validate_year("2020")

    def test_incorrect_year(self):
        with self.assertRaises(UserInputError):
            validate_year("20201")

    def test_year_not_integer(self):
        with self.assertRaises(UserInputError):
            validate_year("abcd")

class TestReference(unittest.TestCase):
    def test_str_returns_content(self):
        reference = Reference(1, "key", "Ada", "Ada: Example")
        self.assertEqual(str(reference), "Ada: Example")