--criação ta tabela usuarios
CREATE TABLE usuarios_table(
    id_usuario SERIAL PRIMARY KEY ,
    nome character varying(120) NOT NULL,
	email varchar(80) UNIQUE,
    tipo_usuario character varying(80) NOT NULL,
    data_cadastro date NOT NULL
);

--criação da tabela atividades
CREATE TABLE atividades_table(
    id_atividade SERIAL PRIMARY KEY,
    usuario_id int NOT NULL,
    tipo_atividade character varying(120) NOT NULL,
    distancia_km numeric(10,2) NOT NULL,
    duracap_min numeric (10,2) NOT NULL,
    data_atividade date NOT NULL,
    descricao character varying(120) NOT NULL,
	CONSTRAINT fk_usuario_id foreign key(usuario_id) references usuarios_table(id_usuario)
);

--inserindos os dados na tabela usuario
INSERT INTO usuarios_table(id_usuario, nome, email, tipo_usuario,data_cadastro)
VALUES
(1, 'Carlos Eduardo Silva', 'carlos.siva@saepsaude.com.br', 'funcionario', '2026-01-10'),
(2, 'Mariana Oliveira Santos', 'mariana.oiveira@saepsaude.com.br', 'funcionario', '2026-01-12'),
(3, 'Roberto Souza Lima', 'roberto.souza@saepsaude.com.br', 'funcionario', '2026-01-15'),
(4, 'Fernanda Costa Pereira', 'fernanda.costa@saepsaude.com.br', 'funcionario', '2026-01-20'),
(5, 'Lucas Mendes Rocha', 'lucas.mendes@saepsaude.com.br', 'funcionario', '2026-01-22'),
(6, 'Camila Rodrigues Alves', 'camila.rodrigues@gmail.com', 'cliente', '2026-02-01'),
(7, 'Gabriel Martins Barbosa', 'gabriel.martins@outlook.com', 'cliente', '2026-02-02'),
(8, 'Beatriz Almeida Carvalho', 'beatriz.almeida@yahoo.com.br', 'cliente', '2026-02-03'),
(9, 'Thiago Ferreira Ramos', 'thiago.ramos@gmail.com', 'cliente', '2026-02-05'),
(10, 'Juliana Ribeiro Castro', 'juliana.castro@hotmail.com', 'cliente', '2026-02-06'),
(11, 'Rafael Gomes Araujo', 'rafael.gomes@gmail.com', 'cliente', '2026-02-07'),
(12, 'Patricia Cardoso Dias', 'patricia.dias@outloook.com', 'cliente', '2026-02-08'),
(13, 'Rodrigo Fernandes Melo', 'rodrigo.melo@gmail.com', 'cliente', '2026-02-10'),
(14, 'Aline Correia Azevedo', 'aline.azevedo@yahoo.com.br', 'cliente', '2026-02-11'),
(15, 'Bruno Nunes Marques', 'bruno.marques@gmail.com', 'cliente', '2026-02-12'),
(16, 'Vanessa Texeia Cavalcanti', 'vanessa.texeira@outlook.com', 'cliente', '2026-02-14'),
(17, 'Diego Monteiro Barros', 'diego.barros@gmail.com', 'cliente', '2026-02-15'),
(18, 'Amanda Moreira Guimaraes', 'amanda.guimaraes@hotmail.com', 'cliente', '2026-02-16'),
(19, 'Leonardo Pinho Cunha', 'leonardo.cunha@gmail.com', 'cliente', '2026-02-18'),
(20, 'Leticia Moura Freitas', 'leticia.freitas@outlook.com', 'cliente', '2026-02-20');

--inserindo os dados na tabela atividades
INSERT INTO atividades_table(id_atividade,usuario_id ,tipo_atividade ,distancia_km , duracap_min, data_atividade, descricao)
VALUES
(1,1,'corrida', 5.20,30,'2026-02-02', 'corrida matinal na praça central'),
(2,2,'ciclismo', 18.50,55,'2026-02-01', 'pedalada na ciclovia a beira-mar'),
(3,1, 'caminhada', 3.10, 35, '2026-02-02','caminhada leve pós-expediente'),
(4,3, 'natação', 1.50, 45, '2026-02-03', 'treino de nado livre na piscina club'),
(5,4, 'musculação', 0.00, 60, '2026-02-03', 'treino A- membros inferiores'),
(6,5, 'corrida', 8.00,48,'2026-02-04', 'treino de tiro e ritimo acelerado'),
(7,6, 'corrida', 4.00, 28, '2026-02-05','primeira corrida utlizando a plataforma'),
(8,7, 'ciclismo', 25.00, 75, '2026-02-05', 'pedal longo de final de tarde'),
(9,8, 'caminhada', 5.00, 50, '2026-02-06', 'caminhada no parque da cidade'),
(10,9, 'futebol', 0.00 , 90, '2026-02-06', 'partida semanal com os amigos'),
(11,10, 'musculação', 0.00, 50, '2026-02-07', 'treino B- superiores e core'),
(12,2, 'corrida', 6.50, 38, '2026-02-08', 'corrida de rua ritmada'),
(13,11, 'natação', 2.00, 50, '2026-02-08', 'treino de resistência e borboleta'),
(14,12, 'ciclismo', 12.30, 40, '2026-02-09', 'deslocamento urbano bicicleta'),
(15,13, 'corrida', 10.00, 58, '2026-02-10', 'preparata rio para prova de 10K'),
(16, 14, 'caminhada',4.20, 42, '2026-02-11', 'caminhada ao ar livre'),
(17,15, 'musulação', 0.00, 65, '2026-02-12', 'treino de hipertrofia'),
(18,16,'corrida', 3.00, 20, '2026-02-14', 'corrida rápida de aquecimento'),
(19,17, 'ciclismo', 30.00, 90, '2026-02-15', 'pedal de longa distância na estrada'),
(20,18, 'natação', 1.20, 40, '2026-02-16', 'treino tecnico de braçadas');

--criação da tabela curtidas
CREATE TABLE curtidas (
    id_curtidas SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    atividades_id INTEGER NOT NULL,
    data_curtida DATE DEFAULT CURRENT_DATE,
CONSTRAINT fk_usuario_curtidas FOREIGN KEY (usuario_id) REFERENCES usuarios_table(id_usuario),
CONSTRAINT fk_atividade FOREIGN KEY (atividades_id) REFERENCES atividades_table(id_atividade)
);

--criação da tabela comentarios
CREATE TABLE comentarios(
	id_comentario serial primary key,
	usuario_id integer not null,
	atividade_id integer not null,
	data_comentario date default current_date,
	texto varchar(200) not null, 
	CONSTRAINT fk_comentario FOREIGN KEY (usuario_id) REFERENCES usuarios_table(id_usuario),
	CONSTRAINT fk_atividade FOREIGN KEY (atividade_id) REFERENCES atividades_table(id_atividade)
);

--visualização das tabelas
select*from atividades_table;
select*from usuarios_table;

ALTER TABLE atividades_table
ALTER COLUMN data_atividade TYPE TIMESTAMP;
