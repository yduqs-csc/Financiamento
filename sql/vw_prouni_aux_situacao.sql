DROP VIEW IF EXISTS VW_AUX_ETAPAS_PROUNI; CREATE VIEW VW_AUX_ETAPAS_PROUNI AS

SELECT 
    num AS PRIORIDADE
    -- ,SEQ -- Nota: Removido pois a coluna não existe nas subqueries abaixo. Se precisar dela, reative-a e adicione nas subqueries.
    ,situacao AS CLASSIFICACAO_DIGITALIZA
    ,funil AS FUNIL_COMUNICACAO
    ,TRIM(substring(situacao, 1, instr(situacao, '-') - 1)) AS NIVEL
    ,REPLACE(substring(situacao, 1, instr(situacao, '.')), '.', '')::INT AS N1
    ,REPLACE(substring(situacao, instr(situacao, '.'), 3), '.', '')::INT AS N2
FROM (
    SELECT * FROM (
        SELECT NULL AS num, NULL AS situacao
        UNION SELECT 9,'1.00 - Processamento'
        UNION SELECT 9,'1.01 - Triagem'
        UNION SELECT 9,'1.01 - Triagem (Pólo)'
        UNION SELECT 6,'1.01 - Triagem (Unidade)'
        UNION SELECT 7,'1.1 - Em Análise'
        UNION SELECT 7,'1.1 - Em Análise (Pólo Parceiro)'
        UNION SELECT 7,'1.1 - Em Análise (Unidade)'
        UNION SELECT 7,'1.11 - Em Análise (Pós-Triagem)'
        UNION SELECT 7,'1.11 - Em Análise (Pós-Triagem) (Pólo)'
        UNION SELECT 7,'1.11 - Em Análise (Pós-Triagem) (Unidade)'
    ) JOIN ( SELECT 'Pasta em análise' AS funil ) ON 1=1 WHERE situacao IS NOT NULL

    UNION ALL

    SELECT * FROM (
        SELECT NULL AS num, NULL AS situacao
        UNION SELECT 8,'2.0 - Documentação Pendente'
        UNION SELECT 8,'2.0 - Documentação Pendente (Pólo Parceiro)'
        UNION SELECT 8,'2.0 - Documentação Pendente (Pólo Parceiro) - TR'
        UNION SELECT 8,'2.0 - Documentação Pendente (Unidade)'
        UNION SELECT 8,'2.0 - Documentação Pendente (Unidade) - TR'
        UNION SELECT 8,'2.01 - Documentação Triagem Inválido (Pólo)'
        UNION SELECT 8,'2.01 - Documentação Triagem Inválido (Unidade)'
    ) JOIN ( SELECT 'Pasta com doc. Pendente' AS funil ) ON 1=1 WHERE situacao IS NOT NULL

    UNION ALL

    SELECT * FROM (
        SELECT NULL AS num, NULL AS situacao
        UNION SELECT 3,'4.0 - Colher Assinatura TCB ou TR (Termo Prouni)'    
        UNION SELECT 3,'4.0 - Colher Assinatura TR'
        UNION SELECT 3,'4.0 - Colher Assinatura TCB ou TR (Termo Prouni)'
        UNION SELECT 3,'4.0 - Colher Assinatura TCB ou TR'
    ) JOIN ( SELECT 'Candidato assinar TCB' AS funil ) ON 1=1 WHERE situacao IS NOT NULL
);
