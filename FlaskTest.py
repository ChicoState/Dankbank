from flask import Flask, jsonify
import mysql.connector
from getpass import getpass

app = Flask(__name__)

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
def hello():
    return "Hello, World!"

@app.route("/json")
def jsoning():
    myfetch = mydb.cursor()
    myfetch.execute("SELECT * FROM images")
    myresult = myfetch.fetchall()
    return jsonify(myresult)
