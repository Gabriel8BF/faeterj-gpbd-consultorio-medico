-- ==========================================================
-- TRABALHO DE GESTÃO DE BANCO DE DADOS - ETAPA 2
-- Autores: Gabriel Barros Freitas, Guilherme Coutinho, Gustavo Câmara dos Reis
-- Parte 3: Resolução das 30 Consultas SQL (DQL)
-- ==========================================================

USE clinica_medica;

-- 1 - Nome dos pacientes de sexo F.
SELECT pac_nome
FROM PACIENTE
WHERE pac_sexo = 'F';

-- 2 - Nome dos pacientes e dos médicos das consultas do dia 19/02/2022.
SELECT p.pac_nome, m.med_nome
FROM CONSULTA c
JOIN PACIENTE p ON c.pac_mat = p.pac_mat
JOIN MEDICO m ON c.med_crm = m.med_crm
WHERE c.con_data = '2022-02-19';

-- 3 - Nomes dos médicos de especialidade PEDIATRIA.
SELECT m.med_nome
FROM MEDICO m
JOIN FORMACAO f ON m.med_crm = f.med_crm
JOIN ESPECIALIDADE e ON f.esp_cod = e.esp_cod
WHERE e.esp_nome = 'PEDIATRIA';

-- 4 - Nome dos pacientes que receberam receita do medicamento AMOXIL e quantidade receitada.
SELECT p.pac_nome, r.rec_quant
FROM PACIENTE p
JOIN CONSULTA c ON p.pac_mat = c.pac_mat
JOIN RECEITA r ON c.con_num = r.con_num
JOIN MEDICAMENTO md ON r.mdc_cod = md.mdc_cod
WHERE md.mdc_nome = 'AMOXIL';

-- 5 - Nome de cada laboratório acompanhado dos seus medicamentos.
SELECT l.lab_nome, md.mdc_nome
FROM LABORATORIO l
LEFT JOIN MEDICAMENTO md ON l.lab_cod = md.lab_cod
ORDER BY l.lab_nome, md.mdc_nome;

-- 6 - Nome dos médicos de especialidade CARDIOLOGIA que têm consulta em 20/02/2022.
SELECT DISTINCT m.med_nome
FROM MEDICO m
JOIN FORMACAO f ON m.med_crm = f.med_crm
JOIN ESPECIALIDADE e ON f.esp_cod = e.esp_cod
JOIN CONSULTA c ON m.med_crm = c.med_crm
WHERE e.esp_nome = 'CARDIOLOGIA'
  AND c.con_data = '2022-02-20';

-- 7 - Nome dos pacientes que fazem aniversário no mês de julho.
SELECT pac_nome
FROM PACIENTE
WHERE pac_mes_aniv = 7;

-- 8 - Nome dos médicos que não atenderam em 19/02/2022.
SELECT med_nome
FROM MEDICO
WHERE med_crm NOT IN (
    SELECT med_crm
    FROM CONSULTA
    WHERE con_data = '2022-02-19'
);

-- 9 - Nome dos pacientes que tiveram consulta em janeiro de 2022.
SELECT DISTINCT p.pac_nome
FROM PACIENTE p
JOIN CONSULTA c ON p.pac_mat = c.pac_mat
WHERE c.con_data BETWEEN '2022-01-01' AND '2022-01-31';

-- 10 - Nome dos médicos que não são pediatras.
SELECT med_nome
FROM MEDICO
WHERE med_crm NOT IN (
    SELECT f.med_crm
    FROM FORMACAO f
    JOIN ESPECIALIDADE e ON f.esp_cod = e.esp_cod
    WHERE e.esp_nome = 'PEDIATRIA'
);

-- 11 - Nome dos médicos com suas respectivas especialidades.
SELECT m.med_nome, e.esp_nome
FROM MEDICO m
JOIN FORMACAO f ON m.med_crm = f.med_crm
JOIN ESPECIALIDADE e ON f.esp_cod = e.esp_cod
ORDER BY m.med_nome;

-- 12 - Nome dos laboratórios que tiveram medicamentos seus receitados em 10/02/2022.
SELECT DISTINCT l.lab_nome
FROM LABORATORIO l
JOIN MEDICAMENTO md ON l.lab_cod = md.lab_cod
JOIN RECEITA r ON md.mdc_cod = r.mdc_cod
JOIN CONSULTA c ON r.con_num = c.con_num
WHERE c.con_data = '2022-02-10';

-- 13 - Nome dos ortopedistas que não atenderam em 19/08/2022.
SELECT m.med_nome
FROM MEDICO m
JOIN FORMACAO f ON m.med_crm = f.med_crm
JOIN ESPECIALIDADE e ON f.esp_cod = e.esp_cod
WHERE e.esp_nome = 'ORTOPEDIA'
  AND m.med_crm NOT IN (
      SELECT med_crm
      FROM CONSULTA
      WHERE con_data = '2022-08-19'
  );

-- 14 - Nome dos pacientes que cancelaram consultas no mês de abril de 2022.
SELECT DISTINCT p.pac_nome
FROM PACIENTE p
JOIN CONSULTA c ON p.pac_mat = c.pac_mat
WHERE c.con_situac = 'CANCELADA'
  AND c.con_data BETWEEN '2022-04-01' AND '2022-04-30';

-- 15 - Nome dos medicamentos que causam AZIA.
SELECT md.mdc_nome
FROM MEDICAMENTO md
JOIN EFEITO_COLATERAL ec ON md.mdc_cod = ec.mdc_cod
JOIN SINTOMA s ON ec.sin_cod = s.sin_cod
WHERE s.sin_nome = 'AZIA';

-- 16 - Nome dos medicamentos que causam AZIA e CEFALÉIA.
SELECT md.mdc_nome
FROM MEDICAMENTO md
JOIN EFEITO_COLATERAL ec ON md.mdc_cod = ec.mdc_cod
JOIN SINTOMA s ON ec.sin_cod = s.sin_cod
WHERE s.sin_nome IN ('AZIA', 'CEFALÉIA')
GROUP BY md.mdc_cod, md.mdc_nome
HAVING COUNT(DISTINCT s.sin_nome) = 2;

-- 17 - Nome dos medicamentos que causam AZIA ou CEFALÉIA.
SELECT DISTINCT md.mdc_nome
FROM MEDICAMENTO md
JOIN EFEITO_COLATERAL ec ON md.mdc_cod = ec.mdc_cod
JOIN SINTOMA s ON ec.sin_cod = s.sin_cod
WHERE s.sin_nome IN ('AZIA', 'CEFALÉIA');

-- 18 - Nome dos medicamentos que causam HIPOTENSÃO e foram receitados em outubro de 2019.
SELECT DISTINCT md.mdc_nome
FROM MEDICAMENTO md
JOIN EFEITO_COLATERAL ec ON md.mdc_cod = ec.mdc_cod
JOIN SINTOMA s ON ec.sin_cod = s.sin_cod
JOIN RECEITA r ON md.mdc_cod = r.mdc_cod
JOIN CONSULTA c ON r.con_num = c.con_num
WHERE s.sin_nome = 'HIPOTENSÃO'
  AND c.con_data BETWEEN '2019-10-01' AND '2019-10-31';

-- 19 - Nome dos medicamentos que causam CEFALÉIA mas não causam AZIA.
SELECT md.mdc_nome
FROM MEDICAMENTO md
JOIN EFEITO_COLATERAL ec ON md.mdc_cod = ec.mdc_cod
JOIN SINTOMA s ON ec.sin_cod = s.sin_cod
WHERE s.sin_nome = 'CEFALÉIA'
  AND md.mdc_cod NOT IN (
      SELECT ec2.mdc_cod
      FROM EFEITO_COLATERAL ec2
      JOIN SINTOMA s2 ON ec2.sin_cod = s2.sin_cod
      WHERE s2.sin_nome = 'AZIA'
  );

-- 20 - Nome dos pacientes que não podem tomar AMOXIL.
SELECT p.pac_nome
FROM PACIENTE p
JOIN CONTRA_INDICACAO ci ON p.pac_mat = ci.pac_mat
JOIN MEDICAMENTO md ON ci.mdc_cod = md.mdc_cod
WHERE md.mdc_nome = 'AMOXIL';

-- 21 - Nome dos pacientes do sexo M que consultaram em março de 2022 com médico cardiologista.
SELECT DISTINCT p.pac_nome
FROM PACIENTE p
JOIN CONSULTA c ON p.pac_mat = c.pac_mat
JOIN MEDICO m ON c.med_crm = m.med_crm
JOIN FORMACAO f ON m.med_crm = f.med_crm
JOIN ESPECIALIDADE e ON f.esp_cod = e.esp_cod
WHERE p.pac_sexo = 'M'
  AND e.esp_nome = 'CARDIOLOGIA'
  AND c.con_data BETWEEN '2022-03-01' AND '2022-03-31';

-- 22 - Nome dos médicos que receitaram algum medicamento que causa URTICÁRIA.
SELECT DISTINCT m.med_nome
FROM MEDICO m
JOIN CONSULTA c ON m.med_crm = c.med_crm
JOIN RECEITA r ON c.con_num = r.con_num
JOIN EFEITO_COLATERAL ec ON r.mdc_cod = ec.mdc_cod
JOIN SINTOMA s ON ec.sin_cod = s.sin_cod
WHERE s.sin_nome = 'URTICÁRIA';

-- 23 - Nome dos medicamentos que podem causar FEBRE, acompanhados do nome de seus respectivos laboratórios.
SELECT md.mdc_nome, l.lab_nome
FROM MEDICAMENTO md
JOIN LABORATORIO l ON md.lab_cod = l.lab_cod
JOIN EFEITO_COLATERAL ec ON md.mdc_cod = ec.mdc_cod
JOIN SINTOMA s ON ec.sin_cod = s.sin_cod
WHERE s.sin_nome = 'FEBRE';

-- 24 - Nome das especialidades que não possuem nenhum médico habilitado.
SELECT e.esp_nome
FROM ESPECIALIDADE e
LEFT JOIN FORMACAO f ON e.esp_cod = f.esp_cod
WHERE f.med_crm IS NULL;

-- 25 - Nome dos medicamentos que todos os pacientes podem tomar (sem nenhuma contra-indicação).
SELECT mdc_nome
FROM MEDICAMENTO
WHERE mdc_cod NOT IN (
    SELECT mdc_cod
    FROM CONTRA_INDICACAO
);

-- 26 - Nome dos médicos que atenderam na sala 10 em 16/02/2022.
SELECT DISTINCT m.med_nome
FROM MEDICO m
JOIN CONSULTA c ON m.med_crm = c.med_crm
WHERE c.con_num_sala = 10
  AND c.con_data = '2022-02-16';

-- 27 - Nome dos médicos que não atenderam na sala 10 em 16/01/2022.
SELECT med_nome
FROM MEDICO
WHERE med_crm NOT IN (
    SELECT med_crm
    FROM CONSULTA
    WHERE con_num_sala = 10
      AND con_data = '2022-01-16'
);

-- 28 - Número das consultas que não geraram receita, acompanhado dos nomes do paciente e do médico.
SELECT c.con_num, p.pac_nome, m.med_nome
FROM CONSULTA c
JOIN PACIENTE p ON c.pac_mat = p.pac_mat
JOIN MEDICO m ON c.med_crm = m.med_crm
LEFT JOIN RECEITA r ON c.con_num = r.con_num
WHERE r.con_num IS NULL;

-- 29 - Nome dos laboratórios que não tiveram nenhum medicamento receitado no mês de março de 2022.
SELECT lab_nome
FROM LABORATORIO
WHERE lab_cod NOT IN (
    SELECT md.lab_cod
    FROM MEDICAMENTO md
    JOIN RECEITA r ON md.mdc_cod = r.mdc_cod
    JOIN CONSULTA c ON r.con_num = c.con_num
    WHERE c.con_data BETWEEN '2022-03-01' AND '2022-03-31'
);

-- 30 - Nome dos medicamentos que não causam nenhum efeito colateral.
SELECT mdc_nome
FROM MEDICAMENTO
WHERE mdc_cod NOT IN (
    SELECT mdc_cod
    FROM EFEITO_COLATERAL
);