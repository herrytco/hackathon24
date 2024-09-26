# app.py
from flask import Flask, request, jsonify

app = Flask(__name__)

stations = {
    "1" : "90",
    "2" : "75",
    "3" : "50",
    "4" : "70",
    "5" : "65",
    "6" : "80",
    "7" : "50",
    "8" : "60"
}

@app.route('/requestStation', methods=['GET'])
def search():
    args = request.args
    sid = args.get('id')
    chargePro = args.get('charg')
    sids = args.getlist("id")

    # result = db_users
    result = dict()
    if None not in (sids, chargePro):
        for i in sids:
            if int(stations.get(i)) >= int(chargePro):
                result[i] = "true"
            else:
                result[i] = "false"

    return jsonify(result)
