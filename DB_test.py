import mysql.connector
import re
HOST='localhost'
USER="Access1"
PASS="DB_IO"
DBNAME="library"

def print_member_details(data):
    print("-"*40)
    try:
        print("ID: "+str(data["id"]))
    except KeyError:
        print("ID: Error")
    print("Name: "+data["Fname"]+" "+data["Mname"]+" "+data["Lname"])
    print("Address:")
    k=0
    for each in data["address"]:
        k+=1
        if type(each) is not str:
            print(f"\t{k}.{each[0]}")
        else:
            print(f"\t{k}.{each}")
    print("Email:")
    k=0
    for each in data["email"]:
        k+=1
        if type(each) is not str:
            print(f"\t{k}.{each[0]}")
        else:
            print(f"\t{k}.{each}")
    print("Phone Number:")
    k=0
    for each in data["phone"]:
        k+=1
        if type(each) is not str:
            print(f"\t{k}.{each[0]}")
        else:
            print(f"\t{k}.{each}")
    print("-"*40)

email_re="^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$"

def definite_input():
    while True:
        text=input().strip()
        if text=="":
            continue
        else:
            return text
def input_member():
    print("Enter First Name:",end="")
    data={"Fname":definite_input()}
    print("Enter Middle Name:",end="")
    data["Mname"]=definite_input()
    print("Enter Last Name:",end="")
    data["Lname"]=definite_input()
    print("Enter '-' incase no more info for an attribute can be added")
    print("Enter Addresses:")
    data["address"]=[]
    while True:
        text=definite_input()
        if text=="-":
            break
        data["address"].append(text)
    print("Enter phone numbers:")
    data["phone"]=[]
    while True:
        text=definite_input()
        if text=="-":
            break
        data["phone"].append(text)
    print("Enter email:")
    data["email"]=[]
    while True:
        text=definite_input()
        if text=="-":
            break
        if(re.match(email_re,text)):
            data["email"].append(text)
        else:
            print("Invalid email")
    return data
# temp=input_member()
# print(temp)
# print_member_details(temp)
if __name__=="__main__":
    with mysql.connector.connect(host=HOST,user=USER,password=PASS,database=DBNAME) as DB:
        with DB.cursor() as cursor:
            cursor.execute(f"use {DBNAME}")
            cursor.execute("SHOW DATABASES")


            def read_member_info(id=None,name=None):
                def read_other_attr(id,person):
                    # print(id)
                    cursor.execute(f"select address from member_address where member_id={id}")
                    person["address"]=list(cursor)
                    cursor.execute(f"select email from member_email where member_id={id}")
                    person["email"]=list(cursor)
                    cursor.execute(f"select phone from member_phone_number where member_id={id}")
                    person["phone"]=list(cursor)
                if id is None and name is None:
                    return []
                if id is not None:
                    try:
                        cursor.execute(f"select * from library_member where member_id={id}")
                        temp=list(cursor)
                        person_info={"id":temp[0][0],"Fname":temp[0][1],'Mname':temp[0][2],'Lname':temp[0][3]}
                        read_other_attr(person_info["id"],person_info)
                    except mysql.connector.errors.InternalError as e:
                        print(e)
                else:
                    try:
                        cursor.execute(f"select * from library_member where fname=\"{name}\"")
                        temp=list(cursor)
                        if len(temp)>0:
                            person_info=[0]*len(temp)
                            for i in range (len(temp)):
                                # print(temp,len(temp))
                                person_info[i]={"id":temp[i][0],"Fname":temp[i][1],'Mname':temp[i][2],'Lname':temp[i][3]}
                                read_other_attr(person_info[i]["id"],person_info[i])
                        else:
                            person_info=[]
                    except mysql.connector.errors.InternalError as e:
                        print(e)
                return person_info
            
            # for x in cursor:
            #     print(x)
            # query="select * from library_member"
            # cursor.execute(query)
            data=list(cursor)
            # print(data)
            # print(read_member_info(id=1001))
            print_member_details(read_member_info(id=1001))
            for each in read_member_info(name="James"):
                print_member_details(each)
            
            def insert_member(data=None):
                if data is None:
                    data=input_member()
                cursor.execute("insert into library_member(fname,mname,lname) values(%s,%s,%s)",(data["Fname"],data["Mname"],data["Lname"]))
                val=[]
                # cursor.execute()
                id=cursor.lastrowid
                for each in data["address"]:
                    val.append((id,each))
                print(val)
                cursor.executemany("insert into member_address values(%s,%s)",val)
            insert_member()
            DB.commit()
                
