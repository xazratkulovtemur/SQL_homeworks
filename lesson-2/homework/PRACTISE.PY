import sqlite3
import pyodbc


con_str = "DRIVER={SQL SERVER};SERVER=Temur\SQLEXPRESS;DATABASE=homework;Trusted_Connection=yes"
con = pyodbc.connect(con_str)

cursor = con.cursor()
cursor.execute(
    """
    SELECT * FROM Lesson_2.photo;
    """
)


row = cursor.fetchone()
id,data = row
with open("Updated.png", 'wb') as file:
    file.write(data)  