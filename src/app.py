from flask import flash, redirect, render_template, request

from config import app
from repositories.references_repository import create_reference, get_references
from util import validate_reference


@app.route("/")
def index():
    references = get_references()
    return render_template("index.html", references=references)


@app.route("/create_reference")
def new():
    return render_template("new_reference.html")


@app.route("/create_reference", methods=["POST"])
def reference_creation():
    content = request.form.get("content", "")

    try:
        validate_reference(content)
        create_reference(content)
        return redirect("/")
    except Exception as error:
        flash(str(error))
        return redirect("/create_reference")
