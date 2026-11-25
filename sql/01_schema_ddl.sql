-- ==========================================================
-- TRABALHO DE GESTÃO DE BANCO DE DADOS - ETAPA 2
-- Autores: Gabriel Barros Freitas, Guilherme Coutinho, Gustavo Câmara dos Reis
-- Parte 1: Estrutura do Banco e das 11 Tabelas (DDL)
-- ==========================================================

DROP DATABASE IF EXISTS clinica_medica;
CREATE DATABASE clinica_medica CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE clinica_medica;

-- 1. PACIENTE
CREATE TABLE PACIENTE (
    pac_mat INT NOT NULL,
    pac_nome VARCHAR(120) NOT NULL,
    pac_mes_aniv INT NOT NULL,
    pac_sexo CHAR(1) NOT NULL,
    PRIMARY KEY (pac_mat)
);

-- 2. ESPECIALIDADE
CREATE TABLE ESPECIALIDADE (
    esp_cod INT NOT NULL,
    esp_nome VARCHAR(100) NOT NULL,
    PRIMARY KEY (esp_cod)
);

-- 3. MEDICO
CREATE TABLE MEDICO (
    med_crm VARCHAR(20) NOT NULL,
    med_nome VARCHAR(120) NOT NULL,
    PRIMARY KEY (med_crm)
);

-- 4. LABORATORIO
CREATE TABLE LABORATORIO (
    lab_cod INT NOT NULL,
    lab_nome VARCHAR(100) NOT NULL,
    PRIMARY KEY (lab_cod)
);

-- 5. CONSULTA
CREATE TABLE CONSULTA (
    con_num INT NOT NULL,
    con_data DATE NOT NULL,
    con_hora TIME NOT NULL,
    con_num_sala INT NOT NULL,
    con_situac VARCHAR(20) NOT NULL,
    pac_mat INT NOT NULL,
    med_crm VARCHAR(20) NOT NULL,
    PRIMARY KEY (con_num),
    FOREIGN KEY (pac_mat) REFERENCES PACIENTE(pac_mat),
    FOREIGN KEY (med_crm) REFERENCES MEDICO(med_crm)
);

-- 6. MEDICAMENTO
CREATE TABLE MEDICAMENTO (
    mdc_cod INT NOT NULL,
    mdc_nome VARCHAR(100) NOT NULL,
    lab_cod INT NOT NULL,
    PRIMARY KEY (mdc_cod),
    FOREIGN KEY (lab_cod) REFERENCES LABORATORIO(lab_cod)
);

-- 7. SINTOMA
CREATE TABLE SINTOMA (
    sin_cod INT NOT NULL,
    sin_nome VARCHAR(100) NOT NULL,
    PRIMARY KEY (sin_cod)
);

-- 8. EFEITO_COLATERAL
CREATE TABLE EFEITO_COLATERAL (
    mdc_cod INT NOT NULL,
    sin_cod INT NOT NULL,
    PRIMARY KEY (mdc_cod, sin_cod),
    FOREIGN KEY (mdc_cod) REFERENCES MEDICAMENTO(mdc_cod),
    FOREIGN KEY (sin_cod) REFERENCES SINTOMA(sin_cod)
);

-- 9. RECEITA
CREATE TABLE RECEITA (
    con_num INT NOT NULL,
    mdc_cod INT NOT NULL,
    rec_quant INT NOT NULL,
    PRIMARY KEY (con_num, mdc_cod),
    FOREIGN KEY (con_num) REFERENCES CONSULTA(con_num),
    FOREIGN KEY (mdc_cod) REFERENCES MEDICAMENTO(mdc_cod)
);

-- 10. CONTRA_INDICACAO
CREATE TABLE CONTRA_INDICACAO (
    pac_mat INT NOT NULL,
    mdc_cod INT NOT NULL,
    PRIMARY KEY (pac_mat, mdc_cod),
    FOREIGN KEY (pac_mat) REFERENCES PACIENTE(pac_mat),
    FOREIGN KEY (mdc_cod) REFERENCES MEDICAMENTO(mdc_cod)
);

-- 11. FORMACAO
CREATE TABLE FORMACAO (
    med_crm VARCHAR(20) NOT NULL,
    esp_cod INT NOT NULL,
    PRIMARY KEY (med_crm, esp_cod),
    FOREIGN KEY (med_crm) REFERENCES MEDICO(med_crm),
    FOREIGN KEY (esp_cod) REFERENCES ESPECIALIDADE(esp_cod)
);