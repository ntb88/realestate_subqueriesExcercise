use realestateDB_subqueries; 


show tables; 


select * from Agents; 
select * from Clients;
select * from Properties; 
select * from PropertyAmenities;
select * from PropertyAmenityAssignments;
select * from PropertyDetails; 
select * from PropertyStatus;
select * from PropertyTypes;
select * from Transactions; 

-- 1 
select avg(listingprice) 
from Properties; 

-- 2 
select address 
from Properties 
where listingprice = 
(select min(listingprice) 
from Properties); 

-- 3 
select address 
from Properties 
where listingprice > (
select avg(listingprice) 
from Properties ); 

-- 4 
select firstName, lastname 
from Agents 
where AgentID IN  
(select DISTINCT AgentID 
from Properties
where listingprice > 500000 ); 


-- 5 
select p.address, pd.bedrooms 
from Properties p 
inner join 
Propertydetails pd 
using(PropertyID) 
where pd.bedrooms =  (select max(bedrooms) from propertyDetails); 

-- 6 
select avg(bedrooms) 
from propertydetails; 

-- 7 
select p.propertyid, p.address, p.city, p.state 
from properties p
inner join 
Propertydetails pd 
using(propertyid)
where pd.yearbuilt = 
(select min(yearbuilt) from propertydetails); 

-- 8 
select * 
from properties 
inner join 
Propertydetails 
using(propertyid) 
where bathrooms > 
(select avg(bathrooms) 
from propertydetails);

-- 9 

select * from properties; 
select * from PropertyAmenities;
select * from PropertyAmenityAssignments;


select count(*) as PropertiesWithPool 
from properties 
where propertyid 
IN 
(select propertyid 
from PropertyAmenities pa 
join 
PropertyAmenityAssignments paa 
using(amenityid) 
where AmenityName = 'pool'); 

-- 10  
select AmenityName , amenityid
from PropertyAmenities pa 
where (
select count(*) 
from PropertyAmenityAssignments paa
where paa.amenityid = pa.amenityid )  > 3; 

-- 11 

select * from properties; 
select * from propertydetails; 

select p.propertyid, p.address, p.city, p.state, p.listingprice, pd.bedrooms
from Properties p 
join 
propertydetails pd 
using(propertyid) 
where 
bedrooms > (select avg(bedrooms) from propertydetails) 
AND 
listingprice > (select avg(listingprice) from properties)
order by listingprice; 


-- 12 
select * from Clients; 
select * from Properties; 
select * from Transactions; 
select * from propertydetails; 

select c.FirstName , c.lastname , t.saleprice, pd.bedrooms 
from Clients c 
join 
Transactions t
using(clientid)
inner join propertydetails pd 
using(propertyid)
where saleprice > 500000 
AND 
bedrooms > 3;



