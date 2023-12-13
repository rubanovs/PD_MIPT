ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-contrib.jar;
ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;

SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.max.dynamic.partitions=500;
SET hive.exec.max.dynamic.partitions.pernode=500;

USE rubanovvs;

DROP TABLE IF EXISTS LWP;

CREATE EXTERNAL TABLE LWP (
        ip STRING,
        request_time INT,
        http_request STRING,
        page_size SMALLINT,
        http_status SMALLINT,
        client_info STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
        "input.regex" = '^(\\S+)\\t{3}(\\d{8})\\d+\\t(\\S+)\\t(\\d+)\\t(\\d+)\\t(.*)$'
)
STORED AS TEXTFILE
LOCATION '/data/user_logs/user_logs_M';

DROP TABLE IF EXISTS Logs;

CREATE EXTERNAL TABLE Logs (
        ip STRING,
        http_request STRING,
        page_size SMALLINT,
        http_status SMALLINT,
        client_info STRING
)
PARTITIONED BY (request_time INT)
STORED AS TEXTFILE;

INSERT OVERWRITE TABLE Logs PARTITION (request_time)
SELECT ip, http_request, page_size, http_status, client_info, request_time
FROM LWP;

SELECT * FROM Logs LIMIT 10