drop table markT;

select* from marksT;

create table markst (
cm1 int,
cm2 int,
cm3 as (cm1*cm2) persisted not null constraint pk_cm3 primary key (cm3));

insert into markst values
(13,3),
(23,3),
(33,3),
(12,3),
(53,3),
(63,3),
(73,3),
(83,3),
(93,3),
(0,3),
(14,3);