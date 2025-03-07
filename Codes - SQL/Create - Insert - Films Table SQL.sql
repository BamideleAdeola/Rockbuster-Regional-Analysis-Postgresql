
CREATE TABLE salesschema.salesfact (
	id INT,
	sojcompany text

);

select * from salesschema.salesfact;

-- LOADING DATA IN SQL;

insert into salesschema.salesfact
VALUES(1, 'Ajangbadi ent');

-- DROPPING TABLE CREATED
drop table salesschema.salesfact;



-- CREATE FILM TABLE 
--create DISTRIBUTORS table 
--FILM TABLE 
create table FILMS(
	code CHAR(5) primary key,
	title VARCHAR(100) not null,
	did INTEGER not null,
	date_released date default now(),
	kind VARCHAR(10),
	len interval hour to minute
);

drop table FILMS;

-- DISTRIBUTORS 
create table distributors (
	did INTEGER primary key,
	name VARCHAR(50) not null check (name <> '')
);



select * from public.films;

-- inserting a single value into a table 
insert into public.films (code, title, did, date_released, kind)
values ('T_601', 'bams', 106, default, 'Drama');



select * from public.films


insert into public.films 
values 
	('ua501', 'tabuwa', 110, '1990-02-10', 'Comedy'),
	('hg120', 'The Killer', 143, DEFAULT, 'Action'),
	('ba123', '7 Doors', 112, '2024-11-11', 'Action')



select * from public.films
limit 3;