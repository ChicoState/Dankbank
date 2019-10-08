from starlette.applications import Starlette
# UJSON is highly optimized, but does not handle all edge cases.
# Fallback to JSON instead of UJSON in case of errors in the jsons.
from starlette.responses import UJSONResponse, PlainTextResponse, JSONResponse
from starlette.staticfiles import StaticFiles
import mysql.connector
import json
from getpass import getpass

app = Starlette()
app.debug = True

#TODO: Change all these values to actually connect to the database
#TODO: Is this method of entering the password secure enough?
passw = getpass("Password: ")
data = getpass("Database: ")
mydb = mysql.connector.connect(
    host="34.82.36.144",
    user="root",
    passwd=passw,
    database=data
)

mycursor = mydb.cursor()

@app.route("/")
def test(request):
    return PlainTextResponse("Hello world!")

@app.route("/json")
def jsoning():
    myfetch = mydb.cursor()
    myfetch.execute("SELECT * FROM images")
    row_headers = [h[0] for h in myfetch.description]
    myresult = myfetch.fetchall()
    json_data = []
    for result in myresult:
        json_data.append(dict(zip(row_headers, result)))
    return json.dumps(json_data)
