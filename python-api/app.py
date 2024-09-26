# app.py
from flask import Flask, request, jsonify

app = Flask(__name__)

# seule = [
#     {"id": 1, "name": "Thailand", "capital": "Bangkok", "area": 5},
#     {"id": 2, "name": "Australia", "capital": "Canberra", "area": 7617930},
#     {"id": 3, "name": "Egypt", "capital": "Cairo", "area": 1010408},
# ]

# def _find_next_id():
#     return max(country["id"] for country in seule) + 1

# @app.get("/countries")
# def get_countries():
#     return jsonify(seule)

# @app.post("/countries")
# def add_country():
#     if request.is_json:
#         country = request.get_json()
#         country["id"] = _find_next_id()
#         countries.append(country)
#         return country, 201
#     return {"error": "Request must be JSON"}, 415

stations = {
    "1" : "90",
    "2" : "75",
    "3" : "80",
    "4" : "50",
    "5" : "60"
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