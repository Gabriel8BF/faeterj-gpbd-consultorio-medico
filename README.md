# 🏥 Projeto de Banco de Dados: Clínica Médica — FAETERJ

Este repositório contém o projeto prático avaliativo (**Etapa 2**) desenvolvido durante a disciplina de **Gestão de Projetos de Banco de Dados** da **FAETERJ**.

O objetivo deste projeto é implementar o esquema relacional de uma **Clínica Médica** com 11 tabelas interligadas e resolver **30 consultas SQL (DQL)** abrangendo junções múltiplas (`JOIN`), filtros temporais, funções de agregação, subconsultas e operadores de negação (`NOT IN`, `LEFT JOIN ... IS NULL`).

---

## 👥 Autores

* **Gabriel Barros Freitas**
* **Guilherme Coutinho**
* **Gustavo Câmara dos Reis**

---

## 🛠️ Tecnologias e Ferramentas

* **Linguagem:** SQL (DDL, DML e DQL)
* **SGBD:** MySQL / MariaDB (XAMPP)
* **Ambiente de Desenvolvimento:** VS Code (Database Client) / MySQL Workbench

---

## 📐 Estrutura do Banco de Dados (11 Tabelas)

O modelo físico foi estruturado seguindo fielmente as entidades e atributos especificados no enunciado:

* **`PACIENTE`** (`pac_mat`, `pac_nome`, `pac_mes_aniv`, `pac_sexo`)
* **`ESPECIALIDADE`** (`esp_cod`, `esp_nome`)
* **`MEDICO`** (`med_crm`, `med_nome`)
* **`LABORATORIO`** (`lab_cod`, `lab_nome`)
* **`CONSULTA`** (`con_num`, `con_data`, `con_hora`, `con_num_sala`, `con_situac`, `pac_mat`, `med_crm`)
* **`MEDICAMENTO`** (`mdc_cod`, `mdc_nome`, `lab_cod`)
* **`SINTOMA`** (`sin_cod`, `sin_nome`)
* **`EFEITO_COLATERAL`** (`mdc_cod`, `sin_cod`)
* **`RECEITA`** (`con_num`, `mdc_cod`, `rec_quant`)
* **`CONTRA_INDICACAO`** (`pac_mat`, `mdc_cod`)
* **`FORMACAO`** (`med_crm`, `esp_cod`)

*(Nota técnica: os hífens de `EFEITO-COLATERAL` e `CONTRA-INDICACAO` foram padronizados com underscore `_` para seguir as boas práticas de nomenclatura em MySQL).*

---

## 📂 Estrutura de Conteúdos

```text
faeterj-gpbd-clinica-medica/
├── sql/
│   ├── 01_schema_ddl.sql       # Criação do banco e das 11 tabelas (PKs e FKs)
│   ├── 02_seed_dml.sql         # Massa de dados de teste para validar todas as 30 questões
│   └── 03_queries_dql.sql      # Resolução comentada das 30 consultas SQL da Etapa 2
└── README.md                   # Documentação do projeto e guia de execução
```

---

## 🚀 Como Executar o Projeto

Para testar o banco de dados localmente, siga o **Passo 1** para ligar o servidor e, em seguida, escolha **apenas uma** das alternativas no **Passo 2** (**Opção A**, **Opção B** ou **Opção C**).

### Passo 1: Iniciar o Servidor Local (Pré-requisito Obrigatório)

1. Abra o **XAMPP Control Panel** (ou o gerenciador de serviços do **MySQL Server**).
2. Localize o módulo **MySQL** e clique no botão **Start**.
3. Aguarde até que o serviço fique ativo (verde) na porta padrão **`3306`** (`Host: 127.0.0.1` | `User: root`).

---

### Passo 2: Executar os Scripts SQL (Escolha a Opção A, B ou C)

#### Opção A — Pela Extensão do VS Code

1. No VS Code, instale a extensão **MySQL (Database Client)**.
2. Conecte-se à instância local (`Host: 127.0.0.1` | `Port: 3306` | `Username: root`).
3. No **Explorador de Arquivos** (`Ctrl + Shift + E`), abra os arquivos da pasta `sql/` na ordem numérica, selecione todo o código com **`Ctrl + A`** e clique em **Run SQL (`▷`)**:
   * 1º: `sql/01_schema_ddl.sql`
   * 2º: `sql/02_seed_dml.sql`
   * 3º: `sql/03_queries_dql.sql`

#### Opção B — Pelo MySQL Workbench

1. Abra o **MySQL Workbench** e conecte-se à sua instância local (`127.0.0.1:3306`).
2. Vá em **`File > Open SQL Script...`** e abra os três arquivos da pasta `sql/` em abas separadas.
3. Execute cada aba na ordem numérica clicando no ícone do **Raio (`⚡`)**.

#### Opção C — Via Terminal (Linha de Comando)

```bash
# 1. Criar a estrutura do banco de dados e tabelas (DDL)
mysql -u root -p < sql/01_schema_ddl.sql

# 2. Popular as tabelas com os dados de teste (DML)
mysql -u root -p < sql/02_seed_dml.sql

# 3. Executar as 30 consultas SQL (DQL)
mysql -u root -p < sql/03_queries_dql.sql
```

---

## 📝 Sobre a Disciplina

* **Instituição:** FAETERJ (Faculdade de Educação Tecnológica do Estado do Rio de Janeiro)
* **Disciplina:** Gestão de Projetos de Banco de Dados
* **Foco:** Modelagem Relacional e Consultas SQL Avançadas (DQL)