# from flask import (
#     Flask,
#     render_template
# )
# from sqlalchemy import(
# 	create_engine
# )

# # Create the application instance
# app = Flask(__name__, template_folder="templates")

# # Create a URL route in our application for "/"
# @app.route('/')
# def home():
# 	return render_template('home.html')
# app.run(port=5000)
from flask import Flask
from flask_restful import Api, Resource

app = Flask(__name__)
api = Api(app)

users = [
    {"name":'a',"tag":"hat"},
    {"name":'b',"tag":"hat"},
    {"name":'c',"tag":"hat"},
    {"name":'d',"tag":"hat"},
    {"name":'e',"tag":"hat"},
    {"name":'f',"tag":"hat"},
    {"name":'g',"tag":"hat"}
]

id = 0

class UserAPI(Resource):
    def get(self, name):
        for user in users:
            if user['name'] == name:
                return user
    def post(self, name):
        global id
        user = {'name' : name, 'id' : id}
        id += 1
        users.append(user)
        return user
    
class testAPI(Resource):
    def get(self,data):
        return "data100"
    def post(self,data):
        print(data)
api.add_resource(UserAPI, '/users/<string:name>', endpoint = 'user')
api.add_resource(testAPI, '/test', endpoint = 'from1')

app.run(port='5000')