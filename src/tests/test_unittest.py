import unittest
from util import validate_reference, UserInputError

class TestReferenceValidator(unittest.TestCase):
    def test_long_reference_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(str("a") * 101)

    def test_short_reference_error(self):
        with self.assertRaises(UserInputError):
            validate_reference("abc")

    def test_valid_reference(self):
        validate_reference("This is valid")