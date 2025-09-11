-- DDL - DROP - TADS049

drop table dependente;

drop table ferias;

drop database pousasaofrancisco;

-- DDL - ALTER - TADS049

alter table dependente
	add column RG varchar(20);

desc dependente;

alter table dependente 
	change column RG RG varchar(15) not null unique;

alter table dependente
	change column RG RG varchar(15) not null unique
		after nome;

