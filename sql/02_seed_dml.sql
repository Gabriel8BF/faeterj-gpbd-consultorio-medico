-- ==========================================================
-- TRABALHO DE GESTÃO DE BANCO DE DADOS - ETAPA 2
-- Autores: Gabriel Barros Freitas, Guilherme Coutinho, Gustavo Câmara dos Reis
-- Parte 2: Inserção de Dados de Teste (DML)
-- ==========================================================

USE clinica_medica;

-- 1. PACIENTE (pac_mes_aniv: 1 a 12, sendo 7 = Julho)
INSERT INTO PACIENTE (pac_mat, pac_nome, pac_mes_aniv, pac_sexo) VALUES
(1, 'Ana Paula Mendes', 7, 'F'),
(2, 'Bruno Ferreira', 3, 'M'),
(3, 'Camila Rocha', 11, 'F'),
(4, 'Diego Martins', 7, 'M'),
(5, 'Eduarda Alves', 5, 'F');

-- 2. ESPECIALIDADE (Dermatologia ficará sem médico para validar a questão 24)
INSERT INTO ESPECIALIDADE (esp_cod, esp_nome) VALUES
(1, 'PEDIATRIA'),
(2, 'CARDIOLOGIA'),
(3, 'ORTOPEDIA'),
(4, 'DERMATOLOGIA');

-- 3. MEDICO
INSERT INTO MEDICO (med_crm, med_nome) VALUES
('CRM-101', 'Dr. Carlos Andrade'),
('CRM-102', 'Dra. Fernanda Costa'),
('CRM-103', 'Dr. Roberto Lima'),
('CRM-104', 'Dra. Mariana Silva');

-- 4. FORMACAO
INSERT INTO FORMACAO (med_crm, esp_cod) VALUES
('CRM-101', 2), -- Cardiologia
('CRM-102', 1), -- Pediatria
('CRM-103', 3), -- Ortopedia
('CRM-104', 3); -- Ortopedia

-- 5. LABORATORIO (Lab 3 não terá receita em março/2022 para validar a questão 29)
INSERT INTO LABORATORIO (lab_cod, lab_nome) VALUES
(1, 'Medley'),
(2, 'EMS'),
(3, 'Sanofi');

-- 6. MEDICAMENTO
INSERT INTO MEDICAMENTO (mdc_cod, mdc_nome, lab_cod) VALUES
(1, 'AMOXIL', 1),
(2, 'DIPIRONA', 2),
(3, 'LOSARTANA', 1),
(4, 'IBUPROFENO', 2),
(5, 'VITAMINA C', 3); -- Sem efeitos colaterais e sem contra-indicações (Q25 e Q30)

-- 7. SINTOMA
INSERT INTO SINTOMA (sin_cod, sin_nome) VALUES
(1, 'AZIA'),
(2, 'CEFALÉIA'),
(3, 'HIPOTENSÃO'),
(4, 'URTICÁRIA'),
(5, 'FEBRE');

-- 8. EFEITO_COLATERAL
INSERT INTO EFEITO_COLATERAL (mdc_cod, sin_cod) VALUES
(1, 1), -- AMOXIL causa AZIA
(1, 2), -- AMOXIL causa CEFALÉIA (Q16: AZIA e CEFALÉIA)
(1, 4), -- AMOXIL causa URTICÁRIA (Q22)
(2, 2), -- DIPIRONA causa apenas CEFALÉIA (Q19: CEFALÉIA mas não AZIA)
(3, 3), -- LOSARTANA causa HIPOTENSÃO (Q18)
(4, 5); -- IBUPROFENO causa FEBRE (Q23)

-- 9. CONTRA_INDICACAO (VITAMINA C não entra aqui -> todos podem tomar - Q25)
INSERT INTO CONTRA_INDICACAO (pac_mat, mdc_cod) VALUES
(1, 1), -- Ana Paula não pode tomar AMOXIL (Q20)
(2, 2),
(3, 3),
(4, 4);

-- 10. CONSULTA
INSERT INTO CONSULTA (con_num, con_data, con_hora, con_num_sala, con_situac, pac_mat, med_crm) VALUES
(1,  '2022-02-19', '09:00:00', 5,  'REALIZADA', 1, 'CRM-102'), -- Q2, Q8
(2,  '2022-02-20', '10:00:00', 3,  'REALIZADA', 2, 'CRM-101'), -- Q6 (Cardiologia em 20/02/2022)
(3,  '2022-01-16', '11:00:00', 10, 'REALIZADA', 3, 'CRM-101'), -- Q9, Q27 (Sala 10 em 16/01/2022)
(4,  '2022-02-10', '14:00:00', 2,  'REALIZADA', 4, 'CRM-102'), -- Q12 (Receita em 10/02/2022)
(5,  '2022-08-19', '15:00:00', 4,  'REALIZADA', 5, 'CRM-103'), -- Q13 (CRM-104 ortopedista não atendeu)
(6,  '2022-04-12', '08:30:00', 1,  'CANCELADA', 3, 'CRM-101'), -- Q14 (Cancelada em abril/2022)
(7,  '2019-10-15', '16:00:00', 6,  'REALIZADA', 1, 'CRM-101'), -- Q18 (Receita de Hipotensão em out/2019)
(8,  '2022-03-10', '09:30:00', 7,  'REALIZADA', 2, 'CRM-101'), -- Q21 (Sexo M, março/2022, Cardiologista)
(9,  '2022-02-16', '13:00:00', 10, 'REALIZADA', 5, 'CRM-103'), -- Q26 (Sala 10 em 16/02/2022)
(10, '2022-03-22', '10:30:00', 8,  'REALIZADA', 4, 'CRM-104'); -- Q28 (Sem receita)

-- 11. RECEITA
INSERT INTO RECEITA (con_num, mdc_cod, rec_quant) VALUES
(1, 1, 2), -- AMOXIL (Q4, Q22)
(4, 2, 1), -- DIPIRONA em 10/02/2022 (Q12)
(7, 3, 3), -- LOSARTANA em out/2019 (Q18)
(8, 1, 1); -- AMOXIL (Medley) em março/2022 (Q29)