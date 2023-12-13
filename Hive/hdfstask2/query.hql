USE rubanovvs;

SELECT SPLIT(client_info, ' ')[0] AS browser, COUNT(client_info) AS amount 
FROM Logs
GROUP BY SPLIT(client_info, ' ')[0]
ORDER BY amount DESC;
