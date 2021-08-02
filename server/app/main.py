from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api')
def main():
    return jsonify({'message': 'You reached it!!!'})
