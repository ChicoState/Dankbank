from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

#TODO: Change all these values to actually connect to the database
#TODO: how is this password going to work?
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="root",
    database="test"
)

mycursor = mydb.cursor()

mycursor.execute("CREATE TABLE IF NOT EXISTS customers (name VARCHAR(255) PRIMARY KEY, address VARCHAR(255))")
sql = "INSERT INTO customers (name, address) VALUES (%s, %s)"
val = ("John", "Highway 21")
mycursor.execute(sql, val)

mydb.commit()

@app.route("/")
def hello():
    return "Hello, World!"

@app.route("/json")
def jsoning():
    myfetch = mydb.cursor()
    myfetch.execute("SELECT * FROM customers")
    myresult = myfetch.fetchall()
    return jsonify(myresult)
