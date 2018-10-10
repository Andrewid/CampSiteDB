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