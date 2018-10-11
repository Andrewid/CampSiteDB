-----------------------------------------------------------Andrew's
CREATE TABLE Reservations (
    ReservationID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    UserID INT NOT NULL,            --FK
    CampsiteID INT NOT NULL,        --FK
    CheckIn_Date DATE NOT NULL,
    CheckOut_Date DATE NOT NULL,
    Invoice_Total SMALLMONEY NOT NULL
);

SET IDENTITY_insert dbo.Reservation ON;
-- numDays = 4
-- Campsite.BaseCost = $31
-- note, a date where a campsite is checked out, another may check in
---- Hmm, how do we account for that in counting the number of days utilized?
---- How about the system knowing if the spot is available
INSERT Reservations VALUES ('1','1',CURRENT_DATE,dateadd(day, 4, CURRENT_DATE), 4 * $31 )
INSERT Reservations VALUES ('2','1',dateadd(day, 4, CURRENT_DATE),dateadd(day, 8, CURRENT_DATE), 4 * $31 )
INSERT Reservations VALUES ('2','2',CURRENT_DATE,dateadd(day, 4, CURRENT_DATE), 4 * $31 )
INSERT Reservations VALUES ('1','2',dateadd(day, 4, CURRENT_DATE),dateadd(day, 8, CURRENT_DATE), 4 * $31 )

SET IDENTITY_insert dbo.Reservation OFF;

CREATE TABLE Campsite_ReservedDates (
    CampsiteID INT NOT NULL,        --FK
    DayReserved DATE NOT NULL
);

-- Now, these insert statements for the Campsite_ReservedDates seem to be asking to be procedural 
--- or even triggered.  Not sure how to do those, but I will ask Russ

-----------------------------------------------------------
CREATE TABLE Amenity
(
 GenreId_PK INT IDENTITY NOT NULL PRIMARY KEY,
 AmenityName VARCHAR(255) NOT NULL,
 --AmenityDescription VARCHAR(2000) NOT NULL,
)
CREATE TABLE CampSite_Amenity
(
 CampSiteID_PKFK INT NOT NULL,
 AmenityID_PKFK INT NOT NULL,
 Quantity INT NOT NULL,
 PRIMARY KEY (CampSiteID_PKFK, AmenityID_PKFK)
)
ALTER TABLE CampSite_Amenity
ADD CONSTRAINT CampSiteID_PKFK FOREIGN KEY (CampSiteID_PKFK)
 REFERENCES CampSite(CampSiteID_PK)
ALTER TABLE CampSite_Amenity
ADD CONSTRAINT AmenityID_PKFK FOREIGN KEY (AmenityID_PKFK)
 REFERENCES Amenity(AmenityID_PK)
INSERT Amenity (AmenityName) VALUES ('Toilets')    --campground specific
INSERT Amenity (AmenityName) VALUES ('Electricity')  --campSite specific
INSERT Amenity (AmenityName) VALUES ('Fire Ring')   --campSite specific
INSERT Amenity (AmenityName) VALUES ('Fire Wood')   --campSite specific
INSERT Amenity (AmenityName) VALUES ('Tables')     --campSite specific
INSERT Amenity (AmenityName) VALUES ('Sewer Hookups') --campSite specific
INSERT Amenity (AmenityName) VALUES ('Wifi')      --campground specific
INSERT Amenity (AmenityName) VALUES ('Hiking Trails') --campground specific
INSERT Amenity (AmenityName) VALUES ('ATV Trails')   --campground specific
INSERT Amenity (AmenityName) VALUES ('River')     --campground specific
INSERT Amenity (AmenityName) VALUES ('Lake')      --campground specific
INSERT Amenity (AmenityName) VALUES ('Horse Trails')  --campground specific
INSERT Amenity (AmenityName) VALUES ('Picnicking')   --campground specific
INSERT Amenity (AmenityName) VALUES ('Fishing')    --campground specific
INSERT Amenity (AmenityName) VALUES ('Boating')    --campground specific
--INSERT Amenity (AmenityName) VALUES ('Max Vehicle Length')
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



drop table campsites;
drop table campgrounds;

CREATE TABLE CampSites
(
	CampSiteID int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	CampgroundID int,
	Longitude float,
	Latitude float,
	ImageURL nvarchar(1000),
	BaseCost smallMoney
);

CREATE TABLE CampGrounds
(
	CampgroundID int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	CampgroundName nvarchar(255),
	HostID int,
	ParkingStalls int,
	AddressID int,
	Website nvarchar(1000),
	StandardCheckoutTime int

);


INSERT INTO CampGrounds(CampgroundName, HostID, ParkingStalls, AddressID, Website, StandardCheckoutTime) VALUES('Bridge Bay', 1, 300, 1, 'https://www.nps.gov/yell/planyourvisit/bridgebaycg.htm', '8');
--Bridge Bay Campground, 260 Bridge Bay Campground, Yellowstone National Park, WY 82190

INSERT INTO CampSites(CampgroundID, Longitude, Latitude, ImageURL, BaseCost) VALUES(1,  42.706769, -113.6592416, 'https://www.yellowstonenationalparklodges.com/lodgings/campground/bridge-bay-campground/', 25.25);



INSERT INTO CampGrounds(CampgroundName, HostID, ParkingStalls, AddressID, Website, StandardCheckoutTime) VALUES('Madison', 1, 270, 2, 'https://www.yellowstonenationalparklodges.com/lodgings/campground/madison-campground/', 8);

INSERT INTO CampSites(CampgroundID, Longitude, Latitude, ImageURL,BaseCost) VALUES(2, 4438.725, 11051.687, 'https://ynpres1.xanterra.com/CGI-BIN/LANSAWEB?WEBEVENT+R616E0F8B07058601903A004+RES+ENG', 25.25);
--Madison Sm Tent-Only Site

-- confused on capacity:

INSERT INTO CampGrounds(CampgroundName, HostID, ParkingStalls, AddressID, Website, StandardCheckoutTime) VALUES('Canyon', 1, 270, 3, 'https://www.yellowstonenationalparklodges.com/lodgings/campground/canyon-campground/', 8);
--Canyon Campground, 27 Andesite Ln, Yellowstone National Park, WY 82190


INSERT INTO CampSites(CampgroundID, Longitude, Latitude, ImageURL, BaseCost) VALUES(3, 4444.118, 11029.17, 'https://ynpres1.xanterra.com/cgi-bin/lansaweb?procfun+rn+resnet+RES+funcparms+UP(A2560):;YCSUM9;052419;1;1;0;010;?/&_ga=2.228702105.423326928.1539208156-2092921698.1539050501', 30.0 );



--select * from campgrounds;
--select * from campsites;