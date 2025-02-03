use airlines;
select * from passenger;
select * from flighthistory;

# Query 1 : Find the names of person who has flown at least 2 times 
# during last 2 months (i.e. starting from 2 months before the latest entry in the database).

SELECT 
    p.`FName` AS FirstName,
    p.`Surname` AS LastName,
    COUNT(fh.`Reservation_ID`) AS FlightCount 
FROM 
    Passenger p
JOIN 
    FlightHistory fh ON p.`Passenger NO` = fh.PassengerID
WHERE 
    fh.`FlightDate` BETWEEN (
        SELECT DATE_SUB(MAX(`FlightDate`), INTERVAL 2 MONTH) FROM FlightHistory
    ) AND (
        SELECT MAX(`FlightDate`) FROM FlightHistory
    )
GROUP BY 
    p.`FName`, p.`Surname`
HAVING 
    COUNT(fh.`Reservation_ID`) >= 2;
    
# Query 2: Find the person paying the most to fly in the month November
# LIMIT 1 restricts the number of rows returned by a query to just one.
SELECT * FROM flighthistory;

SELECT 
	p.`FName` AS FirstName,
    p.`Surname` AS LastName,
    SUM(fh.`FinalCharge`) AS TotalPayment
FROM Passenger as p, FlightHistory as fh
WHERE p.`Passenger NO` = fh.`PassengerID`
AND MONTH(fh.`Reservation_Date`) = 11
GROUP BY 
    p.`Passenger NO`, p.`FName`, p.`Surname`
ORDER BY 
    TotalPayment DESC LIMIT 1;

# Query 3: Find the most preferable flight destination in "November"?
SELECT 
    f.`ArrivalAirport` AS Destination,
    COUNT(fh.`Reservation_ID`) AS TotalFlights
FROM 
    FlightHistory AS fh, Flight AS f
WHERE 
    fh.`FlightID` = f.`FlightID`
    AND MONTH(fh.`FlightDate`) = 11
GROUP BY 
    f.`ArrivalAirport`
ORDER BY 
    TotalFlights DESC
LIMIT 1;

# Query 4: Which destinations have more than one flight in a single month from Istanbul? 
SELECT 
    f.`ArrivalAirport` AS Destination,
    MONTH(fh.`FlightDate`) AS Month,
    COUNT(fh.`FlightID`) AS FlightCount
FROM 
    FlightHistory AS fh, Flight AS f
WHERE 
    fh.`FlightID` = f.`FlightID`
    AND f.`DepartureAirport` = 'Istanbul'
GROUP BY 
    f.`ArrivalAirport`, MONTH(fh.`FlightDate`)
HAVING 
    FlightCount > 1;

# Query 5: Which flight has the highest utilization in Economy Class during December?
SELECT * FROM flighthistory;
SELECT 
    fh.`FlightID` AS FlightID,
    f.`DepartureAirport` AS Departure,
    f.`ArrivalAirport` AS Arrival,
    f.`CapacityOfEconomyClass` AS TotalEconomySeats,
    COUNT(fh.`Reservation_ID`) AS ReservedSeats,
    ROUND((COUNT(fh.`Reservation_ID`) / f.`CapacityOfEconomyClass`) * 100, 2) AS UtilizationPercentage
FROM 
    FlightHistory AS fh, 
    Flight AS f
WHERE 
    fh.`FlightID` = f.`FlightID`
    AND MONTH(fh.`FlightDate`) = 12
    AND fh.`Class` = 'Economy'
GROUP BY 
    fh.`FlightID`, f.`DepartureAirport`, f.`ArrivalAirport`, f.`CapacityOfEconomyClass`
ORDER BY 
    UtilizationPercentage DESC
LIMIT 1;
# Query 6: Which Flights are available during "2019" that has at least "3" people from Istanbul to "anywhere", if there is what are their departure times?
SELECT 
    f.`FlightID` AS FlightID,
    f.`DepartureTime` AS DepartureTime,
    f.`ArrivalAirport` AS Destination,
    COUNT(fh.`Reservation_ID`) AS PassengerCount
FROM 
    FlightHistory AS fh, 
    Flight AS f
WHERE 
    f.`FlightID` = fh.`FlightID`
    AND f.`DepartureAirport` = 'Istanbul'
    AND YEAR(fh.`FlightDate`) = 2019
GROUP BY 
    f.`FlightID`, f.`DepartureTime`, f.`ArrivalAirport`
HAVING 
    COUNT(fh.`Reservation_ID`) >= 3;


    
    



