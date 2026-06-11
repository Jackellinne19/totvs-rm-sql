SELECT *,

       CASE
            WHEN TIPO_FUND = 'FUND1'
                THEN (ISNULL(PD_T1,0) * 0.3) / 10

            WHEN TIPO_FUND IN ('FUND2','EM')
                 AND FUND2_EDF_ART = 1
                THEN (
                        (ISNULL(PART_T1,0) * 0.4) +
                        (ISNULL(DESENV_T1,0) * 0.5) +
                        (ISNULL(REL_T1,0) * 0.1)
                     ) / 10

            WHEN TIPO_FUND IN ('FUND2','EM')
                THEN (
                        (ISNULL(PART_T1,0) * 0.1) +
                        (ISNULL(DESENV_T1,0) * 0.2) +
                        (ISNULL(REL_T1,0) * 0.6) +
                        (ISNULL(DIVER_T1,0) * 0.1)
                     ) / 10
       END AS PARCIAL_T1,

       CASE
            WHEN TIPO_FUND = 'FUND1'
                THEN (ISNULL(PD_T2,0) * 0.3) / 10

            WHEN TIPO_FUND IN ('FUND2','EM')
                 AND FUND2_EDF_ART = 1
                THEN (
                        (ISNULL(PART_T2,0) * 0.4) +
                        (ISNULL(DESENV_T2,0) * 0.5) +
                        (ISNULL(REL_T2,0) * 0.1)
                     ) / 10

            WHEN TIPO_FUND IN ('FUND2','EM')
                THEN (
                        (ISNULL(PART_T2,0) * 0.1) +
                        (ISNULL(DESENV_T2,0) * 0.2) +
                        (ISNULL(REL_T2,0) * 0.6) +
                        (ISNULL(DIVER_T2,0) * 0.1)
                     ) / 10
       END AS PARCIAL_T2,

       CASE
            WHEN TIPO_FUND = 'FUND1'
                THEN (ISNULL(PD_T3,0) * 0.3) / 10

            WHEN TIPO_FUND IN ('FUND2','EM')
                 AND FUND2_EDF_ART = 1
                THEN (
                        (ISNULL(PART_T3,0) * 0.4) +
                        (ISNULL(DESENV_T3,0) * 0.5) +
                        (ISNULL(REL_T3,0) * 0.1)
                     ) / 10

            WHEN TIPO_FUND IN ('FUND2','EM')
                THEN (
                        (ISNULL(PART_T3,0) * 0.1) +
                        (ISNULL(DESENV_T3,0) * 0.2) +
                        (ISNULL(REL_T3,0) * 0.6) +
                        (ISNULL(DIVER_T3,0) * 0.1)
                     ) / 10
       END AS PARCIAL_T3

FROM (
      SELECT 
            SDISCIPLINA.NOME             AS NOME_DISC,
            Max(PERIODOLETIVO.CODPERLET) AS ANOLETIVO,
            STURMADISC.CODTURMA          AS TURMA,
            SNOTAS.CODCOLIGADA,
            SNOTAS.IDTURMADISC,
            SNOTAS.RA,
            PPESSOA.NOME                 AS ALUNO_NOME,
            PROF.PROFESSORES             AS PROFESSOR_NOME,

            /*FUND I*/
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1111 AND STURMADISC.CODTURNO IN (61,62) THEN SNOTAS.NOTA
                END)     AS PD_T1,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1112 AND STURMADISC.CODTURNO IN (61,62)THEN SNOTAS.NOTA
                END)     AS FA_T1,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1113 AND STURMADISC.CODTURNO IN (61,62) THEN SNOTAS.NOTA
                  
                END)     AS AT_T1,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1121 AND STURMADISC.CODTURNO IN (61,62)THEN SNOTAS.NOTA
                
                END)     AS REC_T1,
        
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1211 AND STURMADISC.CODTURNO IN (61,62) THEN SNOTAS.NOTA
                END)     AS PD_T2,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1212 AND STURMADISC.CODTURNO IN (61,62) THEN SNOTAS.NOTA
                END)     AS FA_T2,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1213 AND STURMADISC.CODTURNO IN (61,62) THEN SNOTAS.NOTA
                END)     AS AT_T2,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1221 AND STURMADISC.CODTURNO IN (61,62) THEN SNOTAS.NOTA
                END)     AS REC_T2,

            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1311 AND STURMADISC.CODTURNO IN (61,62) THEN SNOTAS.NOTA
                END)     AS PD_T3,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1312 AND STURMADISC.CODTURNO IN (61,62) THEN SNOTAS.NOTA
                END)     AS FA_T3,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1313 AND STURMADISC.CODTURNO IN (61,62)THEN SNOTAS.NOTA
                END)     AS AT_T3,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 1321 AND STURMADISC.CODTURNO IN (61,62) THEN SNOTAS.NOTA
                END)     AS REC_T3,

            /*FUND II*/

            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2111  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
 
                END)     AS PART_T1,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2112  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS DESENV_T1,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2113  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS REL_T1,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2114  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS DIVER_T1,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2121  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS REC2_T1,
          
            
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2211  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS PART_T2,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2212  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS DESENV_T2,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2213  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS REL_T2,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2214  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS DIVER_T2,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2221  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA

                END)     AS REC2_T2,


            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2311  AND STURMADISC.CODTURNO IN (63,64,65,66)THEN SNOTAS.NOTA
  
                END)     AS PART_T3,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2312  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS DESENV_T3,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2313  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS REL_T3,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2314  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS DIVER_T3,
            Max(CASE
                  WHEN SNOTAS.CODPROVA = 2321  AND STURMADISC.CODTURNO IN (63,64,65,66) THEN SNOTAS.NOTA
                END)     AS REC2_T3,

           CASE
            WHEN MAX(STURMADISC.CODTURNO) IN (61,62)
            THEN 'FUND1'

            WHEN MAX(STURMADISC.CODTURNO) IN (63,64)
            THEN 'FUND2'

            WHEN  MAX(STURMADISC.CODTURNO) IN (65,66)
            THEN 'EM'

        END AS TIPO_FUND,

          CASE 
            WHEN MAX(STURMADISC.CODTURNO) IN (63,64,65,66)
                AND MAX(STURMADISC.CODDISC) IN ('EDF','ART')
            THEN 1
            ELSE 0
        END AS FUND2_EDF_ART


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

                  
