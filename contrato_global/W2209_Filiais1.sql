SELECT /*s.nome                                                  AS descricao,*/ SPARCPLANO.parcela,
                                                                                 SPARCPLANO.valor                              AS valor_s_desconto,
                                                                                 FORMAT(SPARCPLANO.dtvencimento, 'dd/MM/yyyy') AS dtvencimento,
                                                                                 FORMAT(SPARCPLANO.dtcompetencia, 'MM/yyyy')   AS dtcompetencia
/*Sum(ba.desconto)                                        AS desconto,
p.valor * ( 100 - COALESCE(Sum(ba.desconto), 0) ) / 100 AS valor_c_desconto*/

FROM   SPARCPLANO (NOLOCK) /* Parcelas do Plano de Pagamento */
       LEFT JOIN SPLANOPGTO (NOLOCK) /* Plano de Pagamento */
              /* Relações de chaves entre SPARCPLANO e SPLANOPGTO */
              ON SPARCPLANO.CODCOLIGADA = SPLANOPGTO.CODCOLIGADA /* Código da Coligada - Código da Coligada */
                 AND SPARCPLANO.IDPERLET = SPLANOPGTO.IDPERLET /* Identificador do Período Letivo - Identificador do Período Letivo */
                 AND SPARCPLANO.CODPLANOPGTO = SPLANOPGTO.CODPLANOPGTO /* Código do Plano de Pagamento - Código do Plano de Pagamento */
       INNER JOIN STEMPDADOSMATRICULAPORTAL STMP
        	  ON STMP.CODCOLIGADA = SPARCPLANO.CODCOLIGADA

WHERE  SPARCPLANO.codcoligada = :CODCOLIGADA
       AND SPARCPLANO.idperlet = :IDPERLET
      AND SPARCPLANO.codplanopgto = JSON_VALUE(STMP.SDADOS,
'$.SDADOSFINANCEIROS[0].CODPLANOPAGAMENTOSELECIONADO')



SELECT /*s.nome                                                  AS descricao,*/ SPARCPLANO.parcela,
                                                                                 SPARCPLANO.valor                              AS valor_s_desconto,
                                                                                 FORMAT(SPARCPLANO.dtvencimento, 'dd/MM/yyyy') AS dtvencimento,
                                                                                 FORMAT(SPARCPLANO.dtcompetencia, 'MM/yyyy')   AS dtcompetencia
/*Sum(ba.desconto)                                        AS desconto,
p.valor * ( 100 - COALESCE(Sum(ba.desconto), 0) ) / 100 AS valor_c_desconto*/

FROM   SPARCPLANO (NOLOCK) /* Parcelas do Plano de Pagamento */
       LEFT JOIN SPLANOPGTO (NOLOCK) /* Plano de Pagamento */
              /* Relações de chaves entre SPARCPLANO e SPLANOPGTO */
              ON SPARCPLANO.CODCOLIGADA = SPLANOPGTO.CODCOLIGADA /* Código da Coligada - Código da Coligada */
                 AND SPARCPLANO.IDPERLET = SPLANOPGTO.IDPERLET /* Identificador do Período Letivo - Identificador do Período Letivo */
                 AND SPARCPLANO.CODPLANOPGTO = SPLANOPGTO.CODPLANOPGTO /* Código do Plano de Pagamento - Código do Plano de Pagamento */

WHERE  SPARCPLANO.codcoligada = :CODCOLIGADA
       AND SPARCPLANO.idperlet = :IDPERLET
      AND SPARCPLANO.codplanopgto = :CODPLANO