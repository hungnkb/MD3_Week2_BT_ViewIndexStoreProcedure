create database BT_ViewIndexProcedure_demo;
use BT_ViewIndexProcedure_demo;

create table Products(
Id int,
productCode int,
productName varchar(200),
productPrice int,
productAmount int,
productDescription varchar(300),
productStatus varchar(20)
);

insert into Products(Id, productCode, productName, productPrice, productAmount)
value(1, 1, 'A', 100, 1000),
(2, 2, 'B', 200, 2000),
(3, 3, 'C', 300, 3000),
(4, 4, 'D', 400, 4000),
(5, 5, 'E', 500, 5000);

create unique index index_productCode
on  Products(productCode);

create index index_productName_productPrice
on Products(productName, productPrice);

explain select productName from products;

create view productView as
select productCode, productName, productPrice, productStatus
from Products;

select * from productView 

delimiter //
create procedure getProduct()
begin
select * from Products;
end
// delimiter ;

call getProduct()

# insert product procedure
delimiter //
create procedure insertProduct(
in 
itemId int,
itemCode int,
itemName varchar(200),
itemPrice int,
itemAmount int,
itemDescription varchar(300),
itemStatus varchar(20)
)
begin
insert into Products (Id,
productCode,
productName,
productPrice,
productAmount,
productDescription,
productStatus)
value (itemId, itemCode, itemName, itemPrice, itemAmount, itemDescription, itemStatus);
select * from Products where Id = itemId;
end
// delimiter ;

call insertProduct(6, 6, 'F', 990, 5000, 'a', 'b');

# modify product by id
delimiter //
create procedure updateProduct(
in 
itemId int,
itemCode int,
itemName varchar(200),
itemPrice int,
itemAmount int,
itemDescription varchar(300),
itemStatus varchar(20)
 )
 
begin
update Products
set
productCode = itemCode,
productName = case when itemName is null then productName else itemName end,
productPrice = case when itemPrice is null then productPrice else itemPrice end,
productAmount = case when itemAmount is null then productAmount else itemAmount end,
productDescription = case when itemDescription is null then productDescription else itemDescription end,
productStatus = case when itemStatus is null then productStatus else itemStatus end
where Id = itemId;
select * from Products;
end
// delimiter ;

call insertProduct(7, 7, 'G', 1990, 15000, 'a', 'b');
call updateProduct(7, 13, null, null, null, null, null);

# delete item
delimiter //
create procedure deleteProduct(in itemId int)
begin
delete from Products where Id = itemId;
end
// delimiter ;
