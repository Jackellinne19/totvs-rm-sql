/*Datas para Liberação do Boletim no Conecta4edu*/

DECLARE @LIBERA_T1_EF1 DATE = Cast('2026-04-30' AS DATE);
DECLARE @LIBERA_T1_EF2 DATE = Cast('2026-04-30' AS DATE);

DECLARE @LIBERA_T2_EF1 DATE = Cast('2026-08-30' AS DATE);
DECLARE @LIBERA_T2_EF2 DATE = Cast('2026-08-30' AS DATE);

DECLARE @LIBERA_T3_EF1 DATE = Cast('2026-12-15' AS DATE);
DECLARE @LIBERA_T3_EF2 DATE = Cast('2026-12-15' AS DATE);

DECLARE @HOJE DATE = Cast(Getdate() AS DATE);
DECLARE @ONL CHAR(1) = Upper(:ONLINE_N_OU_S); 
/*N: Busca todas as notas, independente da data. 
  S: Busca as notas considerando a data de liberação (Visão dos Responsáveis)*/


WITH MEDIA_ANO AS (
     SELECT 
          SHABILITACAOFILIAL.CODHABILITACAO,
          STURMADISC.CODDISC,
          SETAPAS.CODETAPA,
          AVG(SNOTAETAPA.NOTAFALTA) AS MEDIA
     FROM SMATRICPL (NOLOCK)
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
     WHERE SMATRICPL.CODCOLIGADA = 23
       AND SMATRICPL.CODFILIAL = 25
       AND SMATRICPL.CODSTATUS = 1
       AND SMATRICULA.CODSTATUS = 1
       AND CAST(SPLETIVO.CODPERLET AS INT) BETWEEN 2023 AND 2050
       AND SPLETIVO.CODPERLET = :ANO_LETIVO
       AND SHABILITACAOFILIAL.CODCURSO = 'EF'
       AND STURMADISC.ATIVA = 'S'
       AND SETAPAS.TIPOETAPA = 'N'
     GROUP BY 
          SHABILITACAOFILIAL.CODHABILITACAO,
          STURMADISC.CODDISC,
          SETAPAS.CODETAPA
),

COMNT_TRIM AS (
     SELECT 
          SMATRICPL.CODCOLIGADA,
          SETAPAS.CODETAPA,
          SMATRICPL.RA,
          SETAPAS.TIPOETAPA,
          TRIM(STRING_AGG(TRIM(Replace(Replace(Replace(Replace(Cast(SNOTAETAPACOMENTARIO.COMENTARIO AS VARCHAR(1000)), Char(9), ' '), Char(10), ' '), Char(13), ''), '  ', ' ')), ' ')) AS OBS
     FROM SMATRICPL (NOLOCK)
     JOIN SMATRICULA (NOLOCK)
          ON SMATRICPL.CODCOLIGADA = SMATRICULA.CODCOLIGADA
         AND SMATRICPL.IDHABILITACAOFILIAL = SMATRICULA.IDHABILITACAOFILIAL
         AND SMATRICPL.IDPERLET = SMATRICULA.IDPERLET
         AND SMATRICPL.RA = SMATRICULA.RA
         AND SMATRICULA.IDTURMADISC <> 14274
     JOIN SPLETIVO (NOLOCK)
          ON SMATRICPL.CODCOLIGADA = SPLETIVO.CODCOLIGADA
         AND SMATRICPL.CODFILIAL = SPLETIVO.CODFILIAL
         AND SMATRICPL.IDPERLET = SPLETIVO.IDPERLET
     JOIN SETAPAS (NOLOCK)
          ON SMATRICPL.CODCOLIGADA = SETAPAS.CODCOLIGADA
         AND SMATRICULA.IDTURMADISC = SETAPAS.IDTURMADISC
     JOIN SNOTAETAPACOMENTARIO (NOLOCK)
          ON SMATRICPL.CODCOLIGADA = SNOTAETAPACOMENTARIO.CODCOLIGADA
         AND SETAPAS.CODETAPA = SNOTAETAPACOMENTARIO.CODETAPA
         AND SMATRICULA.IDTURMADISC = SNOTAETAPACOMENTARIO.IDTURMADISC
         AND SMATRICPL.RA = SNOTAETAPACOMENTARIO.RA
         AND SETAPAS.TIPOETAPA = SNOTAETAPACOMENTARIO.TIPOETAPA
     WHERE SMATRICPL.CODCOLIGADA = 23
       AND SMATRICPL.CODFILIAL = 25
       AND SMATRICPL.CODSTATUS = 1
       AND SMATRICULA.CODSTATUS = 1
       AND CAST(SPLETIVO.CODPERLET AS INT) BETWEEN 2023 AND 2050
       AND SPLETIVO.CODPERLET = :ANO_LETIVO
       AND TRIM(SMATRICPL.RA) LIKE TRIM(:RA)
       AND SMATRICPL.CODTURMA LIKE UPPER(:TURMA)
     GROUP BY 
          SMATRICPL.CODCOLIGADA,
          SETAPAS.CODETAPA,
          SMATRICPL.RA,
          SETAPAS.TIPOETAPA
)


SELECT SMATRICPL.CODCOLIGADA     AS COLIGADA,
       SMATRICPL.CODTURMA        AS CODTURMA,
       SMATRICPL.CODFILIAL       AS CODFILIAL,
       SCURSO.NOME               AS SEGMENTO,
       SHABILITACAO.NOME         AS CURSO,
       SMATRICPL.CODTURMA        AS TURMA_,
       SPLETIVO.CODPERLET        AS ANO_LETIVO,
       SMATRICPL.RA              AS ALUNO_RA,
       PPESSOA.NOME              AS ALUNO_NOME,
       Min(SMATRICULA.NUMDIARIO) AS ALUNO_NUMERO,
       SSTATUSPL.DESCRICAO       AS ANO_RESULTADO,
       STURMADISC.CODDISC        AS DISCIPLINA_COD,
       SDISCIPLINA.NOME          AS DISCIPLINA_NOME,
       SSTATUSMT.DESCRICAO       AS DISCIPLINA_RESULTADO,
       STURMADISC.IDTURMADISC,
          CASE 
               WHEN LEFT(SHABILITACAOFILIAL.CODGRADE, 2) = 'EF'
                    AND HABILITACAO.SERIE BETWEEN 1 AND 5
                    THEN 'SIM'

               WHEN (
                         LEFT(SHABILITACAOFILIAL.CODGRADE, 2) = 'EF'
                         AND HABILITACAO.SERIE BETWEEN 6 AND 9
                    )
                    OR LEFT(SHABILITACAOFILIAL.CODGRADE, 2) = 'EM'
                    THEN 'NAO'

               ELSE ''
		END AS CAMPO_OBS,
		CASE 
               WHEN LEFT(SHABILITACAOFILIAL.CODGRADE, 2) = 'EF'
                    AND HABILITACAO.SERIE BETWEEN 1 AND 5
                    THEN 'NAO'
               
               WHEN (
                         LEFT(SHABILITACAOFILIAL.CODGRADE, 2) = 'EF'
                         AND HABILITACAO.SERIE BETWEEN 6 AND 9
                    )
                    OR LEFT(SHABILITACAOFILIAL.CODGRADE, 2) = 'EM'
                    THEN 'SIM'
               
               ELSE ''
		END AS CAMPO_GRF,	
       
       /* Calculo de Notas de Etapa*/

       /*=========================================
             1° TRIMESTRE NOTAS E FALTAS
        =========================================*/

       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T1_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 310 ) THEN COALESCE(SNOTAETAPA.NOTAFALTA, 0)
           END)                  AS T1_FLT,
       TRIM(STRING_AGG(CASE
                         WHEN ( @ONL = 'N'
                                 OR ( HABILITACAO.SERIE <= 5
                                      AND @HOJE >= @LIBERA_T1_EF1 ) 
                                
                                OR ( HABILITACAO.SERIE > 5
                                      AND @HOJE >= @LIBERA_T1_EF2 ))

                              AND SETAPAS.CODETAPA = 311 THEN COMNT_TRIM.OBS
                       END, ' '))         AS T1_OBS,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T1_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 315 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                  AS T1_NOT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T1_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 312 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                  AS T1_REC,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T1_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 319 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                  AS T1_FIM,

       /*=========================================
             2° TRIMESTRE NOTAS E FALTAS
        =========================================*/
           
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T2_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T2_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 320 ) THEN COALESCE(SNOTAETAPA.NOTAFALTA, 0)
           END)                  AS T2_FLT,
       TRIM(STRING_AGG(CASE
                         WHEN ( @ONL = 'N'
                                 OR ( HABILITACAO.SERIE <= 5
                                      AND @HOJE >= @LIBERA_T2_EF1 ) 
                                
                                OR ( HABILITACAO.SERIE > 5
                                      AND @HOJE >= @LIBERA_T2_EF2 ))

                              AND SETAPAS.CODETAPA = 321 THEN COMNT_TRIM.OBS
                       END, ' '))         AS T2_OBS,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T2_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T2_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 325 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                  AS T2_NOT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T1_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 322 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                  AS T2_REC,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T1_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 329 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                  AS T2_FIM,

       /*=========================================
             3° TRIMESTRE NOTAS E FALTAS
        =========================================*/

       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T1_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 330 ) THEN COALESCE(SNOTAETAPA.NOTAFALTA, 0)
           END)                  AS T3_FLT,
       TRIM(STRING_AGG(CASE
                         WHEN ( @ONL = 'N'
                                 OR ( HABILITACAO.SERIE <= 5
                                      AND @HOJE >= @LIBERA_T3_EF1 ) 
                                
                                OR ( HABILITACAO.SERIE > 5
                                      AND @HOJE >= @LIBERA_T3_EF2 ))

                              AND SETAPAS.CODETAPA = 331 THEN COMNT_TRIM.OBS
                       END, ' '))         AS T3_OBS,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T1_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T1_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 335 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                  AS T3_NOT,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T2_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T2_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 332 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                  AS T3_REC,
       Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T2_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T2_EF2 ) )
                  AND ( SETAPAS.CODETAPA = 339 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                  AS T3_FIM,

        Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T3_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T3_EF2 ) )
                  AND SETAPAS.CODETAPA = 998 THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS ANO_REC,
        
        Max(CASE
             WHEN ( @ONL = 'N'
                     OR ( HABILITACAO.SERIE <= 5
                          AND @HOJE >= @LIBERA_T3_EF1 )
                     OR ( HABILITACAO.SERIE > 5
                          AND @HOJE >= @LIBERA_T3_EF2 ) )
                  AND SETAPAS.CODETAPA = 999 THEN Round(SNOTAETAPA.NOTAFALTA, 1)
           END)                           AS ANO_NOT,
        
       Cast(Max(CASE
                  WHEN ( ( HABILITACAO.SERIE <= 5
                           AND @HOJE >= @LIBERA_T3_EF1 )
                          OR ( HABILITACAO.SERIE > 5
                               AND @HOJE >= @LIBERA_T3_EF2) )
                       AND ( SETAPAS.CODETAPA = 339 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
                  
                  WHEN ( ( HABILITACAO.SERIE <= 5
                           AND @HOJE >= @LIBERA_T2_EF1
                           AND @HOJE < @LIBERA_T3_EF1 )
                          OR ( HABILITACAO.SERIE > 5
                               AND @HOJE >= @LIBERA_T2_EF2
                               AND @HOJE < @LIBERA_T3_EF2 ) )
                       AND ( SETAPAS.CODETAPA = 329 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
                  WHEN ( ( HABILITACAO.SERIE <= 5
                           AND @HOJE >= @LIBERA_T1_EF1
                           AND @HOJE < @LIBERA_T2_EF1 )
                          OR ( HABILITACAO.SERIE > 5
                               AND @HOJE >= @LIBERA_T1_EF2
                               AND @HOJE < @LIBERA_T2_EF2 ) )
                       AND ( SETAPAS.CODETAPA = 319 ) THEN Round(SNOTAETAPA.NOTAFALTA, 1)
                END) AS DECIMAL(3, 1))    AS GRAFICO_MEDIA_ALUNO,
       
       Cast(Max(CASE
                  WHEN ( ( HABILITACAO.SERIE <= 5
                           AND @HOJE >= @LIBERA_T3_EF1)
                          OR ( HABILITACAO.SERIE > 5
                               AND @HOJE >= @LIBERA_T3_EF2) )
                       AND ( MEDIA_ANO.CODETAPA = 339 ) THEN MEDIA_ANO.MEDIA
                  
                  WHEN ( ( HABILITACAO.SERIE <= 5
                           AND @HOJE >= @LIBERA_T2_EF1
                           AND @HOJE < @LIBERA_T3_EF1 )
                          OR ( HABILITACAO.SERIE > 5
                               AND @HOJE >= @LIBERA_T2_EF2
                               AND @HOJE < @LIBERA_T3_EF2 ) )
                       AND ( MEDIA_ANO.CODETAPA = 329 ) THEN MEDIA_ANO.MEDIA
                  
                  WHEN ( ( HABILITACAO.SERIE <= 5
                           AND @HOJE >= @LIBERA_T1_EF1
                           AND @HOJE < @LIBERA_T2_EF1 )
                          OR ( HABILITACAO.SERIE > 5
                               AND @HOJE >= @LIBERA_T1_EF2
                               AND @HOJE < @LIBERA_T2_EF2 ) )
                       AND ( MEDIA_ANO.CODETAPA = 319 ) THEN MEDIA_ANO.MEDIA
                END) AS DECIMAL(3, 1))    AS GRAFICO_MEDIA_ANO   

FROM   SMATRICPL (NOLOCK)
       LEFT JOIN SMATRICULA (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = SMATRICULA.CODCOLIGADA
                 AND SMATRICPL.IDHABILITACAOFILIAL = SMATRICULA.IDHABILITACAOFILIAL
                 AND SMATRICPL.IDPERLET = SMATRICULA.IDPERLET
                 AND SMATRICPL.RA = SMATRICULA.RA
       LEFT JOIN SPLETIVO (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = SPLETIVO.CODCOLIGADA
                 AND SMATRICPL.CODFILIAL = SPLETIVO.CODFILIAL
                 AND SMATRICPL.IDPERLET = SPLETIVO.IDPERLET
       LEFT JOIN SALUNO (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = SALUNO.CODCOLIGADA
                 AND SMATRICPL.RA = SALUNO.RA
       LEFT JOIN PPESSOA (NOLOCK)
              ON SALUNO.CODPESSOA = PPESSOA.CODIGO
       LEFT JOIN SSTATUS (NOLOCK) AS SSTATUSPL
              ON SMATRICPL.CODCOLIGADA = SSTATUSPL.CODCOLIGADA
                 AND SMATRICPL.CODSTATUSRES = SSTATUSPL.CODSTATUS
       LEFT JOIN SSTATUS (NOLOCK) AS SSTATUSMT
              ON SMATRICPL.CODCOLIGADA = SSTATUSMT.CODCOLIGADA
                 AND SMATRICULA.CODSTATUSRES = SSTATUSMT.CODSTATUS
       LEFT JOIN SHABILITACAOFILIAL (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = SHABILITACAOFILIAL.CODCOLIGADA
                 AND SMATRICPL.CODFILIAL = SHABILITACAOFILIAL.CODFILIAL
                 AND SMATRICPL.IDHABILITACAOFILIAL = SHABILITACAOFILIAL.IDHABILITACAOFILIAL
       LEFT JOIN SHABILITACAO (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = SHABILITACAO.CODCOLIGADA
                 AND SHABILITACAOFILIAL.CODCURSO = SHABILITACAO.CODCURSO
                 AND SHABILITACAOFILIAL.CODHABILITACAO = SHABILITACAO.CODHABILITACAO

       CROSS APPLY (SELECT CAST(RIGHT(SHABILITACAOFILIAL.CODGRADE, 1) AS INT) AS SERIE) AS HABILITACAO

       LEFT JOIN SCURSO (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = SCURSO.CODCOLIGADA
                 AND SHABILITACAOFILIAL.CODCURSO = SCURSO.CODCURSO
       LEFT JOIN STURMADISC (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = STURMADISC.CODCOLIGADA
                 AND SMATRICPL.CODFILIAL = STURMADISC.CODFILIAL
                 AND SMATRICPL.CODTURMA = STURMADISC.CODTURMA
                 AND SMATRICPL.IDHABILITACAOFILIAL = STURMADISC.IDHABILITACAOFILIAL
                 AND SMATRICPL.IDPERLET = STURMADISC.IDPERLET
                 AND SMATRICULA.IDTURMADISC = STURMADISC.IDTURMADISC
       LEFT JOIN SDISCIPLINA (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = SDISCIPLINA.CODCOLIGADA
                 AND STURMADISC.CODDISC = SDISCIPLINA.CODDISC
       LEFT JOIN SETAPAS (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = SETAPAS.CODCOLIGADA
                 AND SMATRICULA.IDTURMADISC = SETAPAS.IDTURMADISC
       LEFT JOIN SNOTAETAPA (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = SNOTAETAPA.CODCOLIGADA
                 AND SETAPAS.CODETAPA = SNOTAETAPA.CODETAPA
                 AND SETAPAS.IDTURMADISC = SNOTAETAPA.IDTURMADISC
                 AND SMATRICPL.RA = SNOTAETAPA.RA
                 AND SETAPAS.TIPOETAPA = SNOTAETAPA.TIPOETAPA
       
       LEFT JOIN MEDIA_ANO
          ON SHABILITACAOFILIAL.CODHABILITACAO = MEDIA_ANO.CODHABILITACAO
          AND STURMADISC.CODDISC = MEDIA_ANO.CODDISC
          AND SETAPAS.CODETAPA = MEDIA_ANO.CODETAPA

       LEFT JOIN COMNT_TRIM
          ON SMATRICPL.CODCOLIGADA = COMNT_TRIM.CODCOLIGADA
          AND SETAPAS.CODETAPA = COMNT_TRIM.CODETAPA
          AND SMATRICPL.RA = COMNT_TRIM.RA
          AND SETAPAS.TIPOETAPA = COMNT_TRIM.TIPOETAPA
                 
WHERE  SMATRICPL.CODCOLIGADA = 23
       AND SMATRICPL.CODFILIAL = 25
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
          SSTATUSPL.DESCRICAO,
          STURMADISC.IDTURMADISC,
          SHABILITACAOFILIAL.CODGRADE,
          HABILITACAO.SERIE
