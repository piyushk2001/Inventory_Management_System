#Drop procedures
drop procedure get_understocked_item;
drop procedure get_overstocked_item;
drop procedure get_item_count;
drop procedure get_avg_cost;

#Understocked Item Procedure
delimiter //
create procedure get_understocked_item ()
begin
	select * from inv_understock;
end
// delimiter ;

#Overstocked Item Procedure
delimiter //
create procedure get_overstocked_item ()
begin
	select * from inv_overstock;
end
// delimiter ;

#Item Count Procedure
delimiter //
create procedure get_item_count ()
begin
	select count(*) from item;
end
// delimiter ;

#Item Average Cost
delimiter //
create procedure get_avg_cost ()
begin
	select avg(price) from item;
end
// delimiter ;