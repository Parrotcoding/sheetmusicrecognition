from flask import Flask, request, jsonify, send_file
from flask_cors import CORS
import os
import subprocess
import uuid

app = Flask(__name__)
CORS(app)

@app.route('/convert', methods=['POST'])
def convert_image():
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'}), 400

    file = request.files['file']
    filename = f"input_{uuid.uuid4().hex}.jpg"
    file.save(filename)

    try:
        # Run Audiveris in batch mode
        subprocess.run([
            "./audiveris/bin/audiveris",
            "-batch",
            "-export",
            filename
        ], check=True)

        # Find the resulting MXL file
        output_dir = f"./{filename}.mxl"
        if not os.path.exists(output_dir):
            return jsonify({'error': 'Conversion failed'}), 500

        return send_file(output_dir, as_attachment=True)

    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        if os.path.exists(filename): os.remove(filename)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=7860)
