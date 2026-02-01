import os
from flask import Flask, render_template

app = Flask(__name__)

# Base directory of the project
BASE_DIR = os.path.abspath(os.path.dirname(__file__))

# Directory for generated images or files
IMAGE_DIR = os.path.join(BASE_DIR, "static", "images")

# Ensure the directory exists
os.makedirs(IMAGE_DIR, exist_ok=True)


@app.route("/")
def index():
    """
    Basic health-check route.
    If this page loads, Flask is running correctly.
    """
    return render_template("index.html")


@app.route("/write-test")
def write_test():
    """
    Tests write permission by creating a file in static/images.
    """
    test_file_path = os.path.join(IMAGE_DIR, "test.txt")

    try:
        with open(test_file_path, "w") as f:
            f.write("Write permission test successful.\n")
        return "File written successfully."
    except PermissionError:
        return "Permission denied: cannot write file.", 500
    except Exception as e:
        return f"Unexpected error: {e}", 500


if __name__ == "__main__":
    # Development only. Do not use in production.
    app.run(host="127.0.0.1", port=5000, debug=False)

