import unittest
from util import validate_reference, UserInputError

class TestExample(unittest.TestCase):
    def test_example(self):
        self.assertEqual(1, 1)

    def test_short_reference_error(self):
        with self.assertRaises(UserInputError):
            validate_reference("abc")