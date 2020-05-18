#!/usr/local/bin/python3

import io,sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

sys.path.append("./libs")
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
   return "flaskでhello"

if __name__ == '__main__':
   app.run()
