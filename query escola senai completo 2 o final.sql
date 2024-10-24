CREATE DATABASE escolaSenai;

USE escolaSenai;

-- Criar tabela campus
CREATE TABLE tb_campus(
 cod_campus INT AUTO_INCREMENT PRIMARY KEY,
 cidade VARCHAR(10),
 endereco VARCHAR(40)
);

-- Criar tabela curso
CREATE TABLE tb_curso(
 cod_curso INT AUTO_INCREMENT PRIMARY KEY,
 nome_cur VARCHAR(50) NOT NULL,
 turno VARCHAR(15),
 duracao INT,
 valor DECIMAL (6,2),
 id_campus INT,
 FOREIGN KEY(id_campus) REFERENCES tb_campus(cod_campus)
);

-- Criar tabela aluno
CREATE TABLE tb_aluno(
 ra_aluno INT AUTO_INCREMENT PRIMARY KEY,
 nome_aluno VARCHAR (30),
 dt_nasc DATE,
 cpf VARCHAR(13),
 sexo enum('F','M')
);

-- Criar a tabela matrícula
CREATE TABLE tb_matricula(
 cod_mat INT AUTO_INCREMENT PRIMARY KEY,
 dt_mat DATE,
 ra_alu INT,
 cod_cur INT,
 FOREIGN KEY (ra_alu) REFERENCES tb_aluno(ra_aluno),
 FOREIGN KEY (cod_cur) REFERENCES tb_curso(cod_curso)
);


-- SELECTs
SELECT * FROM tb_campus;
SELECT * FROM tb_curso;
SELECT * FROM tb_aluno;
SELECT * FROM tb_matricula;

-- Lista de todos os cursos do campus de Vitória
SELECT cur.nome_cur, cam.cidade FROM tb_curso as cur
JOIN tb_campus as cam
ON cur.id_campus = cam.cod_campus
WHERE cam.cidade = "Vitória";

-- Lista de todos os cursos em ordem Alfabética
SELECT cur.nome_cur FROM tb_curso as cur
ORDER BY cur.nome_cur ASC;

-- Quais os 5 cursos mais caros?
SELECT cur.nome_cur, cur.valor  FROM tb_curso as cur
ORDER BY cur.valor DESC
LIMIT 5;

-- Qual curso é o mais barato no Campus da Serra?
SELECT cur.nome_cur, cam.cidade, cur.valor FROM tb_curso as cur
JOIN tb_campus as cam
ON cur.id_campus = cam.cod_campus
WHERE cam.cidade = "Serra"
ORDER BY cur.valor ASC
LIMIT 1;

-- Qual o turno com mais cursos disponíveis?
SELECT nome_cur, turno, count(turno) FROM tb_curso
GROUP BY turno
ORDER BY count(turno) DESC
LIMIT 2;

-- Quantos cursos duram mais de dois anos e meio?
SELECT duracao, count(duracao) FROM tb_curso
WHERE duracao > 5;

-- Quais os cursos com maior quantidade de alunos inscritos?
SELECT cur.nome_cur, mat.cod_cur,count(mat.cod_cur) as contagem 
FROM tb_curso as cur
JOIN tb_matricula as mat
ON cur.cod_curso = mat.cod_cur
GROUP BY mat.cod_cur
ORDER BY contagem DESC
LIMIT 5;

-- Qual a média de preço dos cursos listados?
SELECT AVG(valor) as mediaPreco FROM tb_curso;

-- Quais cursos duram mais tempo
SELECT nome_cur, duracao FROM tb_curso
WHERE duracao = (SELECT max(duracao) FROM tb_curso);

-- Quantos alunos estão matriculados em cada turno?
SELECT turno, count(turno) FROM tb_curso as curso
JOIN tb_matricula as mat
ON curso.cod_curso = mat.cod_cur
GROUP BY turno;

-- Qual o campus com mais cursos?
SELECT cidade, count(cidade) FROM tb_campus
JOIN tb_curso 
on tb_campus.cod_campus = tb_curso.id_campus
GROUP BY cidade
ORDER BY count(cidade) DESC
LIMIT 1;

-- Quais cursos não possuem alunos cadastrados?
SELECT mat.cod_mat, nome_cur FROM tb_matricula as mat
RIGHT JOIN tb_curso as cs
ON mat.cod_cur = cs.cod_curso
WHERE mat.cod_mat IS NULL;

-- Quem se matriculou em 2021?
SELECT nome_aluno, dt_mat FROM tb_aluno as alu
JOIN tb_matricula as mat
ON alu.ra_aluno = mat.ra_alu
WHERE dt_mat LIKE "2021%";

-- Qual a data de matrícula da aluna “Fernanda Lima”?
SELECT nome_aluno, dt_mat FROM tb_aluno as alu
JOIN tb_matricula as mat
ON alu.ra_aluno = mat.ra_alu
WHERE nome_aluno LIKE "Fernanda Lima";

-- Quais alunos não se cadastraram em nenhum curso?
SELECT cod_mat, nome_aluno 
FROM tb_aluno as alu
LEFT JOIN tb_matricula as mat
ON alu.ra_aluno = mat.ra_alu
WHERE mat.cod_mat IS NULL;

-- Quantas alunas matriculadas até o momento?
SELECT count(DISTINCT ra_alu) "Total alunas"
FROM tb_aluno as alu
LEFT JOIN tb_matricula as mat
ON alu.ra_aluno = mat.ra_alu
WHERE sexo = 'F';

-- Quais alunos estão matriculados 3 cursos?
SELECT nome_aluno, count(nome_aluno) as contagem
FROM tb_aluno as alu
LEFT JOIN tb_matricula as mat
ON alu.ra_aluno = mat.ra_alu
GROUP BY nome_aluno
HAVING contagem = 3;

-- Qual o curso do aluno “Guilherme Costa”?
SELECT * FROM tresTabelas
WHERE nome_aluno = "Guilherme Costa";

-- Quais os alunos matriculados em “Ciência da computação”
SELECT * FROM tresTabelas
WHERE nome_cur = "Ciência da computação";

-- Relação completa de todos os alunos e seus cursos
CREATE OR REPLACE VIEW tresTabelas as
SELECT nome_aluno, nome_cur FROM tb_aluno as alu
JOIN tb_matricula as mat
ON alu.ra_aluno = mat.ra_alu
JOIN tb_curso as cs
ON mat.cod_cur = cs.cod_curso;

SELECT * FROM tresTabelas;
