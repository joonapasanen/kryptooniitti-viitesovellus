from flask import flash, redirect, render_template, request, jsonify

from config import app, test_env
from repositories.references_repository import create_reference, get_references
from util import validate_reference
from db_helper import reset_db


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

if test_env:
    @app.route("/reset_db")
    def reset_database():
        reset_db()
        return jsonify({ 'message': "db reset" })