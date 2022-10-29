USE [SportGalaxy]

--1 Create MsBrand
CREATE Table MsBrand(
	BrandID CHAR(5) Primary Key CHECK(BrandID LIKE 'BR[0-9][0-9][0-9]'),
	BrandName VARCHAR(50) Not NULL,
	BrandEmail VARCHAR(50) Not NULL CHECK(BrandEmail LIKE '%@%')
)

--2	Add ‘CustomerPhoneNumber’ as new column on MsCustomer table with varchar (50) data type and add a constraint on MsCustomer that CustomerPhoneNumber must be 12 digits long
ALTER TABLE MsCustomer
ADD CustomerPhoneNumber VARCHAR(50)
CONSTRAINT checkCustomerPhoneNumber CHECK(len(CustomerPhoneNumber)>12)


--3 Insert data into MsStaff table
INSERT INTO MsStaff VALUES
('SF006', 'John', 'Male', '2 Lime Kiln, Yeovil, BA21 3RW', 'john@gmail.com', '1993-04-07')


--4 Display StaffID, StaffName, and StaffEmail for every Staff whose email domain is ‘yahoo’
SELECT
StaffID,
StaffName,
StaffEmail
FROM MsStaff
WHERE StaffEmail LIKE '%@yahoo%' --pake % instead of .com incase ada yang pakai domain extension selain .com (.co.id etc)


--5 5.	Delete MsProduct for every product which ProductTypeName is less than 5 characters
DELETE MsProduct
FROM MsProduct p,
MsProductType pt
WHERE p.ProductTypeID = pt.ProductTypeID
AND len(pt.ProductTypeName)<5