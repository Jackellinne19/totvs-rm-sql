WITH RECURMAIN
     AS (SELECT DISTINCT Cast(COALESCE(NULLIF(TRIM(FCFO.TELEX), ''), NULLIF(TRIM(FCFO.TELEFONE), '')) AS VARCHAR(20))  AS TEX,
                         Patindex('%[^0-9]%', COALESCE(NULLIF(TRIM(FCFO.TELEX), ''), NULLIF(TRIM(FCFO.TELEFONE), ''))) AS BADCHARINDEX,
                         FCFO.CODCOLIGADA,
                         FCFO.CODCFO
         FROM   FCFO (NOLOCK)
         UNION ALL
         SELECT Cast(TEX AS VARCHAR(20))  AS TEX,
                Patindex('%[^0-9]%', TEX) AS BADCHARINDEX,
                CODCOLIGADA,
                CODCFO
         FROM   (SELECT CASE
                          WHEN BADCHARINDEX > 0 THEN Replace(TEX, Substring(TEX, BADCHARINDEX, 1), '')
                          ELSE TEX
                        END AS TEX,
                        CODCOLIGADA,
                        CODCFO
                 FROM   RECURMAIN
                 WHERE  BADCHARINDEX > 0) BADCHARFINDER)
SELECT COALESCE(NULLIF(TRIM(PPESSOA.NOME), ''), 'Não informado')        AS ALUNO_NOME,
       COALESCE(NULLIF(TRIM(PCODNACAO.DESCRICAO), ''), 'Não informado') AS ALUNO_NACIONALIDADE,
       FORMAT(PPESSOA.DTNASCIMENTO, 'dd/MM/yyyy')                       AS ALUNO_NASCIMENTO,
       COALESCE(NULLIF(TRIM(PPESSOA.RUA), ''), 'Não informado')         AS ALUNO_END_LOGRADOURO,
       COALESCE(NULLIF(TRIM(PPESSOA.NUMERO), ''), 'Não informado')      AS ALUNO_END_NUMERO,
       TRIM(PPESSOA.COMPLEMENTO)                                        AS ALUNO_END_COMPLEMENTO,
       COALESCE(NULLIF(TRIM(PPESSOA.BAIRRO), ''), 'Não informado')      AS ALUNO_END_BAIRRO,
       COALESCE(NULLIF(TRIM(PPESSOA.CEP), ''), 'Não informado')         AS ALUNO_END_CEP,
       COALESCE(NULLIF(TRIM(PPESSOA.CIDADE), ''), 'Não informado')      AS ALUNO_END_CIDADE,
       COALESCE(NULLIF(TRIM(PPESSOA.ESTADO), ''), 'Não informado')      AS ALUNO_END_ESTADO,
       COALESCE(NULLIF(TRIM(FCFO.NOME), ''), 'Não informado')           AS RESPFIN_NOME,
       COALESCE(NULLIF(TRIM(Upper(FCFO.NOME)), ''), 'Não informado')    AS RESPFIN_NOME_MAIUSCULO,
       CASE
         WHEN FCFO.NACIONALIDADE = 0 THEN 'Brasileiro(a)'
         WHEN FCFO.NACIONALIDADE = 1 THEN 'Estrangeiro(a)'
         ELSE 'Não informado'
       END                                                              AS RESPFIN_NACIONALIDADE,
       COALESCE(PCODESTCIVIL.DESCRICAO, 'Não informado')                AS RESPFIN_ESTADOCIVIL,
       COALESCE(EPROFISS.DESCRICAO, 'Não informado')                    AS RESPFIN_PROFISSAO,
       COALESCE(NULLIF(TRIM(FCFO.CIDENTIDADE), ''), 'Não informado')    AS RESPFIN_RG,
       TRIM(FCFO.CGCCFO)                                                AS RESPFIN_CPF,
       COALESCE(NULLIF(TRIM(FCFO.RUA), ''), 'Não informado')            AS RESPFIN_END_LOGRADOURO,
       COALESCE(NULLIF(TRIM(FCFO.NUMERO), ''), 'Não informado')         AS RESPFIN_END_NUMERO,
       TRIM(FCFO.COMPLEMENTO)                                           AS RESPFIN_END_COMPLEMENTO,
       COALESCE(NULLIF(TRIM(FCFO.BAIRRO), ''), 'Não informado')         AS RESPFIN_END_BAIRRO,
       COALESCE(NULLIF(TRIM(FCFO.CEP), ''), 'Não informado')            AS RESPFIN_END_CEP,
       COALESCE(GMUNICIPIO.NOMEMUNICIPIO, 'Não informado')              AS RESPFIN_END_CIDADE,
       COALESCE(NULLIF(TRIM(FCFO.CODETD), ''), 'Não informado')         AS RESPFIN_END_ESTADO,
       COALESCE(NULLIF(TRIM(CASE
                              WHEN LEFT(RECURMAIN.TEX, 1) <> '0' THEN ( CASE
                                                                          WHEN ( SCONTRATO.CODFILIAL = 21
                                                                                  OR SCONTRATO.CODFILIAL = 22 )
                                                                               AND Len(RECURMAIN.TEX) = 8 THEN '(12) '
                                                                                                               + FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '####-####')
                                                                          WHEN SCONTRATO.CODFILIAL <> 21
                                                                               AND SCONTRATO.CODFILIAL <> 22
                                                                               AND Len(RECURMAIN.TEX) = 8 THEN '(11) '
                                                                                                               + FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '####-####')
                                                                          WHEN ( SCONTRATO.CODFILIAL = 21
                                                                                  OR SCONTRATO.CODFILIAL = 22 )
                                                                               AND Len(RECURMAIN.TEX) = 9 THEN '(12) '
                                                                                                               + FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '#####-####')
                                                                          WHEN SCONTRATO.CODFILIAL <> 21
                                                                               AND SCONTRATO.CODFILIAL <> 22
                                                                               AND Len(RECURMAIN.TEX) = 9 THEN '(11) '
                                                                                                               + FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '#####-####')
                                                                          WHEN Len(RECURMAIN.TEX) = 10 THEN FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '(##) ####-####')
                                                                          WHEN Len(RECURMAIN.TEX) = 11 THEN FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '(##) #####-####')
                                                                          ELSE RECURMAIN.TEX
                                                                        END )
                              WHEN LEFT(RECURMAIN.TEX, 1) = '0' THEN ( CASE
                                                                         WHEN ( SCONTRATO.CODFILIAL = 21
                                                                                 OR SCONTRATO.CODFILIAL = 22 )
                                                                              AND Len(RECURMAIN.TEX) = 9 THEN '(12) '
                                                                                                              + FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '####-####')
                                                                         WHEN SCONTRATO.CODFILIAL <> 21
                                                                              AND SCONTRATO.CODFILIAL <> 22
                                                                              AND Len(RECURMAIN.TEX) = 9 THEN '(11) '
                                                                                                              + FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '####-####')
                                                                         WHEN ( SCONTRATO.CODFILIAL = 21
                                                                                 OR SCONTRATO.CODFILIAL = 22 )
                                                                              AND Len(RECURMAIN.TEX) = 10 THEN '(12) '
                                                                                                               + FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '#####-####')
                                                                         WHEN SCONTRATO.CODFILIAL <> 21
                                                                              AND SCONTRATO.CODFILIAL <> 22
                                                                              AND Len(RECURMAIN.TEX) = 10 THEN '(11) '
                                                                                                               + FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '#####-####')
                                                                         WHEN Len(RECURMAIN.TEX) = 11 THEN FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '(##) ####-####')
                                                                         WHEN Len(RECURMAIN.TEX) = 12 THEN FORMAT(Cast(RECURMAIN.TEX AS NUMERIC), '(##) #####-####')
                                                                         ELSE RECURMAIN.TEX
                                                                       END )
                              ELSE RECURMAIN.TEX
                            END), ''), 'Não informado')                 AS RESPFIN_TEL,
       SHABILITACAO.NOME                                                AS HABILITACAO,
       SCURSO.NOME                                                      AS CURSO,
       STURNO.NOME                                                      AS TURNO,
       SPLETIVO.CODPERLET                                               AS PERIODOLETIVO,
       CASE
         WHEN Day(SPLETIVO.DTINICIO) = 1 THEN FORMAT(SPLETIVO.DTINICIO, 'dº \de MMMM \de yyyy', 'pt-BR')
         ELSE FORMAT(SPLETIVO.DTINICIO, 'd \de MMMM \de yyyy', 'pt-BR')
       END                                                              AS PERIODOLETIVO_INI,
       CASE
         WHEN ( SCONTRATO.CODFILIAL = 17
                 OR SCONTRATO.CODFILIAL = 19 )
              AND SHABILITACAO.CODHABILITACAO = 'GP5' THEN FORMAT(DATEFROMPARTS(Year(SPLETIVO.DTINICIO), 12, 31), 'd \de MMMM \de yyyy', 'pt-BR')
         WHEN SCONTRATO.CODFILIAL = 20
              AND SHABILITACAO.CODHABILITACAO = 'GPF' THEN FORMAT(DATEFROMPARTS(Year(SPLETIVO.DTINICIO), 12, 31), 'd \de MMMM \de yyyy', 'pt-BR')
         WHEN Day(SPLETIVO.DTFIM) = 1 THEN FORMAT(SPLETIVO.DTFIM, 'dº \de MMMM \de yyyy', 'pt-BR')
         ELSE FORMAT(SPLETIVO.DTFIM, 'd \de MMMM \de yyyy', 'pt-BR')
       END                                                              AS PERIODOLETIVO_FIM,
       SPLANOPGTO.NOME                                                  AS PLANOPAGAMENTO_NOME,
       SPLANOPGTO.DESCRICAO                                             AS PLANOPAGAMENTO_DESCRICAO,
       FORMAT(Getdate(), 'd \de MMMM \de yyyy', 'pt-BR')                AS DIA/*,
        CASE
        WHEN TAE.RECCREATEDON IS NOT NULL THEN FORMAT(TAE.RECCREATEDON, 'dd/MM/yyyy')
        ELSE '(data do contrato não encontrada)'
        END     
                                                                                                                                              AS CONTRATO_DATA*/
       GIMAGEM.IMAGEM,
       CASE
         WHEN FILIAL.COD_FILIAL = 16 /* mdsp */
               OR FILIAL.COD_FILIAL = 18 /* emece */
               OR FILIAL.COD_FILIAL = 20 /* italo */ THEN 'Ensino Infantil, Ensino Fundamental e Ensino Médio'
         WHEN FILIAL.COD_FILIAL = 23 /* criem */
               OR FILIAL.COD_FILIAL = 19 /* claritas */
               OR FILIAL.COD_FILIAL = 21 /* mdsjc */
               OR FILIAL.COD_FILIAL = 22 /* mdsjc global */ THEN 'Ensino Infantil e Ensino Fundamental'
         ELSE ''
       END           AS fornece_niveis,
       CASE
         WHEN FILIAL.COD_FILIAL = 16 /* mdsp */
               OR FILIAL.COD_FILIALl = 18 /* emece */
               OR FILIAL.COD_FILIAL = 20 /* italo */ THEN 'a 3ª série do Ensino Médio'
         WHEN FILIAL.COD_FILIAL = 21 /* mdsjc */
               OR FILIAL.COD_FILIAL = 22 /* mdsjc global */ THEN 'o 9º ano do Ensino Fundamental Anos Finais'
         WHEN FILIAL.COD_FILIAL = 23 /* criem */
               OR FILIAL.COD_FILIAL = 19 /* claritas */ THEN 'o 5º ano do Ensino Fundamental Anos Iniciais'
         ELSE ''
       END      AS fornece_nivel_ultimo                                                                                                                                      
FROM   SCONTRATO (NOLOCK)
       LEFT JOIN SALUNO (NOLOCK)
              ON SCONTRATO.CODTIPOCURSO = SALUNO.CODTIPOCURSO
                 AND SCONTRATO.CODCOLIGADA = SALUNO.CODCOLIGADA
                 AND SCONTRATO.RA = SALUNO.RA
       LEFT JOIN PPESSOA (NOLOCK)
              ON SALUNO.CODPESSOA = PPESSOA.CODIGO
       LEFT JOIN PCODNACAO (NOLOCK)
              ON PPESSOA.NACIONALIDADE = PCODNACAO.CODCLIENTE
       LEFT JOIN FCFO (NOLOCK)
              ON SALUNO.CODCOLCFO = FCFO.CODCOLIGADA
                 AND SALUNO.CODCFO = FCFO.CODCFO
       LEFT JOIN PCODESTCIVIL (NOLOCK)
              ON FCFO.ESTADOCIVIL = PCODESTCIVIL.CODCLIENTE
       LEFT JOIN EPROFISS (NOLOCK)
              ON FCFO.CODPROF = EPROFISS.CODCLIENTE
       LEFT JOIN GMUNICIPIO (NOLOCK)
              ON FCFO.CODMUNICIPIO = GMUNICIPIO.CODMUNICIPIO
       LEFT JOIN SPLETIVO (NOLOCK)
              ON SCONTRATO.IDPERLET = SPLETIVO.IDPERLET
                 AND SCONTRATO.CODCOLIGADA = SPLETIVO.CODCOLIGADA
                 AND SCONTRATO.CODFILIAL = SPLETIVO.CODFILIAL
                 AND SCONTRATO.CODTIPOCURSO = SPLETIVO.CODTIPOCURSO
       LEFT JOIN SHABILITACAOFILIAL (NOLOCK)
              ON SCONTRATO.IDHABILITACAOFILIAL = SHABILITACAOFILIAL.IDHABILITACAOFILIAL
                 AND SCONTRATO.CODCOLIGADA = SHABILITACAOFILIAL.CODCOLIGADA
                 AND SCONTRATO.CODFILIAL = SHABILITACAOFILIAL.CODFILIAL
                 AND SCONTRATO.CODTIPOCURSO = SHABILITACAOFILIAL.CODTIPOCURSO
       LEFT JOIN SCURSO (NOLOCK)
              ON SHABILITACAOFILIAL.CODCURSO = SCURSO.CODCURSO
                 AND SCONTRATO.CODCOLIGADA = SCURSO.CODCOLIGADA
                 AND SCONTRATO.CODTIPOCURSO = SCURSO.CODTIPOCURSO
       LEFT JOIN SHABILITACAO (NOLOCK)
              ON SHABILITACAOFILIAL.CODHABILITACAO = SHABILITACAO.CODHABILITACAO
                 AND SHABILITACAOFILIAL.CODCURSO = SHABILITACAO.CODCURSO
                 AND SCONTRATO.CODCOLIGADA = SHABILITACAO.CODCOLIGADA
       LEFT JOIN STURNO (NOLOCK)
              ON SHABILITACAOFILIAL.CODTURNO = STURNO.CODTURNO
                 AND SCONTRATO.CODCOLIGADA = STURNO.CODCOLIGADA
                 AND SCONTRATO.CODFILIAL = STURNO.CODFILIAL
                 AND SCONTRATO.CODTIPOCURSO = STURNO.CODTIPOCURSO
       LEFT JOIN SPLANOPGTO (NOLOCK)
              ON SCONTRATO.IDPERLET = SPLANOPGTO.IDPERLET
                 AND SCONTRATO.CODPLANOPGTO = SPLANOPGTO.CODPLANOPGTO
                 AND SCONTRATO.CODCOLIGADA = SPLANOPGTO.CODCOLIGADA
                 AND SCONTRATO.CODTIPOCURSO = SPLANOPGTO.CODTIPOCURSO
       /*LEFT JOIN GINTEGRACAOTOTVSSIGN (NOLOCK) AS TAE
              ON SCONTRATO.CODCOLIGADA = Cast(LEFT(TAE.CHAVERM, 2) AS INTEGER)
                 AND SCONTRATO.IDPERLET = Cast(LEFT(RIGHT(TAE.CHAVERM, 8), 2) AS INTEGER)
                 AND SCONTRATO.CODCONTRATO = Cast(RIGHT(TAE.CHAVERM, 5) AS INTEGER)
                 AND SCONTRATO.RA = LEFT(RIGHT(TAE.CHAVERM, Len(TAE.CHAVERM) - 3), Charindex(';', TAE.CHAVERM, 4) - 4)*/
       LEFT JOIN RECURMAIN
              ON ( SCONTRATO.CODCOLIGADA = RECURMAIN.CODCOLIGADA
                    OR RECURMAIN.CODCOLIGADA = 0 )
                 AND SALUNO.CODCFO = RECURMAIN.CODCFO
                 AND BADCHARINDEX = 0
       OUTER APPLY(
            SELECT 
                SPLETIVO.CODFILIAL  AS COD_FILIAL
            FROM SPLETIVO (NOLOCK)
            WHERE SPLETIVO.IDPERLET = SCONTRATO.IDPERLET
       ) AS FILIAL

       LEFT JOIN GFILIAL (NOLOCK) 
            ON GFILIAL.CODCOLIGADA = SCONTRATO.CODCOLIGADA

       LEFT JOIN GIMAGEM (NOLOCK) 
              ON FILIAL.IDIMAGEM = GIMAGEM.ID
WHERE  SCONTRATO.CODCOLIGADA = :CODCOLIGADA1
       AND SCONTRATO.CODCONTRATO = :CODCONTRATO1
       AND SCONTRATO.IDPERLET = :IDPERLET1
       AND SCONTRATO.RA = :RA3






SELECT CASE
         WHEN ( SCONTRATO.CODFILIAL = 23
                 OR SCONTRATO.CODFILIAL = 19 )
              AND SHABILITACAO.CODHABILITACAO = 'GP5' THEN 'IV.1 - Todas as parcelas representativas da ANUIDADE deverão ser liquidadas em seus vencimentos, independentemente do comparecimento do ALUNO às aulas e/ou ainda nos meses em que não haja atividade escolar regulamentar.'
                                                           + Char(13) + Char(10) + Char(13) + Char(10)
                                                           + 'IV.2 - Estão inclusas na ANUIDADE: (i) uma oficina (atividade extracurricular sob consulta) e (ii) curso de férias programado pela ESCOLA e divulgado como incluso no valor da ANUIDADE.'
         WHEN SCONTRATO.CODFILIAL = 22 THEN 'IV.1 - Fica expressamente ajustado que para o ALUNO que ingressar na ESCOLA após o início do ANO LETIVO, a ANUIDADE será devida pelo CONTRATANTE na forma abaixo, a saber:'
                                            + Char(13) + Char(10)
                                            + 'a) Ingresso no mês de Janeiro ou  fevereiro: em 7 (sete) parcelas, com início de pagamento a partir do mês de ingresso e término em julho do mesmo ano; e'
                                            + Char(13) + Char(10)
                                            + 'b) Ingresso no mês de março: em 5 (cinco) parcelas, com início de pagamento a partir do mês de ingresso inclusive.'
                                            + Char(13) + Char(10) + Char(13) + Char(10)
                                            + 'IV.2 - Todas as parcelas representativas da ANUIDADE deverão ser liquidadas em seus vencimentos, independentemente do comparecimento do ALUNO às aulas e/ou ainda nos meses em que não haja atividade escolar regulamentar.'
                                            + Char(13) + Char(10) + Char(13) + Char(10)
                                            + 'IV.3 - Estão inclusas na ANUIDADE: Taekwondo ou ballet (sob consulta) divulgado(s) como incluso(s) no valor da ANUIDADE.'
         WHEN SHABILITACAO.CODHABILITACAO = 'GPF' THEN 'IV.1 - Fica expressamente ajustado que para o ALUNO que ingressar na ESCOLA após o início do ANO LETIVO, a ANUIDADE será devida pelo CONTRATANTE na forma abaixo, a saber:'
                                                       + Char(13) + Char(10)
                                                       + 'a) Ingresso no mês de Janeiro ou  fevereiro: em 7 (sete) parcelas, com início de pagamento a partir do mês de ingresso e término em julho do mesmo ano; e'
                                                       + Char(13) + Char(10)
                                                       + 'b) Ingresso no mês de março: em 5 (cinco) parcelas, com início de pagamento a partir do mês de ingresso inclusive.'
                                                       + Char(13) + Char(10) + Char(13) + Char(10)
                                                       + 'IV.2 - Todas as parcelas representativas da ANUIDADE deverão ser liquidadas em seus vencimentos, independentemente do comparecimento do ALUNO às aulas e/ou ainda nos meses em que não haja atividade escolar regulamentar.'
         ELSE 'IV.1 - Fica expressamente ajustado que para o ALUNO que ingressar na ESCOLA após o início do ANO LETIVO, a ANUIDADE será devida pelo CONTRATANTE na forma abaixo, a saber:'
              + Char(13) + Char(10)
              + 'a) Ingresso no mês de Janeiro ou  fevereiro: em 7 (sete) parcelas, com início de pagamento a partir do mês de ingresso e término em julho do mesmo ano; e'
              + Char(13) + Char(10)
              + 'b) Ingresso no mês de março: em 5 (cinco) parcelas, com início de pagamento a partir do mês de ingresso inclusive.'
              + Char(13) + Char(10) + Char(13) + Char(10)
              + 'IV.2 - Todas as parcelas representativas da ANUIDADE deverão ser liquidadas em seus vencimentos, independentemente do comparecimento do ALUNO às aulas e/ou ainda nos meses em que não haja atividade escolar regulamentar.'
              + Char(13) + Char(10) + Char(13) + Char(10)
              + 'IV.3 - Estão inclusas na ANUIDADE: (i) uma oficina (atividade extracurricular sob consulta) e (ii) curso de férias programado pela ESCOLA e divulgado como incluso no valor da ANUIDADE.'
       END                                             AS CLAUSULA_IV,
       SCONTRATO.CODCOLIGADA,
       SCONTRATO.RA,
       SCONTRATO.IDPERLET,
       (SELECT STEMPDADOSMATRICULAPORTAL.DADOSJSON
        FROM   STEMPDADOSMATRICULAPORTAL (NOLOCK)
        WHERE  STEMPDADOSMATRICULAPORTAL.CODCOLIGADA = :CODCOLIGADA
               AND STEMPDADOSMATRICULAPORTAL.IDPERLET = :IDPERLET
               AND STEMPDADOSMATRICULAPORTAL.RA = :RA) AS DADOS
       GIMAGEM.IMAGEM,
       CASE
         WHEN FILIAL.COD_FILIAL = 16 /* mdsp */
               OR FILIAL.COD_FILIAL = 18 /* emece */
               OR FILIAL.COD_FILIAL = 20 /* italo */ THEN 'Ensino Infantil, Ensino Fundamental e Ensino Médio'
         WHEN FILIAL.COD_FILIAL = 23 /* criem */
               OR FILIAL.COD_FILIAL = 19 /* claritas */
               OR FILIAL.COD_FILIAL = 21 /* mdsjc */
               OR FILIAL.COD_FILIAL = 22 /* mdsjc global */ THEN 'Ensino Infantil e Ensino Fundamental'
         ELSE ''
       END           AS fornece_niveis,
       CASE
         WHEN FILIAL.COD_FILIAL = 16 /* mdsp */
               OR FILIAL.COD_FILIALl = 18 /* emece */
               OR FILIAL.COD_FILIAL = 20 /* italo */ THEN 'a 3ª série do Ensino Médio'
         WHEN FILIAL.COD_FILIAL = 21 /* mdsjc */
               OR FILIAL.COD_FILIAL = 22 /* mdsjc global */ THEN 'o 9º ano do Ensino Fundamental Anos Finais'
         WHEN FILIAL.COD_FILIAL = 23 /* criem */
               OR FILIAL.COD_FILIAL = 19 /* claritas */ THEN 'o 5º ano do Ensino Fundamental Anos Iniciais'
         ELSE ''
       END      AS fornece_nivel_ultimo
FROM   SCONTRATO (NOLOCK)
       LEFT JOIN SHABILITACAOFILIAL (NOLOCK)
              ON SCONTRATO.IDHABILITACAOFILIAL = SHABILITACAOFILIAL.IDHABILITACAOFILIAL
                 AND SCONTRATO.CODCOLIGADA = SHABILITACAOFILIAL.CODCOLIGADA
                 AND SCONTRATO.CODFILIAL = SHABILITACAOFILIAL.CODFILIAL
                 AND SCONTRATO.CODTIPOCURSO = SHABILITACAOFILIAL.CODTIPOCURSO
       LEFT JOIN SHABILITACAO (NOLOCK)
              ON SHABILITACAOFILIAL.CODHABILITACAO = SHABILITACAO.CODHABILITACAO
                 AND SHABILITACAOFILIAL.CODCURSO = SHABILITACAO.CODCURSO
                 AND SCONTRATO.CODCOLIGADA = SHABILITACAO.CODCOLIGADA
       OUTER APPLY(
            SELECT 
                SPLETIVO.CODFILIAL  AS COD_FILIAL
            FROM SPLETIVO (NOLOCK)
            WHERE SPLETIVO.IDPERLET = SCONTRATO.IDPERLET
       ) AS FILIAL

       LEFT JOIN GFILIAL (NOLOCK) 
            ON GFILIAL.CODCOLIGADA = SCONTRATO.CODCOLIGADA

       LEFT JOIN GIMAGEM (NOLOCK) 
              ON FILIAL.IDIMAGEM = GIMAGEM.ID
WHERE  SCONTRATO.CODCOLIGADA = :CODCOLIGADA
       AND SCONTRATO.IDPERLET = :IDPERLET
       AND SCONTRATO.RA = :RA 
