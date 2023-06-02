#Testing Query
select * from item;
select * from inv_understock;
select * from inv_overstock;
select * from issue_receive;

insert into issue_receive (item_id, transaction_type, quantity, date) values ("1001", "issue", 10, curdate());
insert into issue_receive (item_id, transaction_type, quantity, date) values ("1001", "receive", 10, curdate());

call get_understocked_item();
call get_overstocked_item;
call get_item_count;
call get_avg_cost;