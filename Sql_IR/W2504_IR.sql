

SELECT q.*
FROM   (SELECT GIMAGEM.IMAGEM                                                  AS LOGO,
               GCOLIGADA.NOMEFANTASIA                                          AS FANTASIA,
               GCOLIGADA.NOME                                                  AS RAZAO_SOCIAL,
               GCOLIGADA.CGC                                                   AS CGC,
               GFILIAL.NOMEFANTASIA                                            AS FANTASIA_FILIAL,
               GFILIAL.NOME                                                    AS RAZAO_SOCIAL_FILIAL,
               GFILIAL.CGC                                                     AS CGC_FILIAL,
               SCONTRATO.CODCOLIGADA,
               SCONTRATO.RA,
               SCONTRATO.IDPERLET,
               SCONTRATO.CODCONTRATO,
               FLAN.DATAPAG,
               FLAN.DATABAIXA,
               FLAN.DATAVENCIMENTO,
               FLAN.VALORBAIXADO,
               ( FLAN.VALORORIGINAL - ( FLAN.VALORDESCONTO + FLAN.VALOROP3 ) )   AS VALOR,
               RESP.RESP_CPF                                                     AS RESP_CPF,
               RESP.RESP_NOME                                                    AS RESP_NOME,
               SPLETIVO.CODPERLET									   			 AS PERIODO_LETIVO,
               /*
               FCFO.RUA,
               FCFO.NUMERO,
               FCFO.COMPLEMENTO,
               FCFO.BAIRRO,
               FCFO.CIDADE,
               FCFO.CODETD,
               FCFO.CEP,
               FCFO.EMAIL,
               FLAN.HISTORICO,
               */
               PPESSOA.NOME                                                    AS ALUNO_NOME,
               PPESSOA.NOMESOCIAL                                              AS ALUNO_NOMESOCIAL,
               SALUNO.RA                                                       AS ALUNO_RA,
               SSERVICO.NOME                                                   AS SERVICO,
               sparcela.parcela
        FROM   SCONTRATO (NOLOCK)
               LEFT JOIN SPARCELA (NOLOCK)
                      ON SCONTRATO.CODCOLIGADA = SPARCELA.CODCOLIGADA
                         AND SCONTRATO.RA = SPARCELA.RA
                         AND SCONTRATO.IDPERLET = SPARCELA.IDPERLET
                         AND SCONTRATO.CODCONTRATO = SPARCELA.CODCONTRATO
               LEFT JOIN SSERVICO (NOLOCK)
                      ON SCONTRATO.CODCOLIGADA = SSERVICO.CODCOLIGADA
                         AND SPARCELA.codservico = sservico.codservico
               LEFT JOIN SALUNO (NOLOCK)
                      ON SCONTRATO.CODCOLIGADA = SALUNO.CODCOLIGADA
                         AND SCONTRATO.RA = SALUNO.RA
               LEFT JOIN PPESSOA (NOLOCK)
                      ON SALUNO.CODPESSOA = PPESSOA.CODIGO
               LEFT JOIN SLAN (NOLOCK)
                      ON SPARCELA.CODCOLIGADA = SLAN.CODCOLIGADA
                         AND SPARCELA.IDPARCELA = SLAN.IDPARCELA
               LEFT JOIN FLAN (NOLOCK)
                      ON SLAN.CODCOLIGADA = FLAN.CODCOLIGADA
                         AND SLAN.IDLAN = FLAN.IDLAN
                         AND scontrato.codfilial = flan.codfilial
               LEFT JOIN FCXA (NOLOCK)
                      ON FLAN.CODCOLCXA = FCXA.CODCOLIGADA
                         AND FLAN.CODCXA = FCXA.CODCXA
                         AND scontrato.codfilial = fcxa.codfilial
               LEFT JOIN FCONVENIO (NOLOCK)
                      ON FLAN.CODCOLIGADA = FCONVENIO.CODCOLIGADA
                         AND FLAN.IDCONVENIO = FCONVENIO.IDCONVENIO
               LEFT JOIN SPLETIVO (NOLOCK)
                      ON SCONTRATO.CODCOLIGADA = SPLETIVO.CODCOLIGADA
                         AND SCONTRATO.IDPERLET = SPLETIVO.IDPERLET
                         AND scontrato.codfilial = spletivo.codfilial
               LEFT JOIN GCOLIGADA (NOLOCK)
                      ON SCONTRATO.CODCOLIGADA = GCOLIGADA.CODCOLIGADA
               LEFT JOIN GFILIAL (NOLOCK)
                      ON SCONTRATO.CODCOLIGADA = GFILIAL.CODCOLIGADA
                         AND GFILIAL.CODFILIAL = FLAN.CODFILIAL
               LEFT JOIN GBANCO (NOLOCK)
                      ON FLAN.CNABBANCO = GBANCO.NUMBANCO
               LEFT JOIN SPLANOPGTO (NOLOCK)
                      ON SCONTRATO.CODCOLIGADA = SPLANOPGTO.CODCOLIGADA
                         AND SPLANOPGTO.CODPLANOPGTO = SCONTRATO.CODPLANOPGTO
                         AND scontrato.idperlet = splanopgto.idperlet
               LEFT JOIN GIMAGEM (NOLOCK)
                      ON GFILIAL.IDIMAGEM = GIMAGEM.ID
               OUTER APPLY (
                     SELECT 
                            FCFO.NOME   AS RESP_NOME,
                            FCFO.CGCCFO AS RESP_CPF
                     FROM FCFO (NOLOCK)
                     WHERE FLAN.CODCOLCFO = FCFO.CODCOLIGADA
	                     AND FLAN.CODCFO    = FCFO.CODCFO
	                     ) AS RESP
             
          
        WHERE  FLAN.STATUSLAN <> 2
               AND FLAN.PAGREC = 1
               AND FLAN.CODAPLICACAO = 'S'
               AND FLAN.DATABAIXA >= '2025-01-01'	   
               AND FLAN.DATABAIXA <= '2025-12-31' 
               AND SCONTRATO.RA = :RA3
               AND SCONTRATO.IDPERLET = :IDPERLET1
               AND SCONTRATO.CODCOLIGADA = :CODCOLIGADA1
	        AND SCONTRATO.CODCONTRATO = :CODCONTRATO1
               AND ( SSERVICO.NOME LIKE '%Mensalidade%'
                      OR SSERVICO.NOME LIKE '%Global%'
                      OR SSERVICO.NOME LIKE '%Técnico%'
                      OR SSERVICO.NOME LIKE '%Global Program%'
                      OR SSERVICO.NOME LIKE '%Integral%'
                      OR SSERVICO.NOME LIKE '%Curso Técnico%'
                      OR SSERVICO.NOME LIKE '%QA%'
                      OR SSERVICO.NOME LIKE '%Anuidade%'
                      OR SSERVICO.NOME LIKE '%Oficina%'
                      OR SSERVICO.NOME LIKE '%Semanal%'
                      OR SSERVICO.NOME LIKE '%Transporte%'
                      OR SSERVICO.NOME LIKE '%Dependência%'
                      OR SSERVICO.NOME LIKE '%Carteira%'
                      OR SSERVICO.NOME LIKE '%Nucleo%'
                      OR SSERVICO.NOME LIKE '%Passeio%'
                      OR SSERVICO.NOME LIKE '%Estudo do Meio%'
                      OR SSERVICO.NOME LIKE '%Excursão%'
                      OR SSERVICO.NOME LIKE '%Substitutiva%'
                      OR SSERVICO.NOME LIKE '%Histórico%'
                      OR SSERVICO.NOME LIKE '%Formatura%'
                      OR SSERVICO.NOME LIKE '%Acampamento%'
                      OR SSERVICO.NOME LIKE '%Sítio%'
                      OR SSERVICO.NOME LIKE '%Fantasia%'
                      OR SSERVICO.NOME LIKE '%Noite%'
                      OR SSERVICO.NOME LIKE '%Material%'
                      OR SSERVICO.NOME LIKE '%Chromebook%'
                      OR SSERVICO.NOME LIKE '%Celular%'
                      OR SSERVICO.NOME LIKE '%Reserva de Vaga%'
                      OR SSERVICO.NOME LIKE '%RV%'
                      OR SSERVICO.NOME LIKE '%Pré Reserva%'
                      OR SSERVICO.NOME LIKE '%Fidelidade%'
                      OR SSERVICO.NOME LIKE '%Férias%'
                      OR SSERVICO.NOME LIKE '%Livro%' )
               AND ( NOT FLAN.HISTORICO LIKE 'Acordo:%'
                     AND NOT FLAN.HISTORICO LIKE 'Parcelamento:%' )
               AND ( FLAN.VALORORIGINAL - ( FLAN.VALORDESCONTO + FLAN.VALOROP3 ) ) > 0) AS q

ORDER  BY RESP_NOME,
          ALUNO_NOME,
          SERVICO,
          DATABAIXA
