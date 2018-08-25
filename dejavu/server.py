#!/usr/bin/python

import os
import json
import sys
import warnings
from threading import Thread

from dejavu import Dejavu
from dejavu.recognize import FileRecognizer

warnings.filterwarnings("ignore")

from flask import Flask, request, redirect, url_for, send_from_directory, jsonify
from werkzeug import secure_filename

UPLOAD_FOLDER = './data'
ALLOWED_EXTENSIONS = set(['mp3'])
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs( UPLOAD_FOLDER, 0755 );

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def init(configpath):
    """
    Load config from a JSON file
    """
    try:
        with open(configpath) as f:
            config = json.load(f)
    except IOError as err:
        print("Cannot open configuration: %s. Exiting" % (str(err)))
        sys.exit(1)

    # create a Dejavu instance
    return Dejavu(config)

def allowed_file(filename):
    return filename[-3:].lower() in ALLOWED_EXTENSIONS

@app.route('/health', methods=['GET'])
def health():
    return 'ok'

config_file = '/opt/dejavu/dejavu.cnf'
djv = init(config_file)

class Fingerprint(Thread):
    def __init__(self, filepath):
        Thread.__init__(self)
        self.filepath = filepath

    def run(self):
        djv.fingerprint_file(self.filepath)

@app.route('/fingerprint', methods=['POST'])
def fingerprint():
    file = request.files['file']
    if file and allowed_file(file.filename):
        print '**found file', file.filename
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)
        Fingerprint(filepath).start()
        return 'Fingeprint of the song is currently scheduled. The song will be ready in few minutes for recorgnition.'
    return 'The file extension is not allowed'

@app.route('/recorgnize', methods=['POST'])
def recorgnize():
    file = request.files['file']
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)
        return jsonify(djv.recognize(FileRecognizer, filepath))
    return 'The file extension is not allowed'

if __name__ == '__main__':
     app.run(host='0.0.0.0', port='8080', debug=True)