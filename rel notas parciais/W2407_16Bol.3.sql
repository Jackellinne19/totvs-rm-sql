SELECT *,

CASE
    WHEN ITINERARIO = 2 THEN
        (
            (
                ISNULL(ITAD1,0) + ISNULL(ITAD2,0) +
                ISNULL(ITAD3,0) + ISNULL(ITAD4,0) +
                ISNULL(ITAD5,0) + ISNULL(ITAD6,0) +
                ISNULL(ITAD7,0) + ISNULL(ITAD8,0) +
                ISNULL(ITAD9,0) + ISNULL(ITAD10,0)
            ) / NULLIF(QTDE_ITAD_T1,0)
        ) + ISNULL(COMPORT_T1,0)

    WHEN TIPO_FUND = 'FUND1'
        (
            (
                ISNULL(AT1_T1,0)+ISNULL(AT2_T1,0)+ISNULL(AT3_T1,0)+ISNULL(AT4_T1,0)+ISNULL(AT5_T1,0)+
                ISNULL(AT6_T1,0)+ISNULL(AT7_T1,0)+ISNULL(AT8_T1,0)+ISNULL(AT9_T1,0)+ISNULL(AT10_T1,0)
            ) / NULLIF(QTDE_AT_T1,0)
        )

    ELSE
        (
            (
                ISNULL(AD1,0)+ISNULL(AD2,0)+ISNULL(AD3,0)+ISNULL(AD4,0)+ISNULL(AD5,0)
            ) / NULLIF(QTDE_AD_T1,0)
            + ISNULL(V1,0) + ISNULL(V2,0)
        ) / 4
        + ISNULL(COMPORTAMENTO_1,0)
        + ISNULL(GEEKIE_T1,0)
END AS PARCIAL_T1,

CASE
    WHEN ITINERARIO = 1 THEN
        (
            (
                ISNULL(ITAD1_T2,0)+ISNULL(ITAD2_T2,0)+ISNULL(ITAD3_T2,0)+ISNULL(ITAD4_T2,0)+
                ISNULL(ITAD5_T2,0)+ISNULL(ITAD6_T2,0)+ISNULL(ITAD7_T2,0)+ISNULL(ITAD8_T2,0)+
                ISNULL(ITAD9_T2,0)+ISNULL(ITAD10_T2,0)
            ) / NULLIF(QTDE_ITAD_T2,0)
        ) + ISNULL(COMPORT_T2,0)

    WHEN TIPO_FUND = 'FUND1'
        (
            (
                ISNULL(AT1_T2,0)+ISNULL(AT2_T2,0)+ISNULL(AT3_T2,0)+ISNULL(AT4_T2,0)+ISNULL(AT5_T2,0)+
                ISNULL(AT6_T2,0)+ISNULL(AT7_T2,0)+ISNULL(AT8_T2,0)+ISNULL(AT9_T2,0)+ISNULL(AT10_T2,0)
            ) / NULLIF(QTDE_AT_T2,0)
        )

    ELSE
        (
            (
                ISNULL(AD1_T2,0)+ISNULL(AD2_T2,0)+ISNULL(AD3_T2,0)+ISNULL(AD4_T2,0)+ISNULL(AD5_T2,0)
            ) / NULLIF(QTDE_AD_T2,0)
            + ISNULL(V1_T2,0) + ISNULL(V2_T2,0)
        ) / 4
        + ISNULL(COMPORTAMENTO_1_T2,0)
        + ISNULL(GEEKIE_T2,0)
END AS PARCIAL_T2,

CASE
    WHEN ITINERARIO = 2 THEN
        (
            (
                ISNULL(ITAD1_T3,0)+ISNULL(ITAD2_T3,0)+ISNULL(ITAD3_T3,0)+ISNULL(ITAD4_T3,0)+
                ISNULL(ITAD5_T3,0)+ISNULL(ITAD6_T3,0)+ISNULL(ITAD7_T3,0)+ISNULL(ITAD8_T3,0)+
                ISNULL(ITAD9_T3,0)+ISNULL(ITAD10_T3,0)
            ) / NULLIF(QTDE_ITAD_T3,0)
        ) + ISNULL(COMPORT_T3,0)

    WHEN TIPO_FUND = 'FUND1'
        (
            (
                ISNULL(AT1_T3,0)+ISNULL(AT2_T3,0)+ISNULL(AT3_T3,0)+ISNULL(AT4_T3,0)+ISNULL(AT5_T3,0)+
                ISNULL(AT6_T3,0)+ISNULL(AT7_T3,0)+ISNULL(AT8_T3,0)+ISNULL(AT9_T3,0)+ISNULL(AT10_T3,0)
            ) / NULLIF(QTDE_AT_T3,0)
        )

    ELSE
        (
            (
                ISNULL(AD1_T3,0)+ISNULL(AD2_T3,0)+ISNULL(AD3_T3,0)+ISNULL(AD4_T3,0)+ISNULL(AD5_T3,0)
            ) / NULLIF(QTDE_AD_T3,0)
            + ISNULL(V1_T3,0) + ISNULL(V2_T3,0)
        ) / 4
        + ISNULL(COMPORTAMENTO_1_T3,0)
        + ISNULL(GEEKIE_T3,0)
END AS PARCIAL_T3
              
FROM   (SELECT DISTINCT SDISCIPLINA.NOME             AS NOME_DISC,
                        Max(PERIODOLETIVO.CODPERLET) AS ANOLETIVO,
                        STURMADISC.CODTURMA          AS TURMA,
                        SNOTAS.CODCOLIGADA,
                        SNOTAS.IDTURMADISC,
                        SNOTAS.RA,
                        PPESSOA.NOME                       AS ALUNO_NOME,
                        PROF.PROFESSORES             AS PROFESSOR_NOME,
                        /*FUND I*/

                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2111
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL 
                            THEN SNOTAS.NOTA

                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2121
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL 
                            THEN SNOTAS.NOTA
                        END) AS AT1_T1,


                       MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2112
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA       
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2122
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                       END) AS AT2_T1,


                       MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2113
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2123
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                       END) AS AT3_T1,


                       MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2114
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2124
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                       END) AS AT4_T1,


                       MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2115
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2125
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                       END) AS AT5_T1,


                       MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                 AND SNOTAS.CODPROVA = 2116
                                 AND STURMADISC.CODTURNO IN (11,12)
                                 AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT6_T1,

                       MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2117
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                       END) AS AT7_T1,


                       MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2118
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                       END) AS AT8_T1,

                       MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2119
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                       END) AS AT9_T1,


                       MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 21110
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT10_T1,

                        COUNT(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA IN (2111,2112,2113,2114,2115,2116,2117,2118,2119,21110)
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL 
                            THEN 1
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA IN (2121,2122,2123,2124,2125)
                                   AND SNOTAS.NOTA IS NOT NULL 
                            THEN 1
                        END) AS QTDE_AT_T1,
                        
                        /*FUND I - T2*/

                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2211
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2221
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT1_T2,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2212
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2222
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                         END) AS AT2_T2,


                         MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2213
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2223
                                   AND STURMADISC.CODTURNO IN (11,12)
                            THEN SNOTAS.NOTA
                         END) AS AT3_T2,


                         MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2214
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2224
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                         END) AS AT4_T2,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2215
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2225
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT5_T2,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2216
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT6_T2,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2217
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT7_T2,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2218
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT8_T2,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2219
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT9_T2,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 22110
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT10_T2,


                            /* COUNT MAT/LPL - T2 */

                        COUNT(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA IN (2211,2212,2213,2214,2215,2216,2217,2218,2219,22110)
                                   AND STURMADISC.CODTURNO IN (11,12)
                            THEN 1
                            END)
                            +
                            COUNT(CASE
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA IN (2221,2222,2223,2224,2225)
                            THEN 1
                        END) AS QTDE_AT_T2,

                        /*FUND I - T3*/

                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2311
                                   AND SNOTAS.NOTA IS NOT NULL
                                   AND STURMADISC.CODTURNO IN (11,12)
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2321
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                         END) AS AT1_T3,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2312
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2322
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                         END) AS AT2_T3,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2313
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2323
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT3_T3,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2314
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2324
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT4_T3,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2315
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2325
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                         END) AS AT5_T3,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2316
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT6_T3,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2317
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT7_T3,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2318
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT8_T3,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 2319
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT9_T3,


                        MAX(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA = 23110
                                   AND STURMADISC.CODTURNO IN (11,12)
                                   AND SNOTAS.NOTA IS NOT NULL
                            THEN SNOTAS.NOTA
                        END) AS AT10_T3,

                            /* COUNT MAT/LPL - T3 */

                        COUNT(CASE
                            WHEN STURMADISC.CODDISC IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA IN (2311,2312,2313,2314,2315,2316,2317,2318,2319,23110)
                                   AND STURMADISC.CODTURNO IN (11,12)
                            THEN 1
                            WHEN STURMADISC.CODDISC NOT IN ('MAT','LPL')
                                   AND SNOTAS.CODPROVA IN (2321,2322,2323,2324,2325)
                            THEN 1
                        END) AS QTDE_AT_T3,

                        /*FUND II*/
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3111
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD1,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3112
                                     AND SNOTAS.NOTA IS NOT NULL ) THEN SNOTAS.NOTA
                            END)                     AS AD2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3113
                                     AND SNOTAS.NOTA IS NOT NULL ) THEN SNOTAS.NOTA
                            END)                     AS AD3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3114
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD4,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3115
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD5,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3121
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS V1,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3122
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS V2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3131
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS COMPORTAMENTO_1,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3141
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS GEEKIE_T1,
                        Count(CASE
                                WHEN SNOTAS.CODPROVA IN ( 3111, 3112, 3113, 3114, 3115 ) THEN SNOTAS.NOTA
                              END)                   AS QTDE_AD_T1,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3211
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD1_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3212
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD2_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3213
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD3_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3214
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD4_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3215
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD5_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3221
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS V1_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3222
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS V2_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3231
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS COMPORTAMENTO_1_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3241
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS GEEKIE_T2,
                        Count(CASE
                                WHEN SNOTAS.CODPROVA IN ( 3211, 3212, 3213, 3214, 3215 ) THEN SNOTAS.NOTA
                              END)                   AS QTDE_AD_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3311
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD1_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3312
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD2_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3313
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD3_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3314
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD4_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3315
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS AD5_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3321
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS V1_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3322
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS V2_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3331
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS COMPORTAMENTO_1_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 3341
                                     AND SNOTAS.NOTA IS NOT NULL )THEN SNOTAS.NOTA
                            END)                     AS GEEKIE_T3,
                        Count(CASE
                                WHEN SNOTAS.CODPROVA IN ( 3311, 3312, 3313, 3314, 3315 ) THEN SNOTAS.NOTA
                              END)                   AS QTDE_AD_T3,
                        /*ITINERARIOS*/
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2111
                                     AND SNOTAS.NOTA IS NOT NULL 
                                     AND STURMADISC.CODTURNO IN (15,16))THEN SNOTAS.NOTA
                            END)                     AS ITAD1,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2112
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2113
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2114
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD4,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2115
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD5,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2116
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD6,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2117
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD7,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2118
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD8,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2119
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD9,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 21110
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD10,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2121
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS REC_T1,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2131
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS COMPORT_T1,
                        Count(CASE
                                WHEN SNOTAS.CODPROVA IN ( 2111, 2112, 2113, 2114,
                                                          2115, 2116, 2117, 2118,
                                                          2119, 21110)
                                                         AND STURMADISC.CODTURNO IN (15,16) THEN SNOTAS.NOTA
                              END)                   AS QTDE_ITAD_T1,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2211
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD1_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2212
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD2_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2213
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD3_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2214
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD4_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2215
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD5_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2216
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD6_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2217
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD7_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2218
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD8_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2219
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD9_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 22110
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD10_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2221
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS REC_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2231
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS COMPORT_T2,
                        Count(CASE
                                WHEN SNOTAS.CODPROVA IN ( 2211, 2212, 2213, 2214,
                                                          2215, 2216, 2217, 2218,
                                                          2219, 22110)
                                                          AND STURMADISC.CODTURNO IN (15,16) THEN SNOTAS.NOTA
                              END)                   AS QTDE_ITAD_T2,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2311
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD1_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2312
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD2_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2313
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD3_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2314
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD4_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2315
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD5_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2316
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD6_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2317
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD7_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2318
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD8_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2319
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD9_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 23110
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS ITAD10_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2321
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS REC_T3,
                        Max(CASE
                              WHEN ( SNOTAS.CODPROVA = 2331
                                     AND SNOTAS.NOTA IS NOT NULL
                                     AND STURMADISC.CODTURNO IN (15,16) )THEN SNOTAS.NOTA
                            END)                     AS COMPORT_T3,
                        Count(CASE
                                WHEN SNOTAS.CODPROVA IN ( 2311, 2312, 2313, 2314,
                                                          2315, 2316, 2317, 2318,
                                                          2319, 23110)
                                                          AND STURMADISC.CODTURNO IN (15,16) THEN SNOTAS.NOTA
                              END)                   AS QTDE_ITAD_T3,
                        CASE
                          WHEN STURMADISC.CODDISC IN ( 'Contemporary Physics', 'Contemporary Chemist', 'ATL', 'FIC',
                                                       'GPT', 'HSA', 'HSN', 'Math',
                                                       'Natural History', 'PBL', 'PJV', 'QCP',
                                                       'RDA', 'RDG' ) THEN 2
                          ELSE 1
                        END                          ITINERARIO,

                        CASE
                            WHEN MAX(STURMADISC.CODTURNO) IN (11,12)
                            THEN 'FUND1'

                            WHEN MAX(STURMADISC.CODTURNO) IN (13,14)
                            THEN 'FUND2'

                            WHEN MAX(STURMADISC.CODTURNO) IN (15,16)
                            THEN 'EM'

                        END AS TIPO_FUND
        
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
                            AND STURMADISC.CODDISC NOT IN ( 'Contemporary Physics', 'Contemporary Chemist', 'ATL', 'FIC',
                                                       'GPT', 'HSA', 'HSN', 'Math',
                                                       'Natural History', 'PBL', 'PJV', 'QCP',
                                                       'RDA', 'RDG' )
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
                  STURMADISC.CODTURMA)p 
