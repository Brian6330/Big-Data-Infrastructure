CREATE DATABASE sci_papers;
-- Above and below must be done in separate queries within pgadmin
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

-- REFERENCES refer to foreign keys
CREATE TABLE submits (
	paperID INT REFERENCES paper(paperID) ON DELETE RESTRICT ON UPDATE RESTRICT,
	confID INT REFERENCES conference(confID) ON DELETE RESTRICT ON UPDATE RESTRICT,
	isAccepted BOOLEAN NOT NULL, -- has to be accepted or not, thus boolean
	date DATE NOT NULL, -- date must be provided
	PRIMARY KEY (paperID, confID) -- primary key is a tuple
);

CREATE TABLE cites (
	paperIDfrom INT REFERENCES paper(paperID) ON DELETE RESTRICT ON UPDATE RESTRICT,
	paperIDto INT REFERENCES paper(paperID) ON DELETE RESTRICT ON UPDATE RESTRICT,
	PRIMARY KEY (paperIDfrom, paperIDto) -- primary key that is a tuple
);

-- Exercise 1
SELECT ranking, count(*) -- count(*) means to count all rows returned
FROM conference
GROUP BY ranking -- so we have the count per ranking
ORDER BY ranking ASC;

-- Exercise 2 --
SELECT abstract
FROM paper NATURAL JOIN Writes -- Natural Join joins based on matching columns, in this case authorID
	NATURAL JOIN Author

WHERE author."name" = 'Alex'
	OR Author."name" = 'Alexander';

-- Exercise 3
SELECT author."name" FROM author
WHERE authorID IN (
	SELECT DISTINCT writes.authorID
	FROM writes JOIN cites ON writes.paperID = cites.paperIDfrom
	    JOIN writes AS temp ON paperIDto = temp.paperID
	WHERE paperIDfrom <> paperIDto -- safety check to not have papers citing themself, only the author
	    AND writes.authorID = temp.authorID
);

-- Exercise 4
CREATE VIEW PublishesIn(authorID, confID) AS -- output viewable in pgadmin
SELECT DISTINCT authorID, confID
FROM Submits NATURAL JOIN Writes
WHERE isAccepted = True;

-- Exercise 5
SELECT title 
FROM Paper NATURAL JOIN Writes AS alex NATURAL JOIN Author
WHERE Author.name ='Alex'
    AND EXISTS (SELECT *
        FROM Writes
        WHERE paperID = alex.paperID
            AND authorID <> alex.authorID
    );


