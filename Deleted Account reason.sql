DECLARE @StartDate varchar(10) = '01/01/2020'
	, @EndtDate varchar(10) = '01/01/2021'

select MONTH(A.PostedOn) M, COUNT(DISTINCT A.AccId) AS [DeletedAccount], COUNT(CASE WHEN A.delReasonId = 1 THEN 1 END) AS [I have multiple accounts]
, COUNT(CASE WHEN A.delReasonId = 2  THEN 1 END) AS [I am already employed]
, COUNT(CASE WHEN A.delReasonId = 3 THEN 1 END) AS [I have privacy concern]
, COUNT(CASE WHEN A.delReasonId = 4 THEN 1 END) AS [I do not find it useful]
, COUNT(CASE WHEN A.delReasonId = 10 THEN 1 END) AS [Others]
from del.AccountDeleteInfo A
WHERE A.DeleteStatus = 1 AND A.PostedOn >= @StartDate AND A.PostedOn < @EndtDate
GROUP BY MONTH(A.PostedOn)
ORDER BY MONTH(A.PostedOn)


--INNER JOIN del.Reasons R ON A.delReasonId = R.delReasonId

--select delReasonId, ReasonText, count(1) 
--from del.Reasons
--group by delReasonId, ReasonText


--delReasonId	ReasonText	(No column name)
--1	I have multiple accounts 	
--2	I am already employed and do not want to switch my job	
--3	I have privacy concern	
--4	I do not find it useful	
--10	Others	


--select top 5* from del.AccountDeleteInfo

--select top 5* from del.Reasons