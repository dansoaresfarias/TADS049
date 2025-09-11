-- SQL - DML - Insert -TADS049

insert into funcionario (CPF, nome, dataNasc, genero, estadoCivil,
	email, carteiraTrab, cargaHoraria, salario, chavePIX, `status`)
    value ("123.321.111-33", "Jai Santos", '2001-09-11', "Masculino",
    "Solteiro", "jai.santos@gmail.com", "736598-09", 40, 2500, 
    "jai.santos@gmail.com", 1);
    
insert into funcionario (CPF, nome, dataNasc, genero, estadoCivil,
	email, carteiraTrab, cargaHoraria, salario, chavePIX, `status`)
    values ("222.444.666-88", "Vanda Vitório", '2005-10-10', "Feminino",
    "Viuva", "vanda.vitorio@gmail.com", "34567-09", 40, 1950, 
    "222.444.666-88", 1),
    ("222.321.111-30", "Ruth Camile", '1988-10-12', "Feminina",
    "Casada", "ruth.que.nao.e.raquel@gmail.com", "123598-09", 40, 2000, 
    "222.321.111-30", 1),
    ("333.333.111-33", "Beatriz Almeida", '2006-10-28', "Feminino",
    "Solteira", "beatriz.almeida@gmail.com", "333598-09", 30, 3000, 
    "beatriz.almeida@gmail.com", 1);
    
insert into endereco 
	values ("123.321.111-33", "PE", "Recife", "Santo Amaro", 
	"Rua do pombal", 102, "Ap 303", "50060-080");

insert into endereco 
	values ("222.444.666-88", "PE", "Olinda", "Bairro Novo", 
	"Rua Joaquim Amaro", 88, null, "50189-080"),
    ("222.321.111-30", "PE", "Recife", "Campo Grande", 
	"Rua direita", 120, "Ap 101", "50080-080"),
    ("333.333.111-33", "PE", "Recife", "Imbiribeira", 
	"Rua do Alphavile", 1000, "Ap 2203", "50080-010");

