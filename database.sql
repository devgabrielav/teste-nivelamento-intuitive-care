-- Queries para estruturar tabelas necessárias

CREATE TABLE `demonstracoes_contabeis` (
    `DATA` DATE,
    `REG_ANS` INT,
    `CD_CONTA_CONTABIL` VARCHAR(20),
    `DESCRICAO` VARCHAR(500),
    `VL_SALDO_INICIAL` DECIMAL(20,2),
    `VL_SALDO_FINAL` DECIMAL(20,2)
);

CREATE TABLE `relatorio_cadop` (
    `Registro_ANS` INT,
    `CNPJ` VARCHAR(20),
    `Razao_Social` VARCHAR(200),
    `Nome_Fantasia` VARCHAR(200),
    `Modalidade` VARCHAR(200),
    `Logradouro` VARCHAR(200),
    `Numero` VARCHAR(200),
    `Complemento` VARCHAR(200),
    `Bairro` VARCHAR(200),
    `Cidade` VARCHAR(200),
    `UF` VARCHAR(2),
    `CEP` VARCHAR(10),
    `DDD` VARCHAR(2),
    `Telefone` VARCHAR(20),
    `Fax` VARCHAR(20),
    `Endereco_eletronico` VARCHAR(200),
    `Representante` VARCHAR(200),
    `Cargo_Representante` VARCHAR(200),
    `Regiao_de_Comercializacao` INT, 
    `Data_Registro_ANS` DATE
);

-- Queries para importar o conteúdo dos arquivos

LOAD DATA LOCAL INFILE './files/1T2023.csv' -- Mudando o nome do arquivo de acordo
INTO TABLE demonstracoes_contabeis
FIELDS TERMINATED BY ';'  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS
(@`DATA`, @REG_ANS, @CD_CONTA_CONTABIL, @DESCRICAO, @VL_SALDO_INICIAL, @VL_SALDO_FINAL)
SET
    `DATA` = CASE
        WHEN @`DATA` LIKE '%/%' THEN STR_TO_DATE(@`DATA`, '%d/%m/%Y')
        ELSE STR_TO_DATE(@`DATA`, '%Y-%m-%d')
    END,
    REG_ANS = @REG_ANS,
    CD_CONTA_CONTABIL = @CD_CONTA_CONTABIL,
    DESCRICAO = @DESCRICAO,
    VL_SALDO_INICIAL = REPLACE(REPLACE(@VL_SALDO_INICIAL, '.', ''), ',', '.'), 
    VL_SALDO_FINAL = REPLACE(REPLACE(@VL_SALDO_FINAL, '.', ''), ',', '.');

LOAD DATA LOCAL INFILE './files/Relatorio_cadop.csv'
INTO TABLE relatorio_cadop
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS
(Registro_ANS, CNPJ, Razao_Social, Nome_Fantasia, Modalidade, Logradouro, Numero, 
 Complemento, Bairro, Cidade, UF, CEP, DDD, Telefone, Fax, Endereco_eletronico, 
 Representante, Cargo_Representante, @Regiao, Data_Registro_ANS)
SET Regiao_de_Comercializacao = NULLIF(@Regiao, '');

-- Respostas para as perguntas
  -- Quais as 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre?
  /* 
    Razao_Social                                                TOTAL_DESPESAS
    "BRADESCO SAÚDE S.A."                                       30941701628.46
    "SUL AMERICA COMPANHIA DE SEGURO SAÚDE"                     21124940442.30
    "AMIL ASSISTÊNCIA MÉDICA INTERNACIONAL S.A."                20820818085.36
    "NOTRE DAME INTERMÉDICA SAÚDE S.A."                         9307980465.62
    "HAPVIDA ASSISTENCIA MEDICA S.A."                           7755562753.15
    "CAIXA DE ASSISTÊNCIA DOS FUNCIONÁRIOS DO BANCO DO BRASIL"  7459368017.21
    "UNIMED NACIONAL - COOPERATIVA CENTRAL"                     7002487899.10
    "PREVENT SENIOR PRIVATE OPERADORA DE SAÚDE LTDA"            5920615078.62
    "UNIMED BELO HORIZONTE COOPERATIVA DE TRABALHO MÉDICO"      5411476065.42
    "UNIMED SEGUROS SAÚDE S/A"                                  4824024195.15
   */

   -- Quais as 10 operadoras com maiores despesas nessa categoria no último ano?
    /* 
    Razao_Social                                                TOTAL_DESPESAS
    "BRADESCO SAÚDE S.A."                                       77467609279.79
    "SUL AMERICA COMPANHIA DE SEGURO SAÚDE"                     51812853068.58
    "AMIL ASSISTÊNCIA MÉDICA INTERNACIONAL S.A."                51005557507.35
    "NOTRE DAME INTERMÉDICA SAÚDE S.A."                         23545735832.81
    "HAPVIDA ASSISTENCIA MEDICA S.A."                           19385534464.99
    "CAIXA DE ASSISTÊNCIA DOS FUNCIONÁRIOS DO BANCO DO BRASIL"  18412177093.19
    "UNIMED NACIONAL - COOPERATIVA CENTRAL"                     17391267369.70
    "PREVENT SENIOR PRIVATE OPERADORA DE SAÚDE LTDA"            14635643010.58
    "UNIMED BELO HORIZONTE COOPERATIVA DE TRABALHO MÉDICO"      13162050667.89
    "UNIMED SEGUROS SAÚDE S/A"                                  11738001188.48
     */