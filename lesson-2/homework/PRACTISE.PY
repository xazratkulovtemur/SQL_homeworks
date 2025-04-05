import sqlite3
import pyodbc


con_str = "DRIVER={SQL SERVER};SERVER=Temur\SQLEXPRESS;DATABASE=DB;Trusted_Connection=yes"
con = pyodbc.connect(con_str)

cursor = con.cursor()
cursor.execute(
    """
    SELECT * FROM Lesson_2.products;
    """
)


row = cursor.fetchone()
id, name, data = row
with open(f"{name}.png", 'wb') as file:
    file.write(data)  