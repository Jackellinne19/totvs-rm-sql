SELECT*,

       ((((ISNULL(P1_T1,0) + ISNULL(P2_T1,0)) / 2.0) * 6 + ((ISNULL(TB_T1,0) * 3) + ISNULL(PARTICIP_T1,0)))/ 10) AS PARCIAL_T1,

       ((((ISNULL(P1_T2,0) + ISNULL(P2_T2,0)) / 2.0) * 6 + ((ISNULL(TB_T2,0) * 3) + ISNULL(PARTICIP_T2,0)))/ 10) AS PARCIAL_T2,

       ((((ISNULL(P1_T3,0) + ISNULL(P2_T3,0)) / 2.0) * 6 + ((ISNULL(TB_T3,0) * 3) + ISNULL(PARTICIP_T3,0)))/ 10) AS PARCIAL_T3

FROM(SELECT 
       SDISCIPLINA.NOME             AS NOME_DISC,
       Max(PERIODOLETIVO.CODPERLET) AS ANOLETIVO,
       STURMADISC.CODTURMA          AS TURMA,
       SNOTAS.CODCOLIGADA,
       SNOTAS.IDTURMADISC,
       SNOTAS.RA,
       PPESSOA.NOME                 AS ALUNO_NOME,
       PROF.PROFESSORES             AS PROFESSOR_NOME,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 2111 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS P1_T1,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 2112 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS P2_T1,

       Max(CASE
             WHEN SNOTAS.CODPROVA = 2121 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS TB_T1,

      Max(CASE
             WHEN SNOTAS.CODPROVA = 2122 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS PARTICIP_T1,
      Max(CASE
             WHEN SNOTAS.CODPROVA = 2141 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS REC_T1,
     
       Max(CASE
             WHEN SNOTAS.CODPROVA = 2211 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS P1_T2,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 2212 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS P2_T2,

       Max(CASE
             WHEN SNOTAS.CODPROVA = 2221 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS TB_T2,

      Max(CASE
             WHEN SNOTAS.CODPROVA = 2222 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS PARTICIP_T2,
      Max(CASE
             WHEN SNOTAS.CODPROVA = 2241 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS REC_T2,
      
       Max(CASE
             WHEN SNOTAS.CODPROVA = 2311 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS P1_T3,
       Max(CASE
             WHEN SNOTAS.CODPROVA = 2312 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS P2_T3,

       Max(CASE
             WHEN SNOTAS.CODPROVA = 2321 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS TB_T3,

      Max(CASE
             WHEN SNOTAS.CODPROVA = 2322 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS PARTICIP_T3,
      Max(CASE
             WHEN SNOTAS.CODPROVA = 2341 AND SNOTAS.NOTA IS NOT NULL THEN SNOTAS.NOTA
           END)     AS REC_T3

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
                     LEFT JOIN SPROFESSORTURMA (NOLOCK)
                            ON STURMADISC.CODCOLIGADA = SPROFESSORTURMA.CODCOLIGADA
                            AND STURMADISC.IDTURMADISC = SPROFESSORTURMA.IDTURMADISC
                            AND PERIODOLETIVO.CODCOLIGADA = SPROFESSORTURMA.CODCOLIGADA
                     LEFT JOIN SPROFESSOR (NOLOCK)
                            ON SPROFESSORTURMA.CODCOLIGADA = SPROFESSOR.CODCOLIGADA
                            AND SPROFESSORTURMA.CODPROF = SPROFESSOR.CODPROF
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
