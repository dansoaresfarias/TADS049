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
                    
select func.cpf "CPF", func.nome "Funcionário", 
	count(fer.idferias) "Quantas Férias",
    sum(fer.qtdDias) "Total de Dias já Gozados"
		from funcionario func
        left join ferias fer on fer.Funcionario_CPF = func.cpf
			group by func.cpf
				order by func.nome;
	
select dep.nome "Departamento", count(trb.Funcionario_CPF) "Qtd Funcionários"
	from trabalhar trb
    inner join departamento dep on trb.Departamento_idDepartamento = dep.idDepartamento
		where trb.dataFim is null
			group by trb.Departamento_idDepartamento
				order by dep.nome;

select dep.nome "Departamento", count(trb.Funcionario_CPF) "Qtd Funcionários",
	concat("R$ ",format(sum(func.salario), 2, 'de_DE')) "Total Folha Salarial",
    concat("R$ ",format(avg(func.salario), 2, 'de_DE')) "Média Salarial"
	from trabalhar trb
    inner join departamento dep on trb.Departamento_idDepartamento = dep.idDepartamento
    inner join funcionario func on trb.Funcionario_CPF = func.CPF
		where trb.dataFim is null
			group by trb.Departamento_idDepartamento
				order by sum(func.salario) desc;

select func.nome "Funcionário", func.cpf "CPF", func.chavePIX "Chave PIX", 
	concat(func.cargaHoraria, 'h') "Carga Horária",
    crg.nome "Cargo",
    concat("R$ ",format(func.salario, 2, 'de_DE')) "Salário",
    dep.nome "Departamento"
    from funcionario func
    inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
    inner join cargo crg on crg.CBO = trb.Cargo_CBO
    inner join departamento dep on dep.idDepartamento = trb.Departamento_idDepartamento
		where trb.dataFim is null
			order by func.nome;

select avg(salario) from funcionario;

select func.nome "Funcionário", func.cpf "CPF", func.chavePIX "Chave PIX", 
	concat(func.cargaHoraria, 'h') "Carga Horária",
    crg.nome "Cargo",
    concat("R$ ",format(func.salario, 2, 'de_DE')) "Salário",
    dep.nome "Departamento"
    from funcionario func
    inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
    inner join cargo crg on crg.CBO = trb.Cargo_CBO
    inner join departamento dep on dep.idDepartamento = trb.Departamento_idDepartamento
		where trb.dataFim is null and
			func.salario >= (select avg(salario) from funcionario)
			order by func.nome;

create view relFuncionario as 
	select func.nome "Funcionário", func.cpf "CPF", func.chavePIX "Chave PIX", 
		concat(func.cargaHoraria, 'h') "Carga Horária",
		crg.nome "Cargo",
		concat("R$ ",format(func.salario, 2, 'de_DE')) "Salário",
		dep.nome "Departamento"
		from funcionario func
		inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
		inner join cargo crg on crg.CBO = trb.Cargo_CBO
		inner join departamento dep on dep.idDepartamento = trb.Departamento_idDepartamento
			where trb.dataFim is null
				order by func.nome;

select * from relfuncionario;

select func.nome "Funcionário", func.cpf "CPF", func.chavePIX "Chave PIX", 
	concat(func.cargaHoraria, 'h') "Carga Horária",
    crg.nome "Cargo",
    count(dpd.CPF) "Qtd Filhos",
    concat("R$ ",format(func.salario, 2, 'de_DE')) "Salário",
    dep.nome "Departamento"
    from funcionario func
    inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
    inner join cargo crg on crg.CBO = trb.Cargo_CBO
    inner join departamento dep on dep.idDepartamento = trb.Departamento_idDepartamento
    left join dependente dpd on dpd.Funcionario_CPF = func.cpf
		where trb.dataFim is null
			group by func.cpf
				order by func.nome;

select func.cpf "cpf", count(dep.cpf) * 180 "auxCreche"
	from funcionario func
	left join dependente dep on dep.Funcionario_CPF = func.cpf
		where timestampdiff(year, dep.dataNasc, now()) < 7
		group by func.cpf;

create view vAuxCreche as
	select func.cpf "cpf", count(dep.cpf) * 180 "auxCreche"
		from funcionario func
		left join dependente dep on dep.Funcionario_CPF = func.cpf
			where timestampdiff(year, dep.dataNasc, now()) < 7
			group by func.cpf;

select func.nome "Funcionário", func.cpf "CPF", func.chavePIX "Chave PIX", 
	concat(func.cargaHoraria, 'h') "Carga Horária",
    crg.nome "Cargo",
    concat("R$ ",format(vac.auxCreche, 2, 'de_DE')) "Auxílio Creche",
    concat("R$ ",format(func.salario, 2, 'de_DE')) "Salário",
    dep.nome "Departamento"
    from funcionario func
    inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
    inner join cargo crg on crg.CBO = trb.Cargo_CBO
    inner join departamento dep on dep.idDepartamento = trb.Departamento_idDepartamento
    left join vauxcreche vac on vac.cpf = func.cpf
		where trb.dataFim is null
			order by func.nome;

create view relPagamento as 
	select func.nome "Funcionário", func.cpf "CPF", func.chavePIX "Chave PIX", 
		concat(func.cargaHoraria, 'h') "Carga Horária",
		crg.nome "Cargo",
		concat("R$ ",format(vac.auxCreche, 2, 'de_DE')) "Auxílio Creche",
		concat("R$ ",format(func.salario, 2, 'de_DE')) "Salário",
		dep.nome "Departamento"
		from funcionario func
		inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
		inner join cargo crg on crg.CBO = trb.Cargo_CBO
		inner join departamento dep on dep.idDepartamento = trb.Departamento_idDepartamento
		left join vauxcreche vac on vac.cpf = func.cpf
			where trb.dataFim is null
				order by func.nome;





