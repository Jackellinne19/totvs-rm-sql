SELECT*,
    (ISNULL(P1_T1,0) + ISNULL(P2_T1,0) + ISNULL(AT1_T1,0) + ISNULL(AT2_T1,0)) / NULLIF(QTDE_AT_T1,0) AS PARCIAL_T1,

    (ISNULL(P1_T2,0) + ISNULL(P2_T2,0) + ISNULL(AT1_T2,0) + ISNULL(AT2_T2,0))/ NULLIF(QTDE_AT_T2,0) AS PARCIAL_T2,

    (ISNULL(P1_T3,0) + ISNULL(P2_T3,0) + ISNULL(AT1_T3,0) + ISNULL(AT2_T3,0))/ NULLIF(QTDE_AT_T3,0) AS PARCIAL_T3

FROM(SELECT DISTINCT
       SDISCIPLINA.NOME             AS NOME_DISC,
       Max(PERIODOLETIVO.CODPERLET) AS ANOLETIVO,
       PPESSOA.NOME                 AS ALUNO_NOME,  
       PROF.PROFESSORES				AS PROFESSOR_NOME,
       STURMADISC.CODTURMA          AS TURMA,
       SNOTAS.CODCOLIGADA,
       SNOTAS.IDTURMADISC,
       SNOTAS.RA,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 111 
             	AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
             
           END)     AS P1_T1,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 112 
             	AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS P2_T1,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 113 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS AT1_T1,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 114 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS AT2_T1,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 121 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS REC_T1,
      
       COUNT(CASE
                WHEN SNOTAS.CODPROVA IN (111,112,113,114)
                    AND SNOTAS.NOTA IS NOT NULL 
                THEN 1 
                END) AS QTDE_AT_T1,

       Max(CASE
             WHEN SNOTAS.CODPROVA = 211 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS P1_T2,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 212 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS P2_T2,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 213 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS AT1_T2,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 214 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS AT2_T2,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 221 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS REC_T2,
       COUNT(CASE
                WHEN SNOTAS.CODPROVA IN (211, 212,213,214)
                    AND SNOTAS.NOTA IS NOT NULL 
                THEN 1 
                END) AS QTDE_AT_T2,

       Max(CASE
             WHEN SNOTAS.CODPROVA = 311 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS P1_T3,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 312 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS P2_T3,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 313 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS AT1_T3,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 314 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS AT2_T3,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 321 
             AND SNOTAS.NOTA IS NOT NULL 
             THEN SNOTAS.NOTA
           END)     AS REC_T3,
       COUNT(CASE
                WHEN SNOTAS.CODPROVA IN (311, 312,313,314)
                    AND SNOTAS.NOTA IS NOT NULL 
                THEN 1 
                END) AS QTDE_AT_T3

        
       FROM   SMATRICULA (NOLOCK)
                    LEFT JOIN SMATRICPL (NOLOCK)
                            ON SMATRICULA.CODCOLIGADA = SMATRICPL.CODCOLIGADA
                              AND SMATRICULA.IDPERLET = SMATRICPL.IDPERLET
                              AND SMATRICULA.IDHABILITACAOFILIAL = SMATRICPL.IDHABILITACAOFILIAL
                              AND SMATRICULA.RA = SMATRICPL.RA

                    LEFT JOIN STURMADISC (NOLOCK)
                            ON STURMADISC.CODCOLIGADA = SMATRICULA.CODCOLIGADA
                              AND STURMADISC.IDTURMADISC = SMATRICULA.IDTURMADISC
                    LEFT JOIN SALUNO (NOLOCK)
                            ON SMATRICULA.CODCOLIGADA = SALUNO.CODCOLIGADA
                              AND SMATRICULA.RA = SALUNO.RA
                    LEFT JOIN SNOTAS (NOLOCK)
                            ON SNOTAS.CODCOLIGADA = SMATRICULA.CODCOLIGADA
                              AND SNOTAS.IDTURMADISC = SMATRICULA.IDTURMADISC
                              AND SNOTAS.RA = SMATRICULA.RA
                    LEFT JOIN SPROVAS (NOLOCK)
                            ON SNOTAS.CODPROVA = SPROVAS.CODPROVA
                              AND SNOTAS.IDTURMADISC = SPROVAS.IDTURMADISC
                              AND SNOTAS.CODETAPA = SPROVAS.CODETAPA
                              AND SNOTAS.TIPOETAPA = SPROVAS.TIPOETAPA
                              AND SNOTAS.CODCOLIGADA = SPROVAS.CODCOLIGADA
                    LEFT JOIN SDISCIPLINA (NOLOCK)
                              ON SDISCIPLINA.CODDISC = STURMADISC.CODDISC
                              AND SDISCIPLINA.CODCOLIGADA = STURMADISC.CODCOLIGADA
                              AND STURMADISC.CODDISC = SDISCIPLINA.CODDISC
                    LEFT JOIN SPLETIVO PERIODOLETIVO (NOLOCK)
                            ON PERIODOLETIVO.CODCOLIGADA = SMATRICULA.CODCOLIGADA
                              AND PERIODOLETIVO.IDPERLET = SMATRICULA.IDPERLET

                    LEFT JOIN PPESSOA (NOLOCK)
                            ON SALUNO.CODPESSOA = PPESSOA.CODIGO
                    LEFT JOIN (SELECT PT.CODCOLIGADA,
                                        PT.IDTURMADISC,
                                        STRING_AGG(P.NOME, ', ') AS PROFESSORES
                                  FROM   SPROFESSORTURMA PT (NOLOCK)
                                        LEFT JOIN SPROFESSOR SP (NOLOCK)
                                                ON PT.CODCOLIGADA = SP.CODCOLIGADA
                                                      AND PT.CODPROF = SP.CODPROF
                                        LEFT JOIN PPESSOA P (NOLOCK)
                                                ON SP.CODPESSOA = P.CODIGO
                                  GROUP  BY PT.CODCOLIGADA,
                                                PT.IDTURMADISC) PROF
                                  ON PROF.CODCOLIGADA = STURMADISC.CODCOLIGADA
                                  AND PROF.IDTURMADISC = STURMADISC.IDTURMADISC    
                                      
            WHERE  SMATRICULA.CODCOLIGADA = :CODCOLIGADA
                    AND STURMADISC.CODFILIAL = :CODFILIAL
                    AND PERIODOLETIVO.CODPERLET = :CODPERLET
                    AND ( ( :IDTURMADISC <> 0
                    AND SMATRICULA.IDTURMADISC = :IDTURMADISC )
                    OR ( :IDTURMADISC = 0
                    AND :CODTURMA <> ''
                    AND STURMADISC.CODTURMA = :CODTURMA ) )
                    AND SMATRICULA.CODSTATUS = 1
                    AND SMATRICPL.CODSTATUS = 1
            GROUP  BY SNOTAS.CODCOLIGADA,
                        SNOTAS.IDTURMADISC,
                        PPESSOA.NOME,                    
                        PROF.PROFESSORES,
                        SNOTAS.RA,
                        STURMADISC.CODDISC,
                        SDISCIPLINA.NOME,
                        STURMADISC.CODTURMA)P
