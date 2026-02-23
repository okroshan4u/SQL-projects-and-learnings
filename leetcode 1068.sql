select product_name , year , pr
from Sales as s
left join Product as p

on s.product_id = p.product_id
