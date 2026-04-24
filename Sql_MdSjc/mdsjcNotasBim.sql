DECLARE @LIBERA_B1_EF1 DATE = Cast('2024-05-02' AS DATE); /* AAAA-MM-DD */
DECLARE @LIBERA_B2_EF1 DATE = Cast('2024-06-28' AS DATE);
DECLARE @LIBERA_B3_EF1 DATE = Cast('2024-10-04' AS DATE);
DECLARE @LIBERA_B4_EF1 DATE = Cast('2024-12-13' AS DATE);
DECLARE @LIBERA_B1_EF2 DATE = Cast('2024-05-02' AS DATE);
DECLARE @LIBERA_B2_EF2 DATE = Cast('2024-06-28' AS DATE);
DECLARE @LIBERA_B3_EF2 DATE = Cast('2024-09-23' AS DATE);
DECLARE @LIBERA_B4_EF2 DATE = Cast('2024-12-10' AS DATE);
DECLARE @HOJE DATE = Cast(Getdate() AS DATE);
DECLARE @ONL CHAR(1) = Upper(:ONLINE_N_OU_S);

SELECT SMATRICPL.CODCOLIGADA              AS COLIGADA,
       SMATRICPL.CODFILIAL                AS CODFILIAL,
       SCURSO.NOME                        AS SEGMENTO,
       SHABILITACAO.NOME                  AS CURSO,
       SMATRICPL.CODTURMA                 AS TURMA_,
       SPLETIVO.CODPERLET                 AS ANO_LETIVO,
       SMATRICPL.RA                       AS ALUNO_RA,
       PPESSOA.NOME                       AS ALUNO_NOME,
       Min(SMATRICULA.NUMDIARIO)          AS ALUNO_NUMERO,
       SSTATUSPL.DESCRICAO                AS ANO_RESULTADO,
       STURMADISC.CODDISC                 AS DISCIPLINA_COD,
       SDISCIPLINA.NOME                   AS DISCIPLINA_NOME,
       SSTATUSMT.DESCRICAO                AS DISCIPLINA_RESULTADO,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 4
                          AND @HOJE >= @LIBERA_B1_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 4
                          AND @HOJE >= @LIBERA_B1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 210
                         OR SETAPAS.CODETAPA = 310 ) THEN COALESCE(SNOTAETAPA.NOTAFALTA, 0)
           END)                           AS B1_FLT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B1_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 211
                         OR SETAPAS.CODETAPA = 315 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B1_NOT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B1_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 212
                         OR SETAPAS.CODETAPA = 316 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B1_REC,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B1_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 219
                         OR SETAPAS.CODETAPA = 319 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B1_FIM,
       TRIM(STRING_AGG(CASE
                         WHEN ( @ONL = 'N'
                                 OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                                      AND @HOJE >= @LIBERA_B1_EF1 ) )
                              AND SETAPAS.CODETAPA = 211 THEN COMNT_BIM.OBS
                       END, ' '))         AS B1_OBS,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B1_EF1 ) )
                  AND SETAPAS.CODETAPA = 211
                  AND STURMADISC.CODDISC = 'SOA' THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B1_SOA,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B2_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B2_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 220
                         OR SETAPAS.CODETAPA = 320 ) THEN COALESCE(SNOTAETAPA.NOTAFALTA, 0)
           END)                           AS B2_FLT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B2_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B2_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 221
                         OR SETAPAS.CODETAPA = 325 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B2_NOT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B2_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B2_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 222
                         OR SETAPAS.CODETAPA = 326 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B2_REC,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B2_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B2_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 229
                         OR SETAPAS.CODETAPA = 329 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B2_FIM,
       TRIM(STRING_AGG(CASE
                         WHEN ( @ONL = 'N'
                                 OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                                      AND @HOJE >= @LIBERA_B2_EF1 ) )
                              AND SETAPAS.CODETAPA = 221 THEN COMNT_BIM.OBS
                       END, ' '))         AS B2_OBS,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B2_EF1 ) )
                  AND SETAPAS.CODETAPA = 221
                  AND STURMADISC.CODDISC = 'SOA' THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B2_SOA,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B3_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B3_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 230
                         OR SETAPAS.CODETAPA = 330 ) THEN COALESCE(SNOTAETAPA.NOTAFALTA, 0)
           END)                           AS B3_FLT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B3_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B3_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 231
                         OR SETAPAS.CODETAPA = 335 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B3_NOT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B3_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B3_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 232
                         OR SETAPAS.CODETAPA = 336 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B3_REC,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B3_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B3_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 239
                         OR SETAPAS.CODETAPA = 339 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B3_FIM,
       TRIM(STRING_AGG(CASE
                         WHEN ( @ONL = 'N'
                                 OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                                      AND @HOJE >= @LIBERA_B3_EF1 ) )
                              AND SETAPAS.CODETAPA = 231 THEN COMNT_BIM.OBS
                       END, ' '))         AS B3_OBS,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B3_EF1 ) )
                  AND SETAPAS.CODETAPA = 231
                  AND STURMADISC.CODDISC = 'SOA' THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B3_SOA,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B4_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B4_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 240
                         OR SETAPAS.CODETAPA = 340 ) THEN COALESCE(SNOTAETAPA.NOTAFALTA, 0)
           END)                           AS B4_FLT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B4_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B4_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 241
                         OR SETAPAS.CODETAPA = 345 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B4_NOT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B4_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B4_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 242
                         OR SETAPAS.CODETAPA = 346 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B4_REC,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B4_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B4_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 249
                         OR SETAPAS.CODETAPA = 349 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B4_FIM,
       TRIM(STRING_AGG(CASE
                         WHEN ( @ONL = 'N'
                                 OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                                      AND @HOJE >= @LIBERA_B4_EF1 ) )
                              AND SETAPAS.CODETAPA = 241 THEN COMNT_BIM.OBS
                       END, ' '))         AS B4_OBS,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B4_EF1 ) )
                  AND SETAPAS.CODETAPA = 241
                  AND STURMADISC.CODDISC = 'SOA' THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS B4_SOA,
       Cast(COALESCE(Sum(CASE
                           WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                                    AND @HOJE >= @LIBERA_B4_EF1 )
                                   OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                                        AND @HOJE >= @LIBERA_B4_EF2 ) )
                                AND ( SETAPAS.CODETAPA = 210
                                       OR SETAPAS.CODETAPA = 220
                                       OR SETAPAS.CODETAPA = 230
                                       OR SETAPAS.CODETAPA = 240
                                       OR SETAPAS.CODETAPA = 310
                                       OR SETAPAS.CODETAPA = 320
                                       OR SETAPAS.CODETAPA = 330
                                       OR SETAPAS.CODETAPA = 340 ) THEN SNOTAETAPA.NOTAFALTA
                           WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                                    AND @HOJE >= @LIBERA_B3_EF1
                                    AND @HOJE < @LIBERA_B4_EF1 )
                                   OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                                        AND @HOJE >= @LIBERA_B3_EF2
                                        AND @HOJE < @LIBERA_B4_EF2 ) )
                                AND ( SETAPAS.CODETAPA = 210
                                       OR SETAPAS.CODETAPA = 220
                                       OR SETAPAS.CODETAPA = 230
                                       OR SETAPAS.CODETAPA = 310
                                       OR SETAPAS.CODETAPA = 320
                                       OR SETAPAS.CODETAPA = 330 ) THEN SNOTAETAPA.NOTAFALTA
                           WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                                    AND @HOJE >= @LIBERA_B2_EF1
                                    AND @HOJE < @LIBERA_B3_EF1 )
                                   OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                                        AND @HOJE >= @LIBERA_B2_EF2
                                        AND @HOJE < @LIBERA_B3_EF2 ) )
                                AND ( SETAPAS.CODETAPA = 210
                                       OR SETAPAS.CODETAPA = 220
                                       OR SETAPAS.CODETAPA = 310
                                       OR SETAPAS.CODETAPA = 320 ) THEN SNOTAETAPA.NOTAFALTA
                           WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                                    AND @HOJE >= @LIBERA_B1_EF1
                                    AND @HOJE < @LIBERA_B2_EF1 )
                                   OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                                        AND @HOJE >= @LIBERA_B1_EF2
                                        AND @HOJE < @LIBERA_B2_EF2 ) )
                                AND ( SETAPAS.CODETAPA = 210
                                       OR SETAPAS.CODETAPA = 310 ) THEN SNOTAETAPA.NOTAFALTA
                         END), 0) AS INT) AS ANO_FLT,
                         
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B4_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B4_EF2 ) )
                  AND SETAPAS.CODETAPA = 999 THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS ANO_NOT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                          AND @HOJE >= @LIBERA_B4_EF1 )
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B4_EF2 ) )
                  AND SETAPAS.CODETAPA = 999 THEN Round(SNOTAETAPA.NOTAFALTA * 4, 1)
           END)                           AS ANO_PTS,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                          AND @HOJE >= @LIBERA_B4_EF2 ) )
                  AND SETAPAS.CODETAPA = 351 THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS ANO_REC,
       Cast(Max(CASE
                  WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                           AND @HOJE >= @LIBERA_B4_EF1 )
                          OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                               AND @HOJE >= @LIBERA_B4_EF2 ) )
                       AND ( SETAPAS.CODETAPA = 249
                              OR SETAPAS.CODETAPA = 349 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
                  WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                           AND @HOJE >= @LIBERA_B3_EF1
                           AND @HOJE < @LIBERA_B4_EF1 )
                          OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                               AND @HOJE >= @LIBERA_B3_EF2
                               AND @HOJE < @LIBERA_B4_EF2 ) )
                       AND ( SETAPAS.CODETAPA = 239
                              OR SETAPAS.CODETAPA = 339 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
                  WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                           AND @HOJE >= @LIBERA_B2_EF1
                           AND @HOJE < @LIBERA_B3_EF1 )
                          OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                               AND @HOJE >= @LIBERA_B2_EF2
                               AND @HOJE < @LIBERA_B3_EF2 ) )
                       AND ( SETAPAS.CODETAPA = 229
                              OR SETAPAS.CODETAPA = 329 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
                  WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                           AND @HOJE >= @LIBERA_B1_EF1
                           AND @HOJE < @LIBERA_B2_EF1 )
                          OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                               AND @HOJE >= @LIBERA_B1_EF2
                               AND @HOJE < @LIBERA_B2_EF2 ) )
                       AND ( SETAPAS.CODETAPA = 219
                              OR SETAPAS.CODETAPA = 319 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
                END) AS DECIMAL(3, 1))    AS GRAFICO_MEDIA_ALUNO,
       Cast(Max(CASE
                  WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                           AND @HOJE >= @LIBERA_B4_EF1 )
                          OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                               AND @HOJE >= @LIBERA_B4_EF2 ) )
                       AND ( MEDIA_ANO.CODETAPA = 249
                              OR MEDIA_ANO.CODETAPA = 349 ) THEN MEDIA_ANO.MEDIA
                  WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                           AND @HOJE >= @LIBERA_B3_EF1
                           AND @HOJE < @LIBERA_B4_EF1 )
                          OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                               AND @HOJE >= @LIBERA_B3_EF2
                               AND @HOJE < @LIBERA_B4_EF2 ) )
                       AND ( MEDIA_ANO.CODETAPA = 239
                              OR MEDIA_ANO.CODETAPA = 339 ) THEN MEDIA_ANO.MEDIA
                  WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                           AND @HOJE >= @LIBERA_B2_EF1
                           AND @HOJE < @LIBERA_B3_EF1 )
                          OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                               AND @HOJE >= @LIBERA_B2_EF2
                               AND @HOJE < @LIBERA_B3_EF2 ) )
                       AND ( MEDIA_ANO.CODETAPA = 229
                              OR MEDIA_ANO.CODETAPA = 329 ) THEN MEDIA_ANO.MEDIA
                  WHEN ( ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) <= 5
                           AND @HOJE >= @LIBERA_B1_EF1
                           AND @HOJE < @LIBERA_B2_EF1 )
                          OR ( Cast(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) > 5
                               AND @HOJE >= @LIBERA_B1_EF2
                               AND @HOJE < @LIBERA_B2_EF2 ) )
                       AND ( MEDIA_ANO.CODETAPA = 219
                              OR MEDIA_ANO.CODETAPA = 319 ) THEN MEDIA_ANO.MEDIA
                END) AS DECIMAL(3, 1))    AS GRAFICO_MEDIA_ANO
FROM SMATRICPL (NOLOCK) /* Matrícula do Aluno no Período Letivo */
       LEFT JOIN SMATRICULA (NOLOCK) /* Matrícula do Aluno em cada Disciplina */
              ON SMATRICPL.CODCOLIGADA = SMATRICULA.CODCOLIGADA /* Código da Coligada */
                 AND SMATRICPL.IDHABILITACAOFILIAL = SMATRICULA.IDHABILITACAOFILIAL /* Identificador da Matriz Aplicada */
                 AND SMATRICPL.IDPERLET = SMATRICULA.IDPERLET /* Identificador do Período Letivo */
                 AND SMATRICPL.RA = SMATRICULA.RA /* Registro Acadêmico */
       LEFT JOIN SPLETIVO (NOLOCK) /* Período Letivo */
              ON SMATRICPL.CODCOLIGADA = SPLETIVO.CODCOLIGADA /* Código da Coligada */
                 AND SMATRICPL.CODFILIAL = SPLETIVO.CODFILIAL /* Código da Filial */
                 AND SMATRICPL.IDPERLET = SPLETIVO.IDPERLET /* Identificador do Período Letivo */
       LEFT JOIN SALUNO (NOLOCK) /* Aluno */
              ON SMATRICPL.CODCOLIGADA = SALUNO.CODCOLIGADA /* Código da Coligada */
                 AND SMATRICPL.RA = SALUNO.RA /* Registro Acadêmico */
       LEFT JOIN PPESSOA (NOLOCK) /* Pessoas */
              ON SALUNO.CODPESSOA = PPESSOA.CODIGO
       LEFT JOIN SSTATUS (NOLOCK) AS SSTATUSPL /* Status de Matrícula */
              ON SMATRICPL.CODCOLIGADA = SSTATUSPL.CODCOLIGADA /* Código da Coligada */
                 AND SMATRICPL.CODSTATUSRES = SSTATUSPL.CODSTATUS /* Código do Status */
       LEFT JOIN SSTATUS (NOLOCK) AS SSTATUSMT /* Status de Matrícula */
              ON SMATRICPL.CODCOLIGADA = SSTATUSMT.CODCOLIGADA /* Código da Coligada */
                 AND SMATRICULA.CODSTATUSRES = SSTATUSMT.CODSTATUS /* Código do Status */
       LEFT JOIN SHABILITACAOFILIAL (NOLOCK) /* Matriz Aplicada */
              ON SMATRICPL.CODCOLIGADA = SHABILITACAOFILIAL.CODCOLIGADA /* Código da Coligada */
                 AND SMATRICPL.CODFILIAL = SHABILITACAOFILIAL.CODFILIAL /* Código da Filial */
                 AND SMATRICPL.IDHABILITACAOFILIAL = SHABILITACAOFILIAL.IDHABILITACAOFILIAL /* Identificador da Matriz Aplicada */
       LEFT JOIN SHABILITACAO (NOLOCK) /* Habilitação */
              ON SMATRICPL.CODCOLIGADA = SHABILITACAO.CODCOLIGADA /* Código da Coligada */
                 AND SHABILITACAOFILIAL.CODCURSO = SHABILITACAO.CODCURSO /* Código do Curso */
                 AND SHABILITACAOFILIAL.CODHABILITACAO = SHABILITACAO.CODHABILITACAO /* Código da Habilitação */
       LEFT JOIN SCURSO (NOLOCK) /* Curso */
              ON SMATRICPL.CODCOLIGADA = SCURSO.CODCOLIGADA /* Código da Coligada */
                 AND SHABILITACAOFILIAL.CODCURSO = SCURSO.CODCURSO /* Código do Curso */
       LEFT JOIN STURMADISC (NOLOCK) /* Turma Disciplina */
              ON SMATRICPL.CODCOLIGADA = STURMADISC.CODCOLIGADA /* Código da Coligada */
                 AND SMATRICPL.CODFILIAL = STURMADISC.CODFILIAL /* Código da Filial */
                 AND SMATRICPL.CODTURMA = STURMADISC.CODTURMA /* Código da Turma */
                 AND SMATRICPL.IDHABILITACAOFILIAL = STURMADISC.IDHABILITACAOFILIAL /* Identificador da Matriz Aplicada */
                 AND SMATRICPL.IDPERLET = STURMADISC.IDPERLET /* Identificador do Período Letivo */
                 AND SMATRICULA.IDTURMADISC = STURMADISC.IDTURMADISC /* Identificador da Turma Disciplina */
       LEFT JOIN SDISCIPLINA (NOLOCK) /* Disciplina */
              ON SMATRICPL.CODCOLIGADA = SDISCIPLINA.CODCOLIGADA /* Código da Coligada */
                 AND STURMADISC.CODDISC = SDISCIPLINA.CODDISC /* Código da Disciplina */
       LEFT JOIN SETAPAS (NOLOCK) /* Etapas */
              ON SMATRICPL.CODCOLIGADA = SETAPAS.CODCOLIGADA /* Código da Coligada */
                 AND SMATRICULA.IDTURMADISC = SETAPAS.IDTURMADISC /* Identificador da Turma Disciplina */
       LEFT JOIN SNOTAETAPA (NOLOCK) /* Notas nas Etapas da Turma Disciplina */
              ON SMATRICPL.CODCOLIGADA = SNOTAETAPA.CODCOLIGADA /* Código da Coligada */
                 AND SETAPAS.CODETAPA = SNOTAETAPA.CODETAPA /* Código da Etapa */
                 AND SETAPAS.IDTURMADISC = SNOTAETAPA.IDTURMADISC /* Identificador da Turma Disciplina */
                 AND SMATRICPL.RA = SNOTAETAPA.RA /* Registro Acadêmico */
                 AND SETAPAS.TIPOETAPA = SNOTAETAPA.TIPOETAPA /* Tipo da Etapa */
       LEFT JOIN (SELECT SHABILITACAOFILIAL.CODHABILITACAO,
                         STURMADISC.CODDISC,
                         SETAPAS.CODETAPA,
                         Avg(SNOTAETAPA.NOTAFALTA) AS MEDIA
                  FROM   SMATRICPL (NOLOCK)
                         JOIN SMATRICULA (NOLOCK)
                           ON SMATRICPL.CODCOLIGADA = SMATRICULA.CODCOLIGADA
                              AND SMATRICPL.IDHABILITACAOFILIAL = SMATRICULA.IDHABILITACAOFILIAL
                              AND SMATRICPL.IDPERLET = SMATRICULA.IDPERLET
                              AND SMATRICPL.RA = SMATRICULA.RA
                         JOIN SPLETIVO (NOLOCK)
                           ON SMATRICPL.CODCOLIGADA = SPLETIVO.CODCOLIGADA
                              AND SMATRICPL.CODFILIAL = SPLETIVO.CODFILIAL
                              AND SMATRICPL.IDPERLET = SPLETIVO.IDPERLET
                         JOIN SHABILITACAOFILIAL (NOLOCK)
                           ON SMATRICPL.CODCOLIGADA = SHABILITACAOFILIAL.CODCOLIGADA
                              AND SMATRICPL.CODFILIAL = SHABILITACAOFILIAL.CODFILIAL
                              AND SMATRICPL.IDHABILITACAOFILIAL = SHABILITACAOFILIAL.IDHABILITACAOFILIAL
                         JOIN STURMADISC (NOLOCK)
                           ON SMATRICPL.CODCOLIGADA = STURMADISC.CODCOLIGADA
                              AND SMATRICPL.CODFILIAL = STURMADISC.CODFILIAL
                              AND SMATRICPL.CODTURMA = STURMADISC.CODTURMA
                              AND SMATRICPL.IDHABILITACAOFILIAL = STURMADISC.IDHABILITACAOFILIAL
                              AND SMATRICPL.IDPERLET = STURMADISC.IDPERLET
                              AND SMATRICULA.IDTURMADISC = STURMADISC.IDTURMADISC
                         JOIN SETAPAS (NOLOCK)
                           ON SMATRICPL.CODCOLIGADA = SETAPAS.CODCOLIGADA
                              AND SMATRICULA.IDTURMADISC = SETAPAS.IDTURMADISC
                              AND SETAPAS.CODETAPA % 10 = 9
                         JOIN SNOTAETAPA (NOLOCK)
                           ON SMATRICPL.CODCOLIGADA = SNOTAETAPA.CODCOLIGADA
                              AND SETAPAS.CODETAPA = SNOTAETAPA.CODETAPA
                              AND SETAPAS.IDTURMADISC = SNOTAETAPA.IDTURMADISC
                              AND SMATRICPL.RA = SNOTAETAPA.RA
                              AND SETAPAS.TIPOETAPA = SNOTAETAPA.TIPOETAPA
                  WHERE  SMATRICPL.CODCOLIGADA = 16
                         AND SMATRICPL.CODFILIAL = 21
                         AND SMATRICPL.CODSTATUS = 1
                         AND SMATRICULA.CODSTATUS = 1
                         AND Cast(SPLETIVO.CODPERLET AS INT) BETWEEN 2023 AND 2050
                         AND SPLETIVO.CODPERLET = :ANO_LETIVO
                         AND SHABILITACAOFILIAL.CODCURSO = 'EF'
                         AND STURMADISC.ATIVA = 'S'
                         AND SETAPAS.TIPOETAPA = 'N'
                  GROUP  BY SHABILITACAOFILIAL.CODHABILITACAO,
                            STURMADISC.CODDISC,
                            SETAPAS.CODETAPA) AS MEDIA_ANO
              ON SHABILITACAOFILIAL.CODHABILITACAO = MEDIA_ANO.CODHABILITACAO
                 AND STURMADISC.CODDISC = MEDIA_ANO.CODDISC
                 AND SETAPAS.CODETAPA = MEDIA_ANO.CODETAPA
       LEFT JOIN (SELECT SMATRICPL.CODCOLIGADA,
                         SETAPAS.CODETAPA,
                         SMATRICPL.RA,
                         SETAPAS.TIPOETAPA,
                         TRIM(STRING_AGG(TRIM(Replace(Replace(Replace(Replace(Cast(SNOTAETAPACOMENTARIO.COMENTARIO AS VARCHAR(1000)), Char(9), ' '), Char(10), ' '), Char(13), ''), '  ', ' ')), ' ')) AS OBS
                  FROM   SMATRICPL (NOLOCK) /* Matrícula do Aluno no Período Letivo */
                         JOIN SMATRICULA (NOLOCK) /* Matrícula do Aluno em cada Disciplina */
                           ON SMATRICPL.CODCOLIGADA = SMATRICULA.CODCOLIGADA /* Código da Coligada */
                              AND SMATRICPL.IDHABILITACAOFILIAL = SMATRICULA.IDHABILITACAOFILIAL /* Identificador da Matriz Aplicada */
                              AND SMATRICPL.IDPERLET = SMATRICULA.IDPERLET /* Identificador do Período Letivo */
                              AND SMATRICPL.RA = SMATRICULA.RA /* Registro Acadêmico */
                              AND SMATRICULA.IDTURMADISC <> 14274
                         JOIN SPLETIVO (NOLOCK) /* Período Letivo */
                           ON SMATRICPL.CODCOLIGADA = SPLETIVO.CODCOLIGADA /* Código da Coligada */
                              AND SMATRICPL.CODFILIAL = SPLETIVO.CODFILIAL /* Código da Filial */
                              AND SMATRICPL.IDPERLET = SPLETIVO.IDPERLET /* Identificador do Período Letivo */
                         JOIN SETAPAS (NOLOCK) /* Etapas */
                           ON SMATRICPL.CODCOLIGADA = SETAPAS.CODCOLIGADA /* Código da Coligada */
                              AND SMATRICULA.IDTURMADISC = SETAPAS.IDTURMADISC /* Identificador da Turma Disciplina */
                         JOIN SNOTAETAPACOMENTARIO (NOLOCK) /* Comentário das faltas/etapas dos alunos */
                           ON SMATRICPL.CODCOLIGADA = SNOTAETAPACOMENTARIO.CODCOLIGADA /* Código da Coligada */
                              AND SETAPAS.CODETAPA = SNOTAETAPACOMENTARIO.CODETAPA /* Código da Etapa */
                              AND SMATRICULA.IDTURMADISC = SNOTAETAPACOMENTARIO.IDTURMADISC /* Identificador da Turma Disciplina */
                              AND SMATRICPL.RA = SNOTAETAPACOMENTARIO.RA /* Registro Acadêmico */
                              AND SETAPAS.TIPOETAPA = SNOTAETAPACOMENTARIO.TIPOETAPA /* Tipo da Etapa */
                  WHERE  SMATRICPL.CODCOLIGADA = 16
                         AND SMATRICPL.CODFILIAL = 21
                         AND SMATRICPL.CODSTATUS = 1 /*MT no ano*/
                         AND SMATRICULA.CODSTATUS = 1 /*MT na disciplina*/
                         AND Cast(SPLETIVO.CODPERLET AS INT) BETWEEN 2023 AND 2050
                         AND SPLETIVO.CODPERLET = :ANO_LETIVO
                         AND TRIM(SMATRICPL.RA) LIKE TRIM(:RA)
                         AND SMATRICPL.CODTURMA LIKE Upper(:TURMA)
                  GROUP  BY SMATRICPL.CODCOLIGADA,
                            SETAPAS.CODETAPA,
                            SMATRICPL.RA,
                            SETAPAS.TIPOETAPA) AS COMNT_BIM
              ON SMATRICPL.CODCOLIGADA = COMNT_BIM.CODCOLIGADA /* Código da Coligada */
                 AND SETAPAS.CODETAPA = COMNT_BIM.CODETAPA /* Código da Etapa */
                 AND SMATRICPL.RA = COMNT_BIM.RA /* Registro Acadêmico */
                 AND SETAPAS.TIPOETAPA = COMNT_BIM.TIPOETAPA /* Tipo da Etapa */
WHERE  SMATRICPL.CODCOLIGADA = 16
       AND SMATRICPL.CODFILIAL = 21
       AND SMATRICPL.CODSTATUS = 1 /*MT no ano*/
       AND SMATRICULA.CODSTATUS = 1 /*MT na disciplina*/
       AND Cast(SPLETIVO.CODPERLET AS INT) BETWEEN 2023 AND 2050
       AND SPLETIVO.CODPERLET = :ANO_LETIVO
       AND TRIM(SMATRICPL.RA) LIKE TRIM(:RA)
       AND SMATRICPL.CODTURMA LIKE Upper(:TURMA)
       AND SHABILITACAOFILIAL.CODCURSO = 'EF'
       AND STURMADISC.ATIVA = 'S'
GROUP  BY SMATRICPL.CODCOLIGADA,
          SMATRICPL.CODFILIAL,
          SCURSO.NOME,
          SHABILITACAO.NOME,
          SMATRICPL.CODTURMA,
          SPLETIVO.CODPERLET,
          SMATRICPL.RA,
          PPESSOA.NOME,
          PPESSOA.SEXO,
          SSTATUSMT.DESCRICAO,
          STURMADISC.CODDISC,
          SDISCIPLINA.NOME,
          SSTATUSPL.DESCRICAO 
