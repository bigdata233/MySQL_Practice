import pymysql
conn = pymysql.connect(host='127.0.0.1', user='root', password = '3032', db='soloDB', charset='utf8')

cur = conn.cursor()
cur.execute("create table userTable (id char(4), userName char(15), email char(20), birthYear int)")

cur.execute("insert into userTable values('hong', '홍지윤', 'hong@naver.com', 1996)")
cur.execute("insert into userTable values('kim', '김태연', 'kim@daum.net', 2011)")
cur.execute("insert into userTable values('star', '별사랑', 'star@paran.com', 1990)")
cur.execute("insert into userTable values('yang', '양지은', 'yang@gmail.com', 1993)")

conn.commit()
conn.close()