drop database Library;
create database Library;
use Library;
create table Book(
	Book_id int auto_increment,
    Title varchar(70) not null,
    Edition int,
    Available bool default true,
    constraint pk1 primary key(Book_id)
);
create table Author(
	Author_id int auto_increment,
    Author_name varchar(200),
    constraint pk2 primary key(Author_id)
);
create table Publisher(
	Publisher_id int auto_increment,
    Publisher_name varchar(200),
    constraint pk3 primary key(Publisher_id)
);
create table Library_member(
	Member_id int auto_increment,
    Fname varchar(30) not null,
    Mname varchar(30),
    Lname varchar(30),
    constraint pk4 primary key(Member_id)
);
create table Borrowed_by(
	Transaction_id int auto_increment,
    Due_date date,
    Borrowing_date date,
    Book_id int,
    Member_id int,
	constraint pk5 primary key(Transaction_id),
    constraint fk1 foreign key(Book_id) references Book(Book_id),
    constraint fk2 foreign key(Member_id) references Library_member(Member_id)
);
create table Written_by(
	Author_id int,
    Book_id int,
	constraint pk6 primary key(Book_id,Author_id),
    constraint fk3 foreign key(Book_id) references Book(Book_id) on delete cascade,
    constraint fk4 foreign key(Author_id) references Author(Author_id)
);
alter table Book add column Publisher_id int;
alter table Book add constraint fk5 foreign key(Publisher_id) references Publisher(Publisher_id);

create table Genre(
	Genre_id int,
    Genre_name varchar(30),
    constraint pk7 primary key(Genre_id)
);

create table Book_genre(
	Book_id int,
    Genre_id int,
    constraint pk8 primary key(Book_id,Genre_id),
    constraint fk6 foreign key(Book_id) references Book(Book_id) on delete cascade,
    constraint fk7 foreign key(Genre_id) references Genre(Genre_id)
);
create table Member_address(
	Member_id int,
    address varchar(200) not null,
    constraint pk9 primary key(Member_id,address),
    constraint fk8 foreign key(Member_id) references Library_member(Member_id) on delete cascade
);
create table Member_email(
	Member_id int,
    email varchar(70) not null,
    constraint pk10 primary key(Member_id,email),
    constraint fk9 foreign key(Member_id) references Library_member(Member_id) on delete cascade
);
create table Member_phone_number(
	Member_id int,
    phone varchar(15) not null,
    constraint pk11 primary key(Member_id,phone),
    constraint fk10 foreign key(Member_id) references Library_member(Member_id) on delete cascade
);
create table user_cred(
	id int,
    user_name varchar(30) unique not null,
    password varchar(30) not null,
    constraint pk12 primary key(id),
    constraint fk11 foreign key(id) references Library_member(Member_id) on delete cascade
);
create table test(
    id int auto_increment,
    name varchar(30),
    password varchar(1000),
    primary key(id)
);
create view users as select user_name from user_cred;

insert into library.library_member values(1001,'James','','Ackerson');
insert into library.member_address values(1001,'Bightin House, 4th Avenue');
insert into library.member_email values(1001,'james@gmail.com');
insert into library.member_phone_number values(1001,'+448836937399');

insert into library.member_address values(1001,'Draing House, 7th street');
insert into library.member_email values(1001,'james@yahoo.com');
insert into library.member_phone_number values(1001,'+448446936799');

insert into library.member_address values(1001,'#403, Lutan Apartments, Luten');
insert into library.member_email values(1001,'destroyer@gmail.com');
insert into library.member_phone_number values(1001,'+443839397698');

insert into library.library_member(fname,mname,lname) values('James','Stone','Hyoren');
insert into library.user_cred values (last_insert_id(),"jamesj","Lib_pass1");

insert into library.library_member(fname,mname,lname) values('Alan','George','Jimcy');
insert into library.user_cred values (last_insert_id(),"Alan","Welcome1");

insert into library.library_member(fname,mname,lname) values('Kevin','','Mathew');
insert into library.user_cred values (last_insert_id(),"Kal","kalo2006M");
