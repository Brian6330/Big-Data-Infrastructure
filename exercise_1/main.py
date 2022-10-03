import psycopg2


def populate_db():
    conn = psycopg2.connect(database="sci_papers", user="postgres", password="superuser", host="127.0.0.1", port="5432")
    print("Opened database successfully")

    cur = conn.cursor()

    cur.execute("INSERT INTO paper (paperID,title,abstract) \
          VALUES (1, 'Paper_title_1', 'lorem ipsum 1')")
    cur.execute("INSERT INTO paper (paperID,title,abstract) \
          VALUES (2, 'Paper_title_2', 'lorem ipsum 2')")
    cur.execute("INSERT INTO paper (paperID,title,abstract) \
          VALUES (3, 'Paper_title_3', 'lorem ipsum 3')")
    cur.execute("INSERT INTO paper (paperID,title,abstract) \
          VALUES (4, 'Paper_title_4', 'lorem ipsum 4')")

    cur.execute("INSERT INTO author (authorID,name,email,affiliation) \
          VALUES (1, 'Alex', 'alex@a.ch', 'uniNe')")
    cur.execute("INSERT INTO author (authorID,name,email,affiliation) \
          VALUES (2, 'Alexander', 'alexander@a.ch', 'UniBe')")
    cur.execute("INSERT INTO author (authorID,name,email,affiliation) \
          VALUES (3, 'Jim', 'jim@a.ch','')")

    cur.execute("INSERT INTO conference (confID,name,ranking) \
          VALUES (1, 'Conf_1', 3)")
    cur.execute("INSERT INTO conference (confID,name,ranking) \
          VALUES (2, 'Conf_2', 1)")
    cur.execute("INSERT INTO conference (confID,name,ranking) \
          VALUES (3, 'Conf_3', 2)")

    cur.execute("INSERT INTO writes (authorID, paperID) \
          VALUES (1, 2)")
    cur.execute("INSERT INTO writes (authorID, paperID) \
          VALUES (2, 1)")
    cur.execute("INSERT INTO writes (authorID, paperID) \
          VALUES (3, 3)")
    cur.execute("INSERT INTO writes (authorID, paperID) \
          VALUES (3, 4)")
    cur.execute("INSERT INTO writes (authorID, paperID) \
          VALUES (1, 4)")

    cur.execute("INSERT INTO submits (paperID, confID, isAccepted, date) \
          VALUES (1, 1, true, '2022-03-24')")
    cur.execute("INSERT INTO submits (paperID, confID, isAccepted, date) \
          VALUES (2, 2, true, '2022-04-24')")
    cur.execute("INSERT INTO submits (paperID, confID, isAccepted, date) \
          VALUES (3, 3, false, '2022-05-24')")
    cur.execute("INSERT INTO submits (paperID, confID, isAccepted, date) \
          VALUES (4, 3, true, '2022-06-24')")

    cur.execute("INSERT INTO cites (paperIDfrom, paperIDto) \
          VALUES (1, 2)")
    cur.execute("INSERT INTO cites (paperIDfrom, paperIDto) \
          VALUES (2, 1)")
    cur.execute("INSERT INTO cites (paperIDfrom, paperIDto) \
          VALUES (3, 4)")
    cur.execute("INSERT INTO cites (paperIDfrom, paperIDto) \
          VALUES (4, 3)")

    conn.commit()
    print("Records created successfully")
    conn.close()


if __name__ == '__main__':
    populate_db()
