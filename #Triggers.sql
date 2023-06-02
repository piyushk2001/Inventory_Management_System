#Delete triggers
-- drop trigger issue_receive_bi;
-- drop trigger item_au;

#Issue/Receive Trigger
delimiter //
create trigger issue_receive_bi before insert on issue_receive
for each row
begin
	case
		when new.quantity < 2 then
			signal sqlstate "50001" set message_text = "Quantity must be greater than or equal to 2";
		else
			if new.transaction_type = "receive" then
				update item set quantity = quantity + new.quantity where item_id = new.item_id;
			else
				update item set quantity = quantity - new.quantity where item_id = new.item_id;
			end if;
	end case;
end
// delimiter ;

#Item Update/Delete Trigger
delimiter //
create trigger item_au after update on item
for each row
begin
	case
		when new.quantity = new.threshold then
			if (select count(*) from inv_understock where item_id = new.item_id) > 0 then
				delete from inv_understock where item_id = new.item_id;
			elseif (select count(*) from inv_overstock where item_id = new.item_id) > 0 then
				delete from inv_overstock where item_id = new.item_id;
			end if;
		else
			if new.quantity < new.threshold then
				if exists(select * from inv_understock where item_id = new.item_id) then
					update inv_understock set quantity = new.quantity, last_update_date = curdate() where item_id = new.item_id;
				else
					insert into inv_understock (item_id, name, quantity, last_update_date) select new.item_id, new.name, new.quantity, curdate() from item where item_id = new.item_id;
				end if;
            else
				if (select count(*) from inv_overstock where item_id = new.item_id) > 0 then
					update inv_overstock set quantity = new.quantity, last_update_date = curdate() where item_id = new.item_id;
				else
					insert into inv_overstock (item_id, name, quantity, last_update_date) select new.item_id, new.name, new.quantity, curdate() from item where item_id = new.item_id;
				end if;
			end if;
	end case;
end
// delimiter ;