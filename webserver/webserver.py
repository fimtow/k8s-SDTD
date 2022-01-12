import datetime
import logging, sys
from flask.json import JSONEncoder
from flask import jsonify, request
from uuid import UUID
import os
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
    date_time = datetime.datetime.now() - datetime.timedelta(minutes=int(lookback))
    date_str = date_time.strftime("%Y-%m-%d %H:%M:%S-0000")
    rows = session.execute("SELECT name,market_dominance FROM coin_by_marketdominance where inserted_in_db >= '%s' ALLOW FILTERING;".format(date_str) % (date_time))
    return jsonify(results=rows.all())

if __name__ == '__main__':
    app.run(host='0.0.0.0')
