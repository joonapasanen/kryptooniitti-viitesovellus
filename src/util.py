import re


class UserInputError(Exception):
    pass


def validate_year(year):
    if not re.fullmatch(r"[0-9]{4}", year or ""):
        raise UserInputError("Year must contain exactly 4 digits")


def validate_reference(content):
    if len(content) < 5:
        raise UserInputError("Reference content length must be greater than 4")

    if len(content) > 100:
        raise UserInputError("Reference content length must be smaller than 100")
