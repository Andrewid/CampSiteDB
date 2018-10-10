-----------------------------------------------------------Andrew's
CREATE TABLE Reservation (
    ReservationID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    UserID INT NOT NULL,            --FK
    CampsiteID INT NOT NULL,        --FK
    CheckIn_Date DATE NOT NULL,
    CheckOut_Date DATE NOT NULL,
    Invoice_Total SMALLMONEY NOT NULL
);

CREATE TABLE Campsite_ReservedDates (
    CampsiteID INT NOT NULL,        --FK
    DayReserved DATE NOT NULL
);

-----------------------------------------------------------