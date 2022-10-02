
CREATE TABLE paper (
	paperID SERIAL PRIMARY KEY, -- SERIAL data type allows you to automatically generate unique integer numbers (IDs, identity, auto-increment, sequence) for a column.
	title VARCHAR(255) NOT NULL, -- every paper needs a title, max 255 char
	abstract TEXT NOT NULL -- every paper needs an abstract
);

CREATE TABLE author (
	authorID SERIAL PRIMARY KEY, -- ID is always sensible primary key
	name VARCHAR(255) NOT NULL, -- need a name
	email VARCHAR(255) NOT NULL, -- need an email address
	affiliation VARCHAR(255) -- not every author needs to have an affiliation
);

CREATE TABLE conference (
	confID SERIAL PRIMARY KEY, -- ID is always sensible primary key
	name VARCHAR(255) NOT NULL, -- every conference needs a name
	ranking INT -- a conference does not need to be ranked
);

-- The RESTRICT command specifies the conditions that the row must satisfy before it becomes part of a result set.
-- Do not allow delete if paper is referenced in writes, submits or cities.
CREATE TABLE writes (
	authorID INT REFERENCES author(authorID) ON DELETE RESTRICT ON UPDATE RESTRICT,
	paperID INT REFERENCES paper(paperID) ON DELETE RESTRICT ON UPDATE RESTRICT,
	PRIMARY KEY (authorID, paperID) -- primary key that is a tuple
);

CREATE TABLE submits (
	paperID INT REFERENCES paper(paperID) ON DELETE RESTRICT ON UPDATE RESTRICT,
	confID INT REFERENCES conference(confID) ON DELETE RESTRICT ON UPDATE RESTRICT,
	isAccepted BOOLEAN NOT NULL, -- has to be accepted or not, thus boolean
	date DATE NOT NULL, -- date must be provided
	PRIMARY KEY (paperID, confID) -- primary key is a tuple
);

CREATE TABLE cities (
	paperIDfrom INT REFERENCES paper(paperID) ON DELETE RESTRICT ON UPDATE RESTRICT,
	paperIDto INT REFERENCES paper(paperID) ON DELETE RESTRICT ON UPDATE RESTRICT,
	PRIMARY KEY (paperIDfrom, paperIDto) -- primary key that is a tuple
);

-- Exercise 1
SELECT ranking, count(*) -- count(*) means to count all rows returned
FROM conference
GROUP BY ranking -- so we have the count per ranking
ORDER BY ranking ASC;

-- Exercise 2 -- TODO CHECK with simple JOIN
SELECT abstract
FROM paper NATURAL JOIN Writes 
	NATURAL JOIN Author

WHERE author."name" = 'Alex'
	OR Author."name" = 'Alexander';

-- Exercise 3
SELECT name FROM AUTHOR 
WHERE authorID IN (
	SELECT DISTINCT w.authorID
	FROM Writes w JOIN Cites ON w.paperID = Cites.paperIDfrom
	JOIN Writes AS w1 ON paperIDto = w1.paperID
	WHERE paperIDfrom <> paperIDto
	AND w.authorID = w1.authorID);

-- Exercise 4
CREATE VIEW PublishesIn(authorID, confID) AS
SELECT DISTINCT authorID, confID
FROM Submits NATURAL JOIN Writes
WHERE isAccepted = True;

-- Exercise 5 --TODO Docu
SELECT title 
FROM Paper NATURAL JOIN Writes AS j NATURAL JOIN Author
WHERE Author.name ='Alex'
AND EXISTS (SELECT * 
	FROM Writes 
	WHERE paperID = j.paperID
		AND authorID <> j.authorID 
		AND Author.name = 'Alex'
);


