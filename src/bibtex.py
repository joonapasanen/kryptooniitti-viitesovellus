BIBTEX_FIELDS = ["author", "title", "journal", "publisher", "year"]

# LaTeX special characters that would break a .bib file if left as-is
SPECIAL_CHARACTERS = {
    "\\": r"\textbackslash{}",
    "{": r"\{",
    "}": r"\}",
    "&": r"\&",
    "%": r"\%",
    "$": r"\$",
    "#": r"\#",
    "_": r"\_",
}


def escape(value):
    return "".join(SPECIAL_CHARACTERS.get(char, char) for char in str(value))


def reference_to_bibtex(reference):
    lines = [f"@{reference.r_type}{{{reference.cite_key},"]
    for field in BIBTEX_FIELDS:
        value = getattr(reference, field)
        if value is not None and value != "":
            lines.append(f"  {field} = {{{escape(value)}}},")
    lines.append("}")
    return "\n".join(lines)


def references_to_bibtex(references):
    return "\n\n".join(reference_to_bibtex(reference) for reference in references)
