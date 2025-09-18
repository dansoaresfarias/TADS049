-- SQL - DQL - Select - TADS049
select * from funcionario;

select nome, cpf, carteiraTrab , genero, estadoCivil,
	dataNasc, email, cargaHoraria, salario
		from funcionario;
        
select nome, cpf, carteiraTrab , genero, estadoCivil,
	dataNasc, email, cargaHoraria, salario
		from funcionario
			order by nome;

select nome, cpf, carteiraTrab , genero, estadoCivil,
	dataNasc, email, cargaHoraria, salario
		from funcionario
			order by salario desc;

update funcionario
	set salario = salario * 1.25
		where genero = "Feminino";
        
select nome, cpf, carteiraTrab , genero, estadoCivil,
	dataNasc, email, cargaHoraria, salario
		from funcionario
			where estadoCivil = "Casado"
				order by nome;

select nome, cpf, carteiraTrab , genero, estadoCivil,
	dataNasc, email, cargaHoraria, salario
		from funcionario
			where estadoCivil = "Casado" or
				estadoCivil = "Casada"
				order by nome;
                
select nome, cpf, carteiraTrab , genero, estadoCivil,
	dataNasc, email, cargaHoraria, salario
		from funcionario
			where estadoCivil like "Casad_"
				order by nome;
                
select nome, cpf, carteiraTrab , genero, estadoCivil,
	dataNasc, email, cargaHoraria, salario
		from funcionario
			where estadoCivil like "Casad%"
				order by nome;
                
select nome, cpf, carteiraTrab , genero, estadoCivil,
	dataNasc, email, cargaHoraria, salario
		from funcionario
			where nome like "%Sou_a"
				order by nome;
                
select nome, cpf, carteiraTrab , genero, estadoCivil,
	dataNasc, email, cargaHoraria, salario
		from funcionario
			where nome like "%Lu__ %"
				order by nome;
                
select nome, cpf, carteiraTrab , genero, estadoCivil,
	dataNasc, email, cargaHoraria, salario
		from funcionario
			where salario between 2500 and 3500
				order by nome;
                
select nome, cpf, carteiraTrab , genero, estadoCivil,
	dataNasc, email, cargaHoraria, salario
		from funcionario
			where salario > 3000
				and genero = "Feminino"
				order by nome;
                
select nome "Funcionário", cpf "CPF", 
	carteiraTrab "Carteira de Trabalho", 
    genero "Gênero", estadoCivil "Estado Civil",
	dataNasc as "Data de Nascimento", email "E-mail", 
    cargaHoraria "Carga Horária", salario "Salário"
		from funcionario
			order by nome;
            
-- https://dev.mysql.com/doc/refman/8.4/en/string-functions.html#function_upper
-- https://dev.mysql.com/doc/refman/8.4/en/string-functions.html#function_replace
-- https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html#function_date-format
-- https://dev.mysql.com/doc/refman/8.4/en/string-functions.html#function_concat
-- https://dev.mysql.com/doc/refman/8.4/en/string-functions.html#function_format
select upper(nome) "Funcionário", 
	replace(replace(cpf, '.', ''), '-', '') "CPF", 
	carteiraTrab "Carteira de Trabalho", 
    ucase(genero) "Gênero", upper(estadoCivil) "Estado Civil",
	date_format(dataNasc, '%d/%m/%Y') as "Data de Nascimento", 
    email "E-mail", concat(cargaHoraria, 'h') "Carga Horária", 
    format(salario, 2, 'de_DE') "Salário"
		from funcionario
			order by nome;  
            
select upper(nome) "Funcionário", 
	replace(replace(cpf, '.', ''), '-', '') "CPF", 
	carteiraTrab "Carteira de Trabalho", 
    ucase(genero) "Gênero", upper(estadoCivil) "Estado Civil",
	date_format(dataNasc, '%d/%m/%Y') as "Data de Nascimento", 
    email "E-mail", concat(cargaHoraria, 'h') "Carga Horária", 
    format(salario, 2, 'de_DE') "Salário",
    cidade "Cidade"
		from funcionario, endereco
			where cpf = funcionario_cpf
				order by nome; 
            
 select upper(f.nome) "Funcionário", 
	replace(replace(f.cpf, '.', ''), '-', '') "CPF", 
	f.carteiraTrab "Carteira de Trabalho", 
    ucase(f.genero) "Gênero", upper(f.estadoCivil) "Estado Civil",
	date_format(f.dataNasc, '%d/%m/%Y') as "Data de Nascimento", 
    f.email "E-mail", t.numero "Telefone",
    concat(f.cargaHoraria, 'h') "Carga Horária", 
    format(f.salario, 2, 'de_DE') "Salário",
    e.cidade "Cidade"
		from funcionario f
		inner join endereco e on f.cpf = e.funcionario_cpf
        inner join telefone t on f.cpf = t.funcionario_cpf
				order by f.nome; 




            