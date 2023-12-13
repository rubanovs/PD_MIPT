ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-contrib.jar;
ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
ADD FILE ./to_hundred.py;

USE rubanovvs;

SELECT TRANSFORM(age) 
USING 'python to_hundred.py'
AS to_hundred
FROM Users LIMIT 10;
