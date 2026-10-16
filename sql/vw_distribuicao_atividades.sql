-- DISTRIBUIÇÃO DAS ATIVIDADES
WITH CTE_BASE AS (
    SELECT * FROM (VALUES
        (1, 'Maria'),
        (2, 'Joao'),
        (3, 'Pedro'),
        (4, 'Jose'),
        -- (5, 'Raul'),
    ) AS t(numero, responsavel)
),
CTE_GRUPO AS (
    SELECT
        NTILE((SELECT COUNT(*) FROM CTE_BASE)) OVER (ORDER BY atividade) AS id_grupo,
        ROW_NUMBER() OVER (ORDER BY atividade) AS id, atividade
    FROM tb_produtos
)
SELECT *
FROM CTE_GRUPO JOIN CTE_BASE ON id_grupo = numero
ORDER BY id;
