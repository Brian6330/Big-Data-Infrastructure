CREATE DATABASE supermarket;
CREATE TABLE product
(prodID INT PRIMARY KEY NOT NULL,
 NAME  TEXT NOT NULL);
 CREATE TABLE supplier
(suppID INT PRIMARY KEY NOT NULL,
 NAME  TEXT NOT NULL);
 CREATE TABLE component
(compID INT PRIMARY KEY     NOT NULL,
 NAME  TEXT NOT NULL);
 
 CREATE TABLE composed_by (
  prodID INTEGER,
  compID INTEGER,
  quantity NUMERIC DEFAULT 1 NOT NULL,
  PRIMARY KEY(prodID, compID),
  CHECK(quantity > 0),
  FOREIGN KEY(prodID) REFERENCES product(prodID) 
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY(compID) REFERENCES component(compID) 
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE sells (
  suppID INTEGER,
  compID INTEGER,
  price NUMERIC DEFAULT 1 NOT NULL,
  PRIMARY KEY(suppID, compID),
  CHECK(price > 0),
  FOREIGN KEY(suppID) REFERENCES supplier(suppID) 
    ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY(compID) REFERENCES component(compID) 
    ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO supplier (suppID,NAME) 
VALUES (0, 'albero'), (1, 'abdel'),(2, 'laura'),(3, 'rana'),(4, 'natalia');

UPDATE supplier SET name = 'alberto'
WHERE suppID = 0;

INSERT INTO product (prodID,NAME) 
VALUES (0, 'pizza'), (1, 'rice'),(2, 'pasta'),(3, 'sandwich'),(4, 'salad'),(5, 'chocolat');

INSERT INTO component (compID,NAME) 
VALUES (1, 'salt'), (2, 'pepper'),(3, 'curry'),(4, 'olive'),(5, 'fat'),(6, 'sugar'), (7, 'nuts'),(8, 'tomato'),(9,'milk'),(10, 'mint');

INSERT INTO composed_by (prodID, compID, quantity) 
VALUES (0,1,0.5),(0,5,0.7),(0,8,20),(0,4,50),(0,9,0.5),
    (1,1,5),(1,5,0.8),(1,3,20),(1,4,50),(1,9,0.5),
     (2,8,0.7), (3,9,0.9),(3,4,0.7),(3,5,2),(5,6,8),(5,7,5),(4,8,50),(5,9,1);
INSERT INTO sells (suppID, compID, price) 
VALUES (4,1,5),(4,2,7),(4,3,2),(4,4,60),(4,10,10), 
     (1,1,4),(1,2,7),(1,10,2),(1,4,60),(1,5,3),
     (2,10,2),(2,2,9),(2,1,10),(2,3,30),(3,5,3),
     (0,10,4),(0,2,10),(0,7,2),(0,8,40);

      
