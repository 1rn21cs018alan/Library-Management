drop database Library;
create database Library;
use Library;
create table Book(
	Book_id int auto_increment,
    Title varchar(200) not null,
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
    Publisher_phone varchar(20),
    Publisher_address varchar(200),
    constraint pk3 primary key(Publisher_id)
);
create table Library_member(
	Member_id int auto_increment,
    Fname varchar(30) not null,
    Mname varchar(30),
    Lname varchar(30),
    Membership_level int default 1,
    Books_taken int default 0,
    constraint pk4 primary key(Member_id)
);
create table Borrowed_by(
	Transaction_id int auto_increment,
    Due_date date,
    Borrowing_date date,
    Book_id int,
    Member_id int,
    returned bool default False,
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
    last_login date default "2000-01-01",
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

create view users as select user_name,last_login from user_cred;

delimiter //
create trigger returned
after update on library.borrowed_by
for each row
begin
	if(new.returned<=>True) then 
		update library.book B set B.Available = true where B.Book_id=new.Book_id;
        update library.library_member M set M.Books_taken=M.Books_taken-1 where M.Member_id=new.Member_id;
    end if;
end;//
delimiter ;



insert into library.library_member(Member_id,Fname,Mname,Lname) values(1001,'James','','Ackerson');
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
insert into library.user_cred(id,user_name,password) values (last_insert_id(),"jamesj","Lib_pass1");

insert into library.library_member(fname,mname,lname) values('Alan','George','Jimcy');
insert into library.user_cred(id,user_name,password) values (last_insert_id(),"Alan","Welcome1");

insert into library.library_member(fname,mname,lname) values('Kevin','','Mathew');
insert into library.user_cred(id,user_name,password) values (last_insert_id(),"Kal","kalo2006M");

insert into library.Publisher values
(1,"Fingerprint! Publishing","+9111-23265358","Prakash Books India Pvt Ltd, 113A, Ansari Road, Daryaganj, New Delhi-110002"),
(2,"Cambridge University Press","+44(0)1223 553311","Cambrudge University Press & Asssessment, Shaftesbury Road, Cambridge, CB28EA"),
(3,"Charles Scribner's Sons",Null,"153-157 Fifth Avenue, New York City, U.S."),
(4,"New Age International Publishers",Null,"New Age International Pvt Ltd, Malliarjuna Tmeple Street,NR Colony, Basavangudi, Bengaluru, Karnataka, India"),
(5,"HarperTorch","+55 21 3175-1030","R. da Quitanda, 86 - Centro, Rio de Janeiro - RJ, 20091-005"),
(6,"Prentice - Hall","+60 3-567333159","11A, Jalan PJS 7/19Taman Bandar Sunway, 46150 Petaling Jaya, Selangor, Malaysia");

Insert into library.author(Author_id,Author_name) values 
(1,"Earnest Hemingway"),
(2,"Leo Tolstoy"),
(3,"Paulo Cohelo"),
(4,"M. Govindarajan"),
(5,"S. Natarajan"),
(6,"B. Ram"),
(7,"Sanjay Kumar"),
(8,"Steven L Brunton"),
(9,"J. Nathan Kutz");
insert into library.Book(Book_id,Title,Edition,Publisher_id) values
(1,"War and Peace",4,1),
(2,"War and Peace",1,1),
(3,"Anna Karenina",3,1),
(4,"For Whom The Bell Tolls",4,3),
(5,"The Alchemist",19,5),
(6,"Engineering Ethics",6,6),
(7,"Computer Fundamentals:Architecture and Organisation",6,4),
(8,"Data-Driven Science and Engineering: Machine Learning, Dynamic Systems and Control",2,2)
;
insert into library.written_by(Book_id,Author_id) values
(1,2),
(2,2),
(3,2),
(4,1),
(5,3),
(6,4),
(6,5),
(7,6),
(7,7),
(8,9)
;

insert into library.genre values
(1,"Fantasy"),
(2,"Adventure"),
(3,"Romance"),
(4,"Contemporary"),
(5,"Dystopian"),
(6,"Mystery"),
(7,"Horror"),
(8,"Thriller"),
(9,"Paranormal"),
(10,"Historical fiction"),
(11,"Science Fiction"),
(12,"Children"),
(13,"Memoir"),
(14,"Cookbook"),
(15,"Art"),
(16,"Self-help"),
(17,"Personal Development"),
(18,"Motivational"),
(19,"Health"),
(20,"History"),
(21,"Travel"),
(22,"Guide"),
(23,"Families and Relationships"),
(24,"Humor"),
(25,"Anthropology"),
(26,"Astronomy"),
(27,"Biography"),
(28,"Business and Management"),
(29,"Communication and Media Theory"),
(30,"Crafts and Hobbies"),
(31,"Cultural Studies"),
(32,"Economics"),
(33,"Education"),
(34,"Essay"),
(35,"Family and Parenting"),
(36,"Film and Cinema Studies"),
(37,"Gender Studies"),
(38,"Gardening"),
(39,"Journalism"),
(40,"Linguistics"),
(41,"Literary Criticism"),
(42,"Mathematics"),
(43,"Media Studies"),
(44,"Music"),
(45,"Nature Writing"),
(46,"Philosophy"),
(47,"Philosophy of Science"),
(48,"Political Science"),
(49,"Psychology"),
(50,"Reference and Manuals"),
(51,"Religion and Spirituality"),
(52,"Science"),
(53,"Science Communication"),
(54,"Social Commentary"),
(55,"Sociology"),
(56,"Sports and Recreation"),
(57,"Technology and Computers"),
(58,"True Adventure"),
(59,"True Crime");