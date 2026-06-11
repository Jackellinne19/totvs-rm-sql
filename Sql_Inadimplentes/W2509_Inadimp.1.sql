SELECT
		VALORES.VALORLIQUIDO,
		VALORES.VALORATUALIZADO,
        FCFO.NOME                     AS RESPFIN_NOME,
        PPESSOA.NOME                  AS NOME_ALUNO,
        MES.MES_EXTENSO               AS MES_REFERENTE,
        FLAN.DATAVENCIMENTO           AS VENCIMENTO,
        FBOLETO.IPTE                  AS CODBOLETO,

        Ltrim(Rtrim(PPESSOA.CODIGO))  AS ALUNO_ID,
      (
    SELECT
        'Pendência de Pagamento' AS titulo,
        (
            '<div style="font-family: Arial, Helvetica Neue, Helvetica, sans-serif; max-width: 600px; margin: 20px auto; background-color: #ffffff; border: 1px solid #ddd; border-radius: 8px; padding: 25px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">' +
            '<h3 style="font-size: 20px; color: #d9534f; margin-top: 0; text-align: center;">Atenção: Boleto Vencido</h3>' +
            '<p style="font-size: 16px; color: #333; line-height: 1.6;">Prezado(a) ' + FCFO.NOME + ',</p>' +
            '<p style="font-size: 16px; color: #333; line-height: 1.6;">Identificamos em nosso sistema que o seu boleto referente à mensalidade de ' + MES.MES_EXTENSO + ', com vencimento em <strong>' +
                FORMAT(FLAN.DATAVENCIMENTO, 'dd/MM/yyyy') +
            '</strong>, ainda está com o pagamento em aberto.</p>' +
            '<div style="background-color: #fff9e6; border-left: 4px solid #ffc107; padding: 15px; margin: 20px 0; font-size: 15px;">' +
                '<p style="margin: 0;"><strong>Detalhes da Fatura:</strong></p>' +
                '<ul style="margin-top: 10px; padding-left: 20px;">' +
                    '<li>Valor Original: <s> R$ ' +
                        CONVERT(VARCHAR(20), REPLACE(VALORES.VALORLIQUIDO, '.', ',')) +
                    '</s></li>' +
                    '<li>Valor Atualizado: <u>' +
                        CONVERT(VARCHAR(20), REPLACE(VALORES.VALORATUALIZADO, '.', ',')) +
                    '</u></li>' +
                    '<li>Status: <em>Aguardando Pagamento</em></li>' +
                '</ul>' +
            '</div>' +
            '<p style="font-size: 16px; color: #333; line-height: 1.6;">Para evitar o bloqueio de acesso à plataforma, por favor, realize o pagamento através do link abaixo. O boleto já foi atualizado com os valores corrigidos.</p>' +
            '<p style="text-align: center; margin: 30px 0;">' +
                '<a href="https://seu_link_de_pagamento_aqui.com" target="_blank" style="background-color: #28a745; color: #ffffff; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-size: 16px; font-weight: bold; display: inline-block;">Pagar Boleto Agora</a>' +
            '</p>' +
            '<hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">' +
            '<p style="font-size: 12px; color: #777; text-align: center;">Se o pagamento já foi realizado, por favor, desconsidere esta mensagem. A baixa bancária pode levar até 48 horas úteis.</p>' +
            '</div>'
        ) AS mensagem1
    FROM FLAN AS FLAN_ALIAS
    WHERE FLAN_ALIAS.ID = FLAN.ID

    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
) AS TEXTO1,

(
    SELECT
        'Pendência de Pagamento 2' AS titulo2,
        (
            '<div style="font-family: Arial, Helvetica Neue, Helvetica, sans-serif; max-width: 600px; margin: 20px auto; background-color: #ffffff; border: 1px solid #e5e5e5; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.08);">' +

            '<div style="padding:25px 25px 10px 25px; text-align:center;">' +

            '<h2 style="color:#d9534f; margin:0; font-size:28px; font-weight:bold;">' +
            'Atenção: Boleto Vencido' +
            '</h2>' +

            '</div>' +

            '<div style="padding:30px;">' +

            '<p style="font-size:16px; color:#333; line-height:1.7; margin-top:0;">' +
            'Prezado(a) <strong>' + FCFO.NOME + '</strong>,' +
            '</p>' +

            '<p style="font-size:16px; color:#555; line-height:1.7;">' +
            'Identificamos que o boleto referente à mensalidade de <strong>' + MES.MES_EXTENSO + '</strong>, com vencimento em <strong>' +
            FORMAT(FLAN.DATAVENCIMENTO, 'dd/MM/yyyy') +
            '</strong>, ainda está pendente.' +
            '</p>' +

            '<div style="background:#fff8e5; border:1px solid #ffe08a; border-radius:10px; padding:20px; margin:25px 0;">' +

            '<p style="font-size:16px; color:#333; line-height:1.6; text-align:center;">' +
            'Para evitar o bloqueio de acesso à plataforma, por favor, realize o pagamento.' +
            '</p>' +

            '<p style="text-align:center; margin:25px 0;">' +

            '<button onclick="document.getElementById(''areaCodigo'').style.display=''block''; document.getElementById(''codigoBoleto'').focus(); document.getElementById(''codigoBoleto'').select();" ' +
            'style="background:#28a745; color:#ffffff; border:none; padding:14px 28px; border-radius:8px; font-size:16px; font-weight:bold; cursor:pointer;">' +

            'Pagar Boleto' +

            '</button>' +

            '</p>' +

            '<div id="areaCodigo" style="display:none;">' +

            '<textarea id="codigoBoleto" readonly style="width:100%; height:95px; border:1px solid #ddd; border-radius:8px; padding:15px; font-size:15px; resize:none; font-family:Courier New; color:#333; background:#ffffff;">' +
            FBOLETO.IPTE +
            '</textarea>' +

            '<p style="font-size:13px; color:#888; margin-bottom:0; margin-top:10px; text-align:center;">' +
            'O código foi selecionado automaticamente.' +
            '</p>' +

            '</div>' +

            '</div>' +

            '<div style="text-align:center; margin-top:30px;">' +

            '<p style="font-size:15px; color:#555; margin-bottom:8px;">' +
            'Dúvidas? Fale conosco:' +
            '</p>' +

            '<p style="font-size:20px; font-weight:bold; color:#28a745; margin:0;">' +
            '(11) 99800-8094' +
            '</p>' +

            '</div>' +

            '<p style="font-size:12px; color:#999; text-align:center; margin-top:35px; line-height:1.6;">' +
            'Se o pagamento já foi realizado, desconsidere esta mensagem.<br>' +
            'A compensação bancária pode levar até 48 horas úteis.' +
            '</p>' +

            '</div>' +

            '</div>'
        ) AS mensagem2
    FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
) AS TEXTO2,

SPARCELA.PARCELA
    
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
                 AND scontrato.CODFILIAL = FLAN.CODFILIAL
       LEFT JOIN FCXA (NOLOCK)
              ON FLAN.CODCOLCXA = FCXA.CODCOLIGADA
                 AND FLAN.CODCXA = FCXA.CODCXA
                 AND SCONTRATO.CODFILIAL = FCXA.CODFILIAL
       LEFT JOIN FCONVENIO (NOLOCK)
              ON FLAN.CODCOLIGADA = FCONVENIO.CODCOLIGADA
                 AND FLAN.IDCONVENIO = FCONVENIO.IDCONVENIO
       LEFT JOIN SPLETIVO (NOLOCK)
              ON SCONTRATO.CODCOLIGADA = SPLETIVO.CODCOLIGADA
                 AND SCONTRATO.IDPERLET = SPLETIVO.IDPERLET
                 AND SCONTRATO.CODFILIAL = SPLETIVO.CODFILIAL
       LEFT JOIN GCOLIGADA (NOLOCK)
              ON SCONTRATO.CODCOLIGADA = GCOLIGADA.CODCOLIGADA
       LEFT JOIN GBANCO (NOLOCK)
              ON FLAN.CNABBANCO = GBANCO.NUMBANCO
       LEFT JOIN FCFO (NOLOCK)
              ON FLAN.CODCOLCFO = FCFO.CODCOLIGADA
                 AND FLAN.CODCFO = FCFO.CODCFO
                 AND SALUNO.CODCOLCFO = FCFO.CODCOLIGADA
                 AND SALUNO.CODCFO = FCFO.CODCFO
       LEFT JOIN FBOLETO (NOLOCK)
                ON FCFO.CODCOLIGADA = FBOLETO.CODCOLSACADO 
                AND FCFO.CODCFO = FBOLETO.SACADO 
                AND FLAN.IDBOLETO = FBOLETO.IDBOLETO
       LEFT JOIN SPLANOPGTO (NOLOCK)
              ON SCONTRATO.CODCOLIGADA = SPLANOPGTO.CODCOLIGADA
                 AND SPLANOPGTO.CODPLANOPGTO = SCONTRATO.CODPLANOPGTO
                 AND scontrato.idperlet = splanopgto.idperlet
       LEFT JOIN SMATRICPL (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = SCONTRATO.CODCOLIGADA
                 AND SMATRICPL.IDPERLET = SCONTRATO.IDPERLET
                 AND SMATRICPL.IDHABILITACAOFILIAL = SCONTRATO.IDHABILITACAOFILIAL
                 AND SMATRICPL.RA = SCONTRATO.RA
                 AND SCONTRATO.CODFILIAL = SMATRICPL.CODFILIAL
       LEFT JOIN SSTATUS (NOLOCK)
              ON SMATRICPL.CODCOLIGADA = SSTATUS.CODCOLIGADA
                 AND SMATRICPL.CODSTATUS = SSTATUS.CODSTATUS

       CROSS APPLY (
            SELECT 
                CASE MONTH(FLAN.DATAVENCIMENTO)
                    WHEN 1 THEN 'janeiro'
                    WHEN 2 THEN 'fevereiro'
                    WHEN 3 THEN 'março'
                    WHEN 4 THEN 'abril'
                    WHEN 5 THEN 'maio'
                    WHEN 6 THEN 'junho'
                    WHEN 7 THEN 'julho'
                    WHEN 8 THEN 'agosto'
                    WHEN 9 THEN 'setembro'
                    WHEN 10 THEN 'outubro'
                    WHEN 11 THEN 'novembro'
                    WHEN 12 THEN 'dezembro'
                END AS MES_EXTENSO
) MES
        CROSS APPLY (
            SELECT
                CAST(
                    CASE
                        WHEN FLAN.STATUSLAN = 0 
                        AND CAST(GETDATE() - FLAN.DATAVENCIMENTO AS INT) > 0 
                        THEN 
                            (FLAN.VALORORIGINAL +
                            FLAN.VALORACRESCIMOACORDO +
                            FLAN.VALORJUROSACORDO -
                            FLAN.VALORDESCONTOACORDO)
                            +
                            (
                                (
                                    (FLAN.VALORORIGINAL +
                                    FLAN.VALORACRESCIMOACORDO +
                                    FLAN.VALORJUROSACORDO -
                                    FLAN.VALORDESCONTOACORDO) * (0.01 / 30)
                                ) * CAST(GETDATE() - FLAN.DATAVENCIMENTO AS INT)
                            )
                            +
                            (FLAN.VALORORIGINAL * 0.02)
                        ELSE 
                            (FLAN.VALORORIGINAL +
                            FLAN.VALORACRESCIMOACORDO +
                            FLAN.VALORJUROSACORDO -
                            FLAN.VALORDESCONTOACORDO -
                            FLAN.VALORDESCONTO -
                            FLAN.VALOROP3)
                    END
                AS NUMERIC(10,2)) AS VALORLIQUIDO,

                CAST(
                    (FLAN.VALORORIGINAL - (FLAN.VALORDESCONTO + FLAN.VALOROP3))
                AS NUMERIC(10,2)) AS VALORATUALIZADO
) VALORES
WHERE  FLAN.PAGREC = 1
       AND flan.statuslan NOT IN ( '1', '2' )
       AND SMATRICPL.CODCOLIGADA = :$CODCOLIGADA
       AND SMATRICPL.CODFILIAL = :COD_FILIAL
       AND FLAN.DATAVENCIMENTO >= DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
       AND FLAN.DATAVENCIMENTO <= GETDATE() 
       AND (SSERVIÇO.NOME LIKE '%GLOBAL PROGRAM%'
        OR LIKE '%MENSALIDADE%')
ORDER  BY SCONTRATO.CODCOLIGADA,
          SCONTRATO.IDPERLET,
          SCONTRATO.CODCONTRATO,
          SCONTRATO.RA,
          FLAN.IDBOLETO 