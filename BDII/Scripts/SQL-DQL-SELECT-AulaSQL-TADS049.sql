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
    coalesce(sum(fer.qtdDias), 0) "Total de Dias já Gozados"
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
    concat("R$ ",format(coalesce(vac.auxCreche, 0), 2, 'de_DE')) "Auxílio Creche",
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
		concat("R$ ",format(coalesce(vac.auxCreche, 0), 2, 'de_DE')) "Auxílio Creche",
		concat("R$ ",format(func.salario, 2, 'de_DE')) "Salário",
		dep.nome "Departamento"
		from funcionario func
		inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
		inner join cargo crg on crg.CBO = trb.Cargo_CBO
		inner join departamento dep on dep.idDepartamento = trb.Departamento_idDepartamento
		left join vauxcreche vac on vac.cpf = func.cpf
			where trb.dataFim is null
				order by func.nome;

update funcionario, 
	(select func.cpf from funcionario func
	inner join trabalhar trb on trb.Funcionario_CPF = func.cpf
	inner join cargo crg on crg.CBO = trb.Cargo_CBO
    where crg.nome like "Segurança%" or crg.nome like "Auxiliar%") as crgFunc
	set cargaHoraria = 36
		where funcionario.cpf = crgFunc.cpf;

-- Vale Alimentação: 15 valor de um reifeição, 22 dias úteis -- caso a ch for 36h a reição é dobrada
select upper(func.nome) "Funcionário", 
	replace(replace(func.cpf, '.', ''), '-', '') "CPF",
	func.chavePIX "Chave PIX",
    concat(func.cargaHoraria, 'h') "Carga Horária",
    case func.cargaHoraria when 36 then 22 * 15 * 2
		else 22 * 15
	end "Vale Alimentação"
	from funcionario func
		order by func.nome;

-- Auxílio Saúde: 180 (<25), 280(25>=  and <35), 380 (35>=  and <45), 480 (45>=  and <55) depois 600
select upper(func.nome) "Funcionário", 
	replace(replace(func.cpf, '.', ''), '-', '') "CPF",
	func.chavePIX "Chave PIX",
    concat(func.cargaHoraria, 'h') "Carga Horária",
    case func.cargaHoraria when 36 then 22 * 15 * 2
		else 22 * 15
	end "Vale Alimentação",
    case when timestampdiff(year, func.dataNasc, now()) < 25
			then 180
		when timestampdiff(year, func.dataNasc, now()) between 25 and 35
			then 280
		when timestampdiff(year, func.dataNasc, now()) between 35 and 45
			then 380
		when timestampdiff(year, func.dataNasc, now()) between 45 and 55
			then 480
		else 600
    end "Auxílio Saúde"
	from funcionario func
		order by func.nome;

select substr(dataInicio, 1, 7) "Ano - mês", count(idFerias) "Quantidade"
	from ferias
		group by substr(dataInicio, 1, 7)
		order by substr(dataInicio, 1, 7);

select substr(dataInicio, 6, 2) "Mês", count(idFerias) "Quantidade"
	from ferias
		group by substr(dataInicio, 6, 2)
		order by substr(dataInicio, 6, 2);

select substr(dataInicio, 6, 2) "Mês", count(idFerias) "Quantidade"
	from ferias
		group by substr(dataInicio, 6, 2)
		order by count(idFerias) desc
			limit 1;

select avg(salario) from funcionario;

select avg(salario), round(avg(salario), 2) from funcionario;

select avg(salario), round(avg(salario), 2), truncate(avg(salario), 2) from funcionario;

select sysdate(), adddate(sysdate(), interval -5 day);

-- https://dev.mysql.com/doc/refman/8.0/en/create-procedure.html
-- https://dev.mysql.com/doc/refman/8.0/en/if.html
delimiter $$
create function calcValeAlimentacao(ch int)
	returns decimal(5,2) deterministic
    begin
		if(ch = 36) then return 22 * 15 * 2;
			else return 22 * 15;
		end if;
    end $$
delimiter ;

delimiter $$
create function calcAuxSaude(dn date)
	returns decimal(5,2) deterministic
    begin
		declare idade int;
        select timestampdiff(year, dn, now()) into idade;
        if (idade < 25) then return 180;
			elseif (idade between 25 and 35) then return 280;
            elseif (idade between 35 and 45) then return 380;
            elseif (idade between 45 and 55) then return 480;
            else return 600;
		end if;
    end $$
delimiter ;

delimiter $$
create function calcValeTransporte(pcpf varchar(14))
	returns decimal(5,2) deterministic
    begin
		declare cid varchar(45);
        declare sal decimal(7,2);
        declare valorPassagem decimal(4,2) default 4.3;
        declare valeTrans decimal(5,2);
        
        select cidade into cid
			from endereco 
				where Funcionario_CPF = pcpf;
		
		select salario into sal
			from funcionario
				where cpf = pcpf;
                
		if(cid = "Recife")
			then set valeTrans = 22 * 2 * valorPassagem;
		else
			set valeTrans = 22 * 4 * valorPassagem;
		end if;
        
        set valeTrans = valeTrans - 0.06 * sal;
        
        if(valeTrans < 0) 
			then return 0;
		else 
			return valeTrans;
		end if;
    end $$
delimiter ;

SELECT * FROM pousadaalambique.vauxcreche;

delimiter $$
create function calcINSS(salario decimal(7,2))
	returns decimal(6,2) deterministic
    begin
		if(salario <= 1518)
			then return salario * 0.075;
		elseif(salario > 1518 and salario <= 2793.88)
			then return salario * 0.09;
		elseif(salario > 2793.88 and salario <= 4190.83)
			then return salario * 0.12;
		elseif (salario > 4190.83 and salario <= 8157.41)
			then return salario * 0.14;
		else return 8157.41 * 0.14;
		end if;
    end $$
delimiter ;

delimiter $$
create function calcIRRF(salario decimal(7,2))
	returns decimal(6,2) deterministic
    begin
		if(salario <= 2259.20)
			then return 0.0;
		elseif(salario > 2259.20 and salario <= 2826.65)
			then return salario * 0.075;
		elseif(salario > 2826.65 and salario <= 3751.05)
			then return salario * 0.15;
		elseif (salario > 3751.05 and salario <= 4664.68)
			then return salario * 0.225;
		else return salario * 0.275;
		end if;
    end $$
delimiter ;

select upper(func.nome) "Funcionário",
	replace(replace(func.cpf, '.', ''), '-', '') "CPF",
    func.chavePIX "Chave PIX",
    concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2 , 'de_DE')) 
		"Salário Bruto",
    concat("R$ ", format(calcValeAlimentacao(func.cargaHoraria), 2 , 'de_DE')) 
		"Vale Alimentação",
    concat("R$ ", format(calcAuxSaude(func.dataNasc), 2 , 'de_DE'))
		"Auxílio Saúde",
	concat("R$ ", format(calcValeTransporte(func.cpf), 2 , 'de_DE'))
		"Vale Transporte",
	concat("R$ ", format(coalesce(vac.auxcreche, 0), 2 , 'de_DE'))
		"Auxílio Creche",
	concat("-R$ ", format(calcINSS(func.salario), 2 , 'de_DE'))
		"INSS",
	concat("-R$ ", format(calcIRRF(func.salario), 2 , 'de_DE'))
		"IRRF",
    concat("R$ ", format(func.salario + calcValeAlimentacao(func.cargaHoraria) +
    calcAuxSaude(func.dataNasc) + calcValeTransporte(func.cpf) + 
    coalesce(vac.auxcreche, 0) - calcINSS(func.salario)
    - calcIRRF(func.salario), 2 , 'de_DE'))
        "Salário Líquido"
	from funcionario func
		left join vauxcreche vac on vac.cpf = func.cpf
		order by func.nome;

create view vRelFolhaSalarial as
	select upper(func.nome) "Funcionário",
	replace(replace(func.cpf, '.', ''), '-', '') "CPF",
    func.chavePIX "Chave PIX",
    concat(func.cargaHoraria, 'h') "Carga Horária",
    concat("R$ ", format(func.salario, 2 , 'de_DE')) 
		"Salário Bruto",
    concat("R$ ", format(calcValeAlimentacao(func.cargaHoraria), 2 , 'de_DE')) 
		"Vale Alimentação",
    concat("R$ ", format(calcAuxSaude(func.dataNasc), 2 , 'de_DE'))
		"Auxílio Saúde",
	concat("R$ ", format(calcValeTransporte(func.cpf), 2 , 'de_DE'))
		"Vale Transporte",
	concat("R$ ", format(coalesce(vac.auxcreche, 0), 2 , 'de_DE'))
		"Auxílio Creche",
	concat("-R$ ", format(calcINSS(func.salario), 2 , 'de_DE'))
		"INSS",
	concat("-R$ ", format(calcIRRF(func.salario), 2 , 'de_DE'))
		"IRRF",
    concat("R$ ", format(func.salario + calcValeAlimentacao(func.cargaHoraria) +
    calcAuxSaude(func.dataNasc) + calcValeTransporte(func.cpf) + 
    coalesce(vac.auxcreche, 0) - calcINSS(func.salario)
    - calcIRRF(func.salario), 2 , 'de_DE'))
        "Salário Líquido"
	from funcionario func
		left join vauxcreche vac on vac.cpf = func.cpf
		order by func.nome;
        
delimiter $$
create procedure cadFuncionario(in pCPF varchar(14),
								in pnome varchar(60),
								in pnomeSocial varchar(45),
								in pdataNasc date,
								in pgenero varchar(25),
								in pestadoCivil varchar(25),
								in pemail varchar(80),
								in pcarteiraTrab varchar(45),
								in pcargaHoraria int,
								in psalario decimal(7,2),
								in pchavePIX varchar(45),
                                in pUF char(2),
								in pcidade varchar(45),
								in pbairro varchar(45),
								in prua varchar(45),
								in pnumero int,
								in pcomp varchar(45),
								in pcep varchar(9),
                                in ptelefone1 varchar(15),
                                in ptelefone2 varchar(15),
                                in ptelefone3 varchar(15))
	begin
		insert into funcionario
			value (pCPF, pnome, pnomeSocial, pdataNasc, pgenero, 
            pestadoCivil, pemail, pcarteiraTrab, pcargaHoraria, psalario, 
            pchavePIX, 1, 0.0);
		insert into endereco
			value (pCPF, pUF, pcidade, pbairro, prua, pnumero, pcomp, pcep);
		insert into telefone (numero, Funcionario_CPF)
			value (ptelefone1, pCPF);
		if(ptelefone2 is not null)
			then insert into telefone (numero, Funcionario_CPF)
					value (ptelefone2, pCPF);
		end if;
		if(ptelefone3 is not null)
			then insert into telefone (numero, Funcionario_CPF)
					value (ptelefone3, pCPF);
		end if;
    end $$
delimiter ;

desc endereco;

call cadFuncionario("098.980.890-89", "Marcelly Arcanjo", null, '2000-06-06',
	"Feminino", "Casada", "marcelly.arcanjo@gmail.com", "3214320-11",
    36, 3100, "marcelly.arcanjo@gmail.com", "PE", "Recife", "Macaxeira",
    "Rua Dr. Luis Soares", 132, null, '50760-060', "8198765-4312", 
    "8178786556", null);

select * from funcionario order by nome;

select * from endereco;

select * from telefone;

insert into reserva (dataInicio, dataFim, qtdPessoas, `status`, Funcionario_CPF,
	Responsavel_docIdentificacao)
	values ('2025-11-10', '2025-11-14', 2, 'Confirmada', "134.411.311-44",
			"77.666.777-6 CE"),
            ('2025-11-10', '2025-11-14', 2, 'Confirmada', "108.801.888-11",
			"88.777.888-7 SC"),
            ('2025-11-10', '2025-11-14', 3, 'Confirmada', "134.411.311-44",
			"44.333.444-3 RJ"),
            ('2025-11-12', '2025-11-16', 2, 'Confirmada', "108.801.888-11",
			"PAS-CA123123"),
            ('2025-11-12', '2025-11-16', 4, 'Confirmada', "108.801.888-11",
			"PAS-CN654987"),
            ('2025-11-12', '2025-11-16', 6, 'Confirmada', "108.801.888-11",
			"40.404.040-4 RJ");
            
insert into UH_Reserva
	values (40, 319), (41, 320), (42, 321), (43, 322), (44, 323), (45, 324);

-- Proceduro de Check-In FODAAAAAA!!!
delimiter $$
create procedure realizarCheckIn(in pIdReserva int,
						in pdocIdentificacao varchar(25),
						in pnome varchar(45),
						in pgenero varchar(25),
						in pdataNasc date,
						in ptelefone varchar(15),
						in pemail varchar(45),
                        in pResponsavel_docIdentificacao varchar(25))
	begin
		declare auxIdHospedagem int default 0;
        declare ResponsavelReserva varchar(25);
        
        select Reserva_idReserva into auxIdHospedagem 
			from hospedagem
				where Reserva_idReserva = pIdReserva;
                
		update reserva
			set `status` = "Check-In"
				where idReserva = pIdReserva;
    
		if(auxIdHospedagem = 0) 
			then insert into hospedagem
					value (pIdReserva, now(), null, 0.0);
		end if;
            
		insert into hospede
			value(pdocIdentificacao, pnome, pgenero, pdataNasc, ptelefone, 
				pemail, pResponsavel_docIdentificacao);
                
		insert into hospedar
			value(pIdReserva, pdocIdentificacao);
            
		select Responsavel_docIdentificacao into ResponsavelReserva
			from reserva
				where idReserva = pIdReserva;
            
		if(auxIdHospedagem = 0)
			then insert into hospedar
					value(pIdReserva, ResponsavelReserva);
		end if;
	end $$
delimiter ;

call realizarCheckIn(324, "052.250.520-52", "Lucas Silva", "Masculino", 
	'1999-11-10', "81984585884", "lucas.silva99@gmail.com", null);

call realizarCheckIn(324, "053.230.530-53", "Maria Silva", "Feminina", 
	'1999-11-12', "81984585588", "maria.silva99@gmail.com", null);










