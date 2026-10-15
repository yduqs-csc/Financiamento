DROP VIEW IF EXISTS temp.VW_PROUNI_DOCUSING; CREATE TEMP VIEW VW_PROUNI_DOCUSING AS

SELECT * FROM (
             SELECT *,
                 ROW_NUMBER() OVER (PARTITION BY nome_docusing ORDER BY data_atividade DESC) AS ult_atividade,
                 COUNT(nome_docusing) OVER (PARTITION BY nome_docusing) AS qtde_destinatario
             FROM (
                 SELECT
                     -- Remove acentos nativamente e converte para maiúsculas
                     UPPER(strip_accents("Nome do destinatário")) AS nome_docusing,
                     "Nome do destinatário" AS destinatario,
                     "status" AS status_docusing,
                     -- No DuckDB, a concatenação padrão usa o operador || ou a função concat()
                     "Última atividade (Data)" || ' ' || SUBSTR("Enviado em (Horário)", 1, 5) AS data_atividade
                 FROM TB_DOCUSING
             )
             -- O DuckDB permite ordenar na subquery se necessário, mas o ORDER BY externo é mais limpo
         )
      WHERE ult_atividade = 1
 ORDER BY qtde_destinatario DESC;
