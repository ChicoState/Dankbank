from starlette.applications import Starlette
# UJSON is highly optimized, but does not handle all edge cases.
# Fallback to JSON instead of UJSON in case of errors in the jsons.
from starlette.responses import UJSONResponse, PlainTextResponse, JSONResponse
from starlette.staticfiles import StaticFiles
from starlette.config import Config
import mysql.connector
import json
import pathlib

config = Config(pathlib.Path(__file__).parent.parent / '.env')
HOST = config('DATABASE_URL')
PASSWORD = config('SECRET_KEY')

app = Starlette()
app.debug = config('DEBUG')

mydb = mysql.connector.connect(
    host=HOST,
    user="root",
    passwd=PASSWORD,
    database="Dankbase"
)

mycursor = mydb.cursor()

@app.route("/")
async def test(request):
    return PlainTextResponse("Hello world!")

@app.route("/json")
async def jsoning(request):
    myfetch = mydb.cursor()
    myfetch.execute("SELECT * FROM instagram_images")
    row_headers = [h[0] for h in myfetch.description]
    myresult = myfetch.fetchall()
    json_data = []
    for result in myresult:
        json_data.append(dict(zip(row_headers, result)))
    return JSONResponse(json_data)
