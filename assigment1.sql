CREATE TABLE Client_master (
    client_no VARCHAR2(6) PRIMARY KEY check(client_no like 'C%'),
    name VARCHAR2(20) not NULL,
    address1 VARCHAR2(30),
    address2 VARCHAR2(30),
    city VARCHAR2(15),
    state VARCHAR2(15),
    pincode number(8),
    bal_due number(10,2)
);

--product master
CREATE TABLE product_master(
    product_no VARCHAR2(6) PRIMARY KEY CHECK(product_no like 'P%'),
    description VARCHAR2(15) NOT NULL,
    profit_percent number(4,2) NOT NULL,
    unit_measure VARCHAR2(10) NOT NULL,
    qty_on_hand number(8) NOT NULL,
    record_lvl number(8) NOT NULL,
    sell_price number(8,2) NOT NULL check(sell_price > 0),
    cost_price number(8,2) NOT NULL check(cost_price > 0)
);

CREATE TABLE salesman_master (
    salesman_no VARCHAR2(6) PRIMARY KEY CHECK(salesman_no like 'S%'),
    salesman_name VARCHAR2(20) NOT NULL,
    address1 VARCHAR2(30) NOT NULL,
    address2 VARCHAR2(30),
    city VARCHAR2(20),
    pincode VARCHAR2(8),
    state VARCHAR2(20),
    sal_amt number(8, 2) NOT NULL CHECK(sal_amt > 0),    
    tgt_to_get number(6, 2) NOT NULL CHECK(tgt_to_get > 0),
    ytd_sales number(6,2) NOT NULL,
    remarks VARCHAR2(60) 
)

CREATE TABLE sales_ord(
    order_no VARCHAR2(6) PRIMARY KEY check(order_no like 'O%'),
    order_date DATE,
    client_no VARCHAR2(6) FOREIGN KEY REFERENCES Client_master(client_no),
    dely_Addr VARCHAR2(25),
    salesman_no VARCHAR2(6) FOREIGN KEY REFERENCES salesman_master(salesman_no),
    dely_type CHAR(1) DEFAULT 'F', CHECK(dely_type in ('F', 'P')),
    billed_yn CHAR(1),
    dely_date date,
    order_status VARCHAR2(10), check(order_status in ('In Process', 'Fulfilled', 'BackOrder', 'Cancelled')),
    CHECK(dely_date >= order_date)
);

CREATE TABLE sales_ord_details(
    order_no varchar2(6) REFERENCES sales_ord(order_no),
    product_no varchar2(6) REFERENCES product_master(product_no),
    qty_ordered number(8),
    qty_disp number(8),
    product_rate number(8, 2),
    PRIMARY KEY(order_no, product_no)
);

insert into salesman_master values('S00001','Kiran','A/14','Worli','Bombay','400002','Maharashtra',3000,100,50,'Good');
insert into salesman_master values('S00002','Manish','65','Nariman','Bombay','400001','Maharashtra',3000,200,100,'Good');
insert into salesman_master values('S00003','Ravi','P-7','Bandra','Bombay','400032','Maharashtra',3000,200,100,'Good');
insert into salesman_master values('S00004','Anish','A/5','Juhu','Bombay','400044','Maharashtra',3000,100,150,'Good');

insert into sales_ord(order_no, order_date, client_no, dely_type, billed_yn, salesman_no, dely_date, order_status) values('O19001','12-jan-96','C00001','F','N','S00001','20-jan-96','In Process');
insert into sales_ord(order_no, order_date, client_no, dely_type, billed_yn, salesman_no, dely_date, order_status) values('O19002','25-jan-96','C00002','P','N','S00002','27-jan-96','Cancelled');
insert into sales_ord(order_no, order_date, client_no, dely_type, billed_yn, salesman_no, dely_date, order_status) values('O46865','18-feb-96','C00003','F','Y','S00003','20-feb-96','Fulfilled');
insert into sales_ord(order_no, order_date, client_no, dely_type, billed_yn, salesman_no, dely_date, order_status) values('O19003','03-april-96','C00001','F','Y','S00001','7-april-96','Fulfilled');
insert into sales_ord(order_no, order_date, client_no, dely_type, billed_yn, salesman_no, dely_date, order_status) values('O46866','20-may-96','C00004','P','N','S00002','22-may-96','Cancelled');
insert into sales_ord(order_no, order_date, client_no, dely_type, billed_yn, salesman_no, dely_date, order_status) values('O19008','24-may-96','C00005','F','N','S00004','24-may-96','In Process');

insert into Client_master(client_no, name, city, pincode, state, bal_due) values ('C00001','Ivan Bayross','Bombay',400054,'Maharashtra',15000);
insert into Client_master(client_no, name, city, pincode, state, bal_due) values ('C00002','Vandana Saitwal','Madras',780001,'Tamil Nadu',0);
insert into Client_master(client_no, name, city, pincode, state, bal_due) values ('C00003','Pramada Jaguste','Bombay',400057,'Maharashtra',5000);
insert into Client_master(client_no, name, city, pincode, state, bal_due) values ('C00004','Basu Navindgi','Bombay',400056,'Maharashtra',0);
insert into Client_master(client_no, name, city, pincode, state, bal_due) values ('C00005','Ravi Sreedharan','Delhi',100001,'Delhi',2000);
insert into Client_master(client_no, name, city, pincode, state, bal_due) values ('C00006','Rukmini','Bombay',400050,'Maharashtra',0);

Update Client_master SET bal_due = 15000, pincode = 400054 WHERE client_no = 'C00001';

insert into product_master values('P00001', '1.44 Floppies', 5, 'Piece', 100, 20, 525, 500);
insert into product_master values('P03453', 'Monitors', 6, 'Piece', 10, 3, 12000, 11280);
insert into product_master values('P06734', 'Mouse', 5, 'Piece', 20, 5, 1050, 1000);
insert into product_master values('P07865', '1.22 Floppies', 3, 'Piece', 100, 20, 525, 500);
insert into product_master values('P07868', 'Keyboards', 2, 'Piece', 10, 3, 3150, 3050);
insert into product_master values('P07885', 'CD Drive', 2.5, 'Piece', 10, 3, 5250, 5100);
insert into product_master values('P07965', '540 HDD', 4, 'Piece', 10, 3, 84000, 800);
insert into product_master values('P07975', '1.44 Drive', 5, 'Piece', 10, 3, 1050, 1000);
insert into product_master values('P08865', '1.22 Drive', 5, 'Piece', 2, 3, 1050, 1000);

INSERT INTO sales_ord_details values('O19001', 'P00001', 4, 4, 525);
INSERT INTO sales_ord_details values('O19001', 'P07965', 2, 1, 8400);
INSERT INTO sales_ord_details values('O19001', 'P07885', 2, 1, 5250);
INSERT INTO sales_ord_details values('O19002', 'P00001', 10, 0, 525);
INSERT INTO sales_ord_details values('O46865', 'P07868', 3, 3, 3150);
INSERT INTO sales_ord_details values('O46865', 'P07885', 3, 1, 5250);
INSERT INTO sales_ord_details values('O46865', 'P00001', 10, 10, 525);
INSERT INTO sales_ord_details values('O46865', 'P03453', 4, 4, 1050);
INSERT INTO sales_ord_details values('O19003', 'P03453', 2, 2, 1050);
INSERT INTO sales_ord_details values('O19003', 'P06734', 1, 1, 12000);
INSERT INTO sales_ord_details values('O46866', 'P07965', 1, 0, 8400);
INSERT INTO sales_ord_details values('O46866', 'P07975', 1, 0, 1050);
INSERT INTO sales_ord_details values('O19008', 'P00001', 10, 5, 525);
INSERT INTO sales_ord_details values('O19008', 'P07975', 5, 3, 1050);

--exercise 
--Exercise3:

Select * from Client_master where name like '_a%';


Select * from Client_master where city like '_a%';


select * from Client_master where city='Bombay' or city = 'Delhi'

select * from Client_master where bal_due > 10000

select * from sales_ord where order_date between '01-JAN-96' and '31-JAN-96'

select * from sales_ord where client_no in ('C00001','C00002')

select * from product_master where sell_price > 2000 and sell_price <= 5000

select sell_price, sell_price * 0.15 "new_price" from product_master where sell_price > 1500

select * from Client_master where state <> 'Maharashtra'

select count(*) from sales_ord

select avg(cost_price) from product_master 

select max(cost_price) "max_price",min(cost_price)"min_price" from product_master

select count (*) from product_master where cost_price >= 1500

select * from product_master where qty_on_hand < record_lvl

--Exeercise 4:

select order_no,order_date from sales_ord 

--Day 3 of SQL

