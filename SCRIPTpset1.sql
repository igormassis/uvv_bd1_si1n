--Esse comando apaga o banco de dados--
drop database if exists uvv;

--Esse comando apaga o usuário "igor" se ele existir--
drop user if exists igor;

--Esse comando apaga o schema "lojas" se existir--
drop schema if exists lojas cascade;

--Esse comando cria o usuário e senha--
create user igor with password 'cerato08';

--Esse comando cria o banco de dados--
CREATE DATABASE uvv
with 	owner igor
		template template0
		encoding 'UTF8'
		lc_collate 'pt_BR.UTF-8'
		lc_ctype 'pt_BR.utf-8'
		allow_connections true;

\c 'dbname=uvv user=igor password=cerato08'

--ESSE COMANDO CRIA O ESQUEMA--
CREATE SCHEMA lojas AUTHORIZATION igor;

ALTER USER igor SET search_path TO lojas, "$user", public;

SET search_path TO lojas, "$user", public;

CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE clientes IS 'Tabela que registra as informações dos clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'Coluna que registra a ID dos clientes e é a Primary Key da tabela';
COMMENT ON COLUMN clientes.email IS 'Coluna que registra o email dos clientes';
COMMENT ON COLUMN clientes.nome IS 'Coluna que registra o nome do cliente';
COMMENT ON COLUMN clientes.telefone1 IS 'Coluna que registra o primeiro telefone do cliente';
COMMENT ON COLUMN clientes.telefone2 IS 'Coluna que registra o segundo telefone do cliente';
COMMENT ON COLUMN clientes.telefone3 IS 'Coluna que registra o terceiro telefone do cliente';


CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas IS 'Tabela que armazena os dados das lojas';
COMMENT ON COLUMN lojas.loja_id IS 'Coluna que registra a id da loja e é a Primary Key da tabela';
COMMENT ON COLUMN lojas.nome IS 'Coluna que registra o nome da loja';
COMMENT ON COLUMN lojas.endereco_web IS 'Coluna que registro o endereço da web da loja';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Coluna que registra o endereço físico da loja';
COMMENT ON COLUMN lojas.latitude IS 'Coluna que registra a latitude da loja';
COMMENT ON COLUMN lojas.longitude IS 'Coluna que registra a longitude da loja';
COMMENT ON COLUMN lojas.logo IS 'Coluna que registra a logo da loja';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Coluna que armazena o arquivo do tipo MIME da log, que ajuda a identificar corretamente o formato do arquivo (JPEG, PNG, GIF, etc)';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Coluna que armazena o nome do arquivo da logo';
COMMENT ON COLUMN lojas.logo_charset IS 'Coluna que armazena um conjunto de caracteres que servem para codificar a imagem a qual está relacionada, nesse caso a logo da loja';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Coluna que armazena a data da última alteração feita na logo da loja';


CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);
COMMENT ON COLUMN envios.envio_id IS 'Coluna que registra a ID do envio do pedido';
COMMENT ON COLUMN envios.loja_id IS 'Coluna que registra a id da loja e é a Primary Key da tabela';
COMMENT ON COLUMN envios.cliente_id IS 'Coluna que registra a ID dos clientes e é a Primary Key da tabela';


CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE estoques IS 'Tabela que registra as informações relacionadas aos estoques das lojas';
COMMENT ON COLUMN estoques.estoque_id IS 'Coluna que registra a ID do estoque';
COMMENT ON COLUMN estoques.loja_id IS 'Coluna que registra a ID da loja relacionada ao estoque';
COMMENT ON COLUMN estoques.produto_id IS 'Coluna que registra a ID do produto relacionado ao estoque';
COMMENT ON COLUMN estoques.quantidade IS 'Coluna que registra a quantidade do produto no estoque';


CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                estoque_id NUMERIC(38) NOT NULL,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);
COMMENT ON TABLE produtos IS 'Tabela que registra as informações dos produtos';
COMMENT ON COLUMN produtos.produto_id IS 'Coluna que registra a ID do produto';
COMMENT ON COLUMN produtos.nome IS 'Coluna que registra o nome do produto';
COMMENT ON COLUMN produtos.preco_unitario IS 'Coluna que registra o preço do produto';
COMMENT ON COLUMN produtos.detalhes IS 'Coluna que registra os detalhes do produto';
COMMENT ON COLUMN produtos.imagem IS 'Coluna que registra uma imagem do produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'Coluna que armazena o arquivo do tipo MIME da imagem do produto, que ajuda a identificar o formato do arquivo (JPEG, GIF, PNG, etc)';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Coluna que registra o nome do arquivo da imagem do produto';
COMMENT ON COLUMN produtos.imagem_charset IS 'Coluna que armazena um conjunto de caracteres que servem para codificar a imagem a qual está relacionada, nesse caso, imagens do produto';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Coluna que registra a data da última atualização da foto do produto';
COMMENT ON COLUMN produtos.estoque_id IS 'Coluna que registra a ID do estoque';


CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE pedidos IS 'Tabela que armazena os dados de pedidos das lojas';
COMMENT ON COLUMN pedidos.pedido_id IS 'Coluna que armazena a ID dos pedidos e é a PK';
COMMENT ON COLUMN pedidos.data_hora IS 'Coluna que armazena a data e hora que do pedido';
COMMENT ON COLUMN pedidos.cliente_id IS 'Coluna que registra a ID dos clientes e é uma Foreign Key';
COMMENT ON COLUMN pedidos.status IS 'Coluna que registra o status do pedido';
COMMENT ON COLUMN pedidos.loja_id IS 'Coluna que registra a ID da loja que o pedido foi realizado e é uma Foreign Key';


CREATE TABLE pedidos_itens (
                produto_id NUMERIC(38) NOT NULL,
                pedido_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (produto_id, pedido_id)
);
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Coluna que registra a ID do produto';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Coluna que armazena a ID dos pedidos e é a PK';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Coluna que registra o numero da linha do pedido';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Coluna que registra o valor dos itens do pedido';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Coluna que registra a quantidade dos itens do pedido';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Coluna que registra a ID do envio do pedido';


ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE produtos ADD CONSTRAINT estoques_produtos_fk
FOREIGN KEY (estoque_id)
REFERENCES estoques (estoque_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
