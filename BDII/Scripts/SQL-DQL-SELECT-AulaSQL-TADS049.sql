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
                
-- https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html#function_group-concat            
select upper(f.nome) "Funcionário", 
	replace(replace(f.cpf, '.', ''), '-', '') "CPF", 
	f.carteiraTrab "Carteira de Trabalho", 
    ucase(f.genero) "Gênero", upper(f.estadoCivil) "Estado Civil",
	date_format(f.dataNasc, '%d/%m/%Y') as "Data de Nascimento", 
    f.email "E-mail", group_concat(t.numero separator ", ") "Telefone",
    concat(f.cargaHoraria, 'h') "Carga Horária", 
    format(f.salario, 2, 'de_DE') "Salário",
    e.cidade "Cidade"
		from funcionario f
		inner join endereco e on f.cpf = e.funcionario_cpf
        inner join telefone t on f.cpf = t.funcionario_cpf
			group by f.cpf
				order by f.nome; 

-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_timestampdiff
-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_now
-- Nome Dep, CPF Dep, Idade, Parentesco, Funcionairo, CPF
select func.nome "Funcionário", func.cpf "CPF do Funcionário",
	dep.nome "Dependente", dep.cpf "CPF do Dependente",
	timestampdiff(year, dep.dataNasc, now()) "Idade", 
    ucase(dep.parentesco) "Parentesco"       
	from dependente dep
		inner join funcionario func on func.cpf = dep.funcionario_cpf
			order by func.nome, dep.nome;
            
-- Relatório de Ocorrências Internas
-- Data da Ocorrência (18/09/2025 - 08:00)
-- Funcionário
-- Gravidade da Ocorrência (ALTA)
-- Descrição
-- * Ordenados pela Data da ocorrência e pelo nome do funcionário
select date_format(oi.dataHora, '%d/%m/%Y - %h:%i') "Data da Ocorrência",
	func.nome "Funcionário",
    upper(oi.gravidade) "Gravidade da Ocorrência",
    oi.descricao "Descrição"
	from OcorrenciaInterna oi 
		inner join Funcionario func on func.cpf = oi.funcionario_cpf
			order by oi.dataHora desc, func.nome;

select func.nome "Funcionário", func.cpf "CPF",
	count(oi.idOcorrenciaInterna) "Quantidade de Ocorrências ALTAS"
	from funcionario func
		left join ocorrenciaInterna oi on oi.funcionario_cpf = func.cpf
			where oi.gravidade = "Alta"
				group by func.cpf
					order by func.nome;

select func.nome "Funcionário", func.cpf "CPF",
	count(dep.cpf) "Quantidade de Dependentes"
	from funcionario func
		left join dependente dep on dep.funcionario_cpf = func.cpf
			group by func.cpf
					order by func.nome;
                    
select func.nome "Funcionário", func.cpf "CPF",
	count(dep.cpf) "Quantidade de Dependentes"
	from funcionario func
		inner join dependente dep on dep.funcionario_cpf = func.cpf
			group by func.cpf
					order by func.nome;







            