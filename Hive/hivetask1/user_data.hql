ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-contrib.jar;
ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;

USE rubanovvs;

DROP TABLE IF EXISTS Users;

CREATE EXTERNAL TABLE Users (
        ip STRING,
        browser STRING,
        sex STRING,
        age TINYINT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
        "input.regex" = '^(\\S+)\\t(\\S+)\\t(\\S+)\\t(\\d+).*$'
)
STORED AS TEXTFILE
LOCATION '/data/user_logs/user_data_M';

SELECT * FROM Users LIMIT 10