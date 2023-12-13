ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-contrib.jar;

USE rubanovvs;

SELECT http_status, SUM(IF(sex = 'male', 1, 0)) AS male, SUM(IF(sex = 'female', 1, 0)) AS female
FROM Logs
LEFT JOIN Users ON Users.ip = Logs.ip
GROUP BY http_status;
