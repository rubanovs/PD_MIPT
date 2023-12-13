USE rubanovvs;

DROP TABLE IF EXISTS Subnets;

CREATE EXTERNAL TABLE Subnets (
        ip STRING,
        mask STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION  '/data/subnets_S/variant3';

SELECT * FROM Subnets LIMIT 10