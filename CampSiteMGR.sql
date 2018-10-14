--------------------- Andrew moved these. As the following tables reference these

----------------------------------------------------------- Users table
-- We need the address before the user can have the address
CREATE TABLE Addresses (
	AddressID int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	Street nvarchar(255),
	State nvarchar(255),
	Zip nvarChar(255)
);

CREATE TABLE Users (
	UserID int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	Email varchar(320),
	Firstname varchar(50),
	Lastname varchar(50),
	PhoneNumber varchar(15),
	Date_of_Birth date,
	AddressID int NOT NULL,
	FOREIGN KEY (AddressID) REFERENCES Addresses (AddressID) 
);

INSERT INTO Addresses(Street, State, Zip)
	VALUES ('2045 North Waverly Street', 'AZ', '85001')

INSERT INTO Addresses(Street, State, Zip)
	VALUES ('4307 South Front Street', 'CA', '90001')

INSERT INTO Users(Email, Firstname, Lastname, PhoneNumber, Date_of_Birth, AddressID) 
	VALUES ('exemail@aol.com', 'Bob', 'Broker', '4354235346', '1992/04/16', 1)

INSERT INTO Users(Email, Firstname, Lastname, PhoneNumber, Date_of_Birth, AddressID) 
	VALUES ('exe2mail@aol.com', 'Rick', 'Schroder', '8012489534', '1984/11/23', 2)

/*
SELECT * FROM Users
SELECT * FROM Addresses

DROP TABLE Users;
DROP TABLE Addresses;*/

drop table Campgrounds;
drop table Campsites;

CREATE TABLE CampGrounds
(
	CampgroundID int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	CampgroundName nvarchar(255),
	HostID int FOREIGN KEY REFERENCES Users(UserID),
	ParkingStalls int,
	AddressID int,
	Website nvarchar(1000),
	StandardCheckoutTime int -- or should we just decide that this is 11 am universally?
);

CREATE TABLE CampSites
(
	CampSiteID int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	CampgroundID int, --fk
	Longitude float,
	Latitude float,
	ImageURL nvarchar(1000),
	BaseCost smallMoney,
	FOREIGN KEY (CampgroundID) REFERENCES Campgrounds (CampgroundID)
);

--Campground 1
INSERT INTO CampGrounds(CampgroundName, HostID, ParkingStalls, AddressID, Website, StandardCheckoutTime) 
	VALUES('Bridge Bay', 1, 300, 1, 'https://www.nps.gov/yell/planyourvisit/bridgebaycg.htm', '8');
--Bridge Bay Campground, 260 Bridge Bay Campground, Yellowstone National Park, WY 82190

-- Campsite 1, child of 1
INSERT INTO CampSites(CampgroundID, Longitude, Latitude, ImageURL, BaseCost) 
	VALUES(1,  42.706769, -113.6592416, 'https://www.yellowstonenationalparklodges.com/lodgings/campground/bridge-bay-campground/', 25.25);

-- campground 2
INSERT INTO CampGrounds(CampgroundName, HostID, ParkingStalls, AddressID, Website, StandardCheckoutTime) 
	VALUES('Madison', 1, 270, 2, 'https://www.yellowstonenationalparklodges.com/lodgings/campground/madison-campground/', 8);

-- campsite 2 of 'ground 2
INSERT INTO CampSites(CampgroundID, Longitude, Latitude, ImageURL,BaseCost) -- Campsite #2
	VALUES(2, 4438.725, 11051.687, 'https://ynpres1.xanterra.com/CGI-BIN/LANSAWEB?WEBEVENT+R616E0F8B07058601903A004+RES+ENG', 25.25);
--Madison Sm Tent-Only Site


-- Campground 3
INSERT INTO CampGrounds(CampgroundName, HostID, ParkingStalls, AddressID, Website, StandardCheckoutTime) 
	VALUES('Canyon', 1, 270, 3, 'https://www.yellowstonenationalparklodges.com/lodgings/campground/canyon-campground/', 8);
--Canyon Campground, 27 Andesite Ln, Yellowstone National Park, WY 82190

-- Campsite 3 of 'ground 3
INSERT INTO CampSites(CampgroundID, Longitude, Latitude, ImageURL, BaseCost) 
	VALUES(3, 4444.118, 11029.17, 'https://ynpres1.xanterra.com/cgi-bin/lansaweb?procfun+rn+resnet+RES+funcparms+UP(A2560):;YCSUM9;052419;1;1;0;010;?/&_ga=2.228702105.423326928.1539208156-2092921698.1539050501', 30.0 );

--select * from campgrounds;
--select * from campsites;

---------------------------------------------------------- Ensure tables containing any FK reference exsist beforehand

CREATE TABLE Reservations (
   ReservationID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
   UserID INT NOT NULL,            --FK
   CampsiteID INT NOT NULL,        --FK
   CheckIn_Date DATE NOT NULL,
   CheckOut_Date DATE NOT NULL,
   Invoice_Total SMALLMONEY NOT NULL,
   Valid BIT DEFAULT 1,
    FOREIGN KEY (UserID) REFERENCES Users (UserID),
    FOREIGN KEY (CampsiteID) REFERENCES CampSites (CampsiteID)
);

-- numDays = 4
-- Campsite.BaseCost = 31
-- note, a date where a campsite is checked out, another may check in
---- Hmm, how do we account for that in counting the number of days utilized?

SET IDENTITY_INSERT dbo.Reservations ON;
DECLARE @CURRENT_DATE as DATE = Convert(DATE, GETDATE());
INSERT Reservations (UserID, CampsiteID, CheckIn_Date, CheckOut_Date, Invoice_Total)
 VALUES (1,1,@CURRENT_DATE, dateadd(day, 4, @CURRENT_DATE), 4 * 31);
set @CURRENT_DATE = dateadd(day, 4, @CURRENT_DATE); -- add 
INSERT Reservations (UserID, CampsiteID, CheckIn_Date, CheckOut_Date, Invoice_Total)
VALUES (2,1,@CURRENT_DATE, dateadd(day, 4, @CURRENT_DATE), 4 * 31);
set @CURRENT_DATE = Convert(DATE, GETDATE()); -- set it back
INSERT Reservations (UserID, CampsiteID, CheckIn_Date, CheckOut_Date, Invoice_Total)
VALUES (2,2,@CURRENT_DATE, dateadd(day, 4, @CURRENT_DATE), 4 * 31);
set @CURRENT_DATE = dateadd(day, 4, @CURRENT_DATE); -- add 4 again
INSERT Reservations (UserID, CampsiteID, CheckIn_Date, CheckOut_Date, Invoice_Total)
VALUES (1,2,@CURRENT_DATE, dateadd(day, 4, @CURRENT_DATE), 4 * 31);
SET IDENTITY_insert dbo.Reservations OFF;

/****************************************************  We decided against this "extraneous" table
CREATE TABLE Campsite_ReservedDates (
    CampsiteID INT NOT NULL,
    DayReserved DATE NOT NULL
    Valid BIT -- set to 0 for cancelled, default is 1
);
*/
-----------------------------------------------------------
CREATE TABLE Amenity
(
 AmenityID INT IDENTITY NOT NULL PRIMARY KEY, -- <---- THUY CHANGED TO AmenityID
 AmenityName VARCHAR(255) NOT NULL,
 --AmenityDescription VARCHAR(2000) NOT NULL,
)
--------------------------------------------------------------- Campground Amenities that all CampSites share
--------------------------------------------------------------- This is basically a clone of the CampSite Amenity table
CREATE TABLE CampGround_Amenity
(
 CampGroundID_PKFK INT NOT NULL,
 AmenityID_PKFK INT NOT NULL,
 Quantity INT NOT NULL,
 PRIMARY KEY (CampGroundID_PKFK, AmenityID_PKFK)
)
ALTER TABLE CampGround_Amenity
ADD CONSTRAINT CampSiteID_PKFK FOREIGN KEY (CampGroundID_PKFK)
 REFERENCES CampGrounds(CampGroundID)
ALTER TABLE CampGround_Amenity
ADD CONSTRAINT AmenityID_PKFK FOREIGN KEY (AmenityID_PKFK)
 REFERENCES Amenity(AmenityID)  -- <--- THUY CHANGED TO AmenityID
------------------------------------------------------------------- 
--
CREATE TABLE CampSite_Amenity
(
 CampSiteID_PKFK INT NOT NULL,
 AmenityID_PKFK INT NOT NULL,
 Quantity INT NOT NULL,
 PRIMARY KEY (CampSiteID_PKFK, AmenityID_PKFK)
)
ALTER TABLE CampSite_Amenity
ADD CONSTRAINT CampSiteID_FK FOREIGN KEY (CampSiteID_PKFK) -- <-- THUY CHANGED CampSiteID_PKFK to just CampSiteID_FK
 REFERENCES CampSites(CampSiteID)
ALTER TABLE CampSite_Amenity
ADD CONSTRAINT AmenityID_FK FOREIGN KEY (AmenityID_PKFK)  -- <-- THUY CHANGED AmenityID_PKFK to just AmenityID_FK
 REFERENCES Amenity(AmenityID) -- <-- THUY CHANGED TO AmenityID
INSERT Amenity (AmenityName) VALUES ('Toilets')    		--campground specific 1

INSERT Amenity (AmenityName) VALUES ('Electricity')  	--campSite specific 2
INSERT Amenity (AmenityName) VALUES ('Fire Ring')   	--campSite specific 3
INSERT Amenity (AmenityName) VALUES ('Fire Wood')   	--campSite specific 4
INSERT Amenity (AmenityName) VALUES ('Tables')     		--campSite specific 5
INSERT Amenity (AmenityName) VALUES ('Sewer Hookups') 	--campSite specific 6
--
INSERT Amenity (AmenityName) VALUES ('Wifi')      		--campground specific 7
INSERT Amenity (AmenityName) VALUES ('Hiking Trails') 	--campground specific 8
INSERT Amenity (AmenityName) VALUES ('ATV Trails')   	--campground specific 9
INSERT Amenity (AmenityName) VALUES ('River')     		--campground specific 10
INSERT Amenity (AmenityName) VALUES ('Lake')      		--campground specific 11
INSERT Amenity (AmenityName) VALUES ('Horse Trails')  	--campground specific 12
INSERT Amenity (AmenityName) VALUES ('Picnicking')   	--campground specific 13
INSERT Amenity (AmenityName) VALUES ('Fishing')    		--campground specific 14
INSERT Amenity (AmenityName) VALUES ('Boating')    		--campground specific 15

--INSERT Amenity (AmenityName) VALUES ('Max Vehicle Length')

--  If we're going ot move the "campground Specific" values to a Campground Amenities table,
--   Some of these will just insert into the other Junction Table
-- Where amenityID is not 2-6
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '1', '1')

INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '2', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '3', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '4', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '5', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '6', '1')

INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '7', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '8', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '9', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '10', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '11', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '12', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('1', '13', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '1', '1')

INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '2', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '3', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '4', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '5', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '6', '1')

INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '7', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '8', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '9', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '10', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '11', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '12', '1')
INSERT CampSite_Amenity (CampSiteID_PKFK, AmenityID_PKFK, Quantity) VALUES ('2', '13', '1')

