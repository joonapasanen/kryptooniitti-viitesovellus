from flask import flash, redirect, render_template, request, jsonify, Response

from config import app, test_env
from repositories.references_repository import create_reference, get_references, remove_reference, update_reference
from db_helper import reset_db
from bibtex import references_to_bibtex


@app.route("/")
def index():
    references = get_references()
    return render_template("index.html", references=references)


@app.route("/create_reference")
def new():
    ref_type = request.args.get("r_type")

    try:
        author_count = max(1, min(int(request.args.get("author_count", 1)), 10))
    except (TypeError, ValueError):
        author_count = 1

    return render_template(
        "new_reference.html",
        ref_type=ref_type,
        author_count=author_count,
    )


@app.route("/create_reference", methods=["POST"])
def reference_creation():
    ref_type = request.form.get("r_type")

    try:
        create_reference(ref_type, request.form)
        return redirect("/")
    except Exception as error:
        flash(str(error))
        author_count = max(1, len(request.form.getlist("author")))
        return redirect(
            f"/create_reference?r_type={ref_type}&author_count={author_count}"
        )


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


@app.route("/modify_reference/<int:reference_id>", methods=["GET", "POST"])
def modify_reference(reference_id):
    reference = next(
        (item for item in get_references() if item.id == reference_id),
        None,
    )

    if reference is None:
        flash("Reference not found")
        return redirect("/")

    if request.method == "POST":
        try:
            update_reference(reference_id, request.form)
            return redirect("/")
        except Exception as error:
            flash(str(error))
            return render_template(
                "modify_reference.html",
                reference=reference,
                form_data=request.form,
            )

    return render_template("modify_reference.html", reference=reference)


@app.route("/references.bib")
def export_bibtex():
    content = references_to_bibtex(get_references())
    return Response(
        content,
        mimetype="application/x-bibtex",
        headers={"Content-Disposition": "attachment; filename=references.bib"},
    )

if test_env:
    @app.route("/reset_db")
    def reset_database():
        reset_db()
        return jsonify({ 'message': "db reset" })
