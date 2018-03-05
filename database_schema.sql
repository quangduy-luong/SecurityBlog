drop database if exists cs166;
create database cs166;
use cs166;
drop table if exists users;
create table users(
	email varchar(40) not null,
    pass char(128) not null,
    salt char(64) not null,
    first_name varchar(40) not null,
    last_name varchar(40) not null,
    admin bit not null,
    primary key (email)
);
drop table if exists blogs;
create table blogs(
	blog_id int not null auto_increment,
    blog_title varchar(40) not null,
    blog_body text not null,
    blog_date date not null,
    blog_author varchar(40) not null,
    primary key (blog_id),
    foreign key (blog_author) references users(email) on delete cascade
);