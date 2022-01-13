import datetime
import logging, sys
from flask.json import JSONEncoder
from flask import jsonify, request
from uuid import UUID
import os
import pandas as pd
logging.basicConfig(stream=sys.stderr)

from flask import Flask, render_template, Response
from cassandra.cluster import Cluster
from cassandra.query import dict_factory

cluster = Cluster([os.environ.get('CASSANDRA_PORT_9042_TCP_ADDR')], port=9042)
session = cluster.connect('cryptocurrency')

class UUIDEncoder(JSONEncoder):
    """ JSONEconder subclass used by the json render function.
    This is different from BaseJSONEoncoder since it also addresses
    encoding of UUID
    """     

    def default(self, obj):
        if isinstance(obj, UUID):
            return str(obj)
        else:
            # delegate rendering to base class method (the base class
            # will properly render ObjectIds, datetimes, etc.)
            return super(UUIDEncoder, self).default(obj)


app = Flask(__name__)
app.json_encoder = UUIDEncoder

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/get_values')
def get_values():
    lookback =  request.args.get('lookback', 10)
    session.set_keyspace('cryptocurrency')
    session.row_factory = dict_factory
    resultat = []
    for i in range(1,11):
        resultat.append(session.execute("SELECT name,market_dominance from cryptocurrency.coin_by_marketdominance where rank = "+str(i)+" order by datetime desc limit 1;").one())
    return jsonify(results=resultat)

if __name__ == '__main__':
    app.run(host='0.0.0.0')
