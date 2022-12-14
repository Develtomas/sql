create table if not EXISTS Users (
  userid int PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  age int2
);

CREATE TABLE if not EXISTS Items (
  itemid int PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  price NUMERIC
);
  
CREATE TABLE if NOT EXISTS Purchases (
    purchaseid int PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    userid int references Users(userid), 
    itemid int references Items(itemid), 
    date DATE NOT NULL DEFAULT CURRENT_DATE
);