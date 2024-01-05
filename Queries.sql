drop database Library;
create database Library;
use Library;
create table Book(
	Book_id int,
    Title varchar(70) not null,
    Edition int,
    Available bool default true,
    primary key(Book_id)
);
create table Author(
	Author_id int,
    Author_name varchar(200),
    primary key(Author_id)
);
create table Publisher(
	Publisher_id int,
    Publisher_name varchar(200),
    primary key(Publisher_id)
);
create table Library_member(
	Member_id int auto_increment,
    Fname varchar(30) not null,
    Mname varchar(30),
    Lname varchar(30),
    primary key(Member_id)
);
create table Borrowed_by(
	Transaction_id int,
    Due_date date,
    Borrowing_date date,
    Book_id int,
    Member_id int,
	primary key(Transaction_id),
    foreign key(Book_id) references Book(Book_id),
    foreign key(Member_id) references Library_member(Member_id)
);
create table Written_by(
	Author_id int,
    Book_id int,
    foreign key(Book_id) references Book(Book_id),
    foreign key(Author_id) references Author(Author_id),
	primary key(Book_id,Author_id)
);
alter table Book add column Publisher_id int;
alter table Book add foreign key(Publisher_id) references Publisher(Publisher_id);

create table Genre(
	Genre_id int,
    Genre_name varchar(30),
    primary key(Genre_id)
);

create table Book_genre(
	Book_id int,
    Genre_id int,
    foreign key(Book_id) references Book(Book_id),
    foreign key(Genre_id) references Genre(Genre_id),
    primary key(Book_id,Genre_id)
);
create table Member_address(
	Member_id int,
    address varchar(200) not null,
    foreign key(Member_id) references Library_member(Member_id),
    primary key(Member_id,address)
);
create table Member_email(
	Member_id int,
    email varchar(70) not null,
    foreign key(Member_id) references Library_member(Member_id),
    primary key(Member_id,email)
);
create table Member_phone_number(
	Member_id int,
    phone varchar(15) not null,
    foreign key(Member_id) references Library_member(Member_id),
    primary key(Member_id,phone)
);
insert into library_member values(1001,'James','','Ackerson');
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
