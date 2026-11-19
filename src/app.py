from flask import flash, redirect, render_template, request, jsonify

from config import app, test_env
from repositories.references_repository import create_reference, get_references, remove_reference
from util import validate_reference
from db_helper import reset_db


@app.route("/")
def index():
    references = get_references()
    return render_template("index.html", references=references)


@app.route("/create_reference")
def new():
    ref_type =request.args.get("r_type")
    return render_template("new_reference.html", ref_type=ref_type)


@app.route("/create_reference", methods=["POST"])
def reference_creation():
    ref_type = request.form.get("r_type")

    try:
        #validate_reference(content)
        create_reference(ref_type, request.form)
        return redirect("/")
    except Exception as error:
        flash(str(error))
        return redirect(f"/create_reference?r_type={ref_type}")


@app.route("/remove_reference")
def remove_reference_page():
    references = get_references()
    return render_template(
        "remove_reference.html",
        references=references,
    )


@app.route("/remove_reference/<int:reference_id>", methods=["POST"])
def reference_removal(reference_id):
    remove_reference(reference_id)
    return redirect("/")

if test_env:
    @app.route("/reset_db")
    def reset_database():
        reset_db()
        return jsonify({ 'message': "db reset" })
