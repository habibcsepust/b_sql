


Select Top 10 * From bdjResumes.pwd.PersonalInfo



DECLARE @P_ID As int = 0 , @Today As varchar(10) = '' SET @Today = CONVERT(varchar(10), GETDATE(), 101) ;WITH Subscription_CTE As ( SELECT P_ID FROM bdjCorporate..FollowedEmployers WHERE SMSnotification = 1 And P_ID = (CASE WHEN @P_ID = 0 THEN P_ID ELSE @P_ID END) UNION SELECT P_ID FROM bdjResumes.fs.Savedfilters WHERE SMSnotification = 1 And P_ID = (CASE WHEN @P_ID = 0 THEN P_ID ELSE @P_ID END) ), Alert_CTE As ( SELECT P_ID, COUNT(1) as TotalSent FROM bdjLogs.sms.SentAlert WHERE P_ID = (CASE WHEN @P_ID = 0 THEN P_ID ELSE @P_ID END) AND CONVERT(varchar(10), SentOn, 101)=@Today GROUP BY P_ID ) SELECT top 1 U.suID, U.P_ID, U.TotalPurchased, U.TotalSent, U.smsActive, DL.dlLimit, U.AllowMatchedJobs FROM bdjResumes..smsUsers U INNER JOIN bdjResumes..smsDailyLimit DL ON DL.P_ID = U.P_ID INNER JOIN Subscription_CTE S ON U.P_ID = S.P_ID LEFT JOIN Alert_CTE SA ON SA.P_ID = U.P_ID WHERE U.smsActive = 1 And (U.TotalPurchased - U.TotalSent) > 0 And (SA.P_ID IS NULL OR DL.dlLimit > SA.TotalSent) And U.P_ID = (CASE WHEN @P_ID = 0 THEN U.P_ID ELSE @P_ID END) order by U.suID




DECLARE @P_ID As int = 0 , @Today As varchar(10) = '' SET @Today = CONVERT(varchar(10), GETDATE(), 101) ;WITH Alert_CTE As (SELECT P_id FROM bdjLogs.sms.SentAlert WHERE P_ID = (CASE WHEN @P_ID = 0 THEN P_ID ELSE @P_ID END) AND CONVERT(varchar(10), SentOn, 101)=@Today GROUP BY P_ID) select distinct top 1 * from UserAccounts u inner join pwd.PersonalInfo p on u.accid=p.p_id LEFT JOIN Alert_CTE SA ON SA.P_ID = u.accid WHERE (SA.P_ID IS NULL ) and not p.p_id is null and u.accIsActivate=1 and u.accid > 4470253 ORDER BY u.accid ASC





--getEligibleUserId


DECLARE @P_ID As int = 0 , @Today As varchar(10) = '' SET @Today = CONVERT(varchar(10), GETDATE(), 101) ;WITH Subscription_CTE As ( SELECT P_ID FROM bdjCorporate..FollowedEmployers WHERE SMSnotification = 1 And P_ID = (CASE WHEN @P_ID = 0 THEN P_ID ELSE @P_ID END) UNION SELECT P_ID FROM bdjResumes.fs.Savedfilters WHERE SMSnotification = 1 And P_ID = (CASE WHEN @P_ID = 0 THEN P_ID ELSE @P_ID END) ), Alert_CTE As ( SELECT P_ID, COUNT(1) as TotalSent FROM bdjLogs.sms.SentAlert WHERE P_ID = (CASE WHEN @P_ID = 0 THEN P_ID ELSE @P_ID END) AND CONVERT(varchar(10), SentOn, 101)=@Today GROUP BY P_ID ) SELECT top 1 U.suID, U.P_ID, U.TotalPurchased, U.TotalSent, U.smsActive, DL.dlLimit, U.AllowMatchedJobs FROM bdjResumes..smsUsers U INNER JOIN bdjResumes..smsDailyLimit DL ON DL.P_ID = U.P_ID INNER JOIN Subscription_CTE S ON U.P_ID = S.P_ID LEFT JOIN Alert_CTE SA ON SA.P_ID = U.P_ID WHERE U.smsActive = 1 And (U.TotalPurchased - U.TotalSent) > 0 And (SA.P_ID IS NULL OR DL.dlLimit > SA.TotalSent) And U.P_ID = (CASE WHEN @P_ID = 0 THEN U.P_ID ELSE @P_ID END) order by U.suID



--todaysSendSmsCount

select count(*) from bdjLogs.sms.SentAlert where P_ID = 1447888 and cast(SentOn as date) = cast(getdate() as date)

--getMobileNoByUserId

--One

Select ua.accPhone, pa.Home_Phone from bdjResumes..useraccounts ua left join bdjResumes..personal pa on ua.accId = pa.ID where accID = 4368176

--Two
Select ua.accPhone, pa.Home_Phone from bdjResumes..useraccounts ua left join bdjResumes..personal pa on ua.accId = pa.ID where accID = 1447888

--Three

Select ua.accPhone, pa.Home_Phone from bdjResumes..useraccounts ua left join bdjResumes..personal pa on ua.accId = pa.ID where accID = 4520755

--Four

Select ua.accPhone, pa.Home_Phone from bdjResumes..useraccounts ua left join bdjResumes..personal pa on ua.accId = pa.ID where accID = 3579068





--fCompanyjobList

;with getCategoryWiseJobId_CTE as ( Select DISTINCT femp.P_ID, djps.JP_ID, femp.CompanyName From bdjCorporate..FollowedEmployers femp inner join bdjCorporate..dbo_jobpostings djps on djps.CP_ID = femp.CP_ID inner join bdjCorporate..dbo_job_category Cat on djps.jp_id = cat.jp_id inner join bdjResumes..usersCategory ucat on cat.CAT_ID = ucat.Cat_ID and ucat.P_ID = femp.P_ID left join bdjCorporate..DBO_BNG_JOBPOSTINGS dbjps on djps.jp_id = dbjps.JP_ID where femp.P_ID = 4368176 and femp.SMSnotification = 1 and djps.OnlineJob = 1 and djps.VERIFIED = 1 and djps.Drafted = 0 and Closed = 0 and djps.Deadline >= cast(GetDate() as date) and djps.JP_ID not in (select JP_ID from bdjLogs.sms.SentAlert where P_Id = femp.P_ID) and djps.JobLang <> 2 ) Select top 2 femp.P_ID, djps.CP_ID, djps.JP_ID, femp.CompanyName, djps.CompanyName , djps.MinExp, djps.MaxExp ,case when djps.JobLang = 2 then dbjps.TITLE else djps.JobTitle end Title , djps.PublishDate FROM getCategoryWiseJobId_CTE femp inner join bdjCorporate..dbo_jobpostings djps on djps.JP_ID = femp.JP_ID left join bdjCorporate..DBO_BNG_JOBPOSTINGS dbjps on djps.jp_id = dbjps.JP_ID order by djps.PublishDate desc



--getSaveFiltereIds

bdjResumes.fs.USP_GET_SaveFilter_Value 4368176,1,10,1



DECLARE @P_ID As int = 0 , @Today As varchar(10) = '' SET @Today = CONVERT(varchar(10), GETDATE(), 101) ;WITH Alert_CTE As (SELECT P_id FROM bdjLogs.sms.SentAlert WHERE P_ID = (CASE WHEN @P_ID = 0 THEN P_ID ELSE @P_ID END) AND CONVERT(varchar(10), SentOn, 101)=@Today GROUP BY P_ID) select distinct top 10 u.accid from UserAccounts u inner join pwd.PersonalInfo p on u.accid=p.p_id LEFT JOIN Alert_CTE SA ON SA.P_ID = u.accid WHERE (SA.P_ID IS NULL ) and not p.p_id is null and u.accIsActivate=1





DECLARE @P_ID As int = 0 , @Today As varchar(10) = '' SET @Today = CONVERT(varchar(10), GETDATE(), 101) ;WITH Alert_CTE As (SELECT P_id FROM bdjLogs.sms.SentAlert WHERE P_ID = (CASE WHEN @P_ID = 0 THEN P_ID ELSE @P_ID END) AND CONVERT(varchar(10), SentOn, 101)=@Today GROUP BY P_ID) select distinct top 1 * from UserAccounts u inner join pwd.PersonalInfo p on u.accid=p.p_id LEFT JOIN Alert_CTE SA ON SA.P_ID = u.accid WHERE (SA.P_ID IS NULL ) and not p.p_id is null and u.accIsActivate=1 and u.accid > 50 ORDER BY u.accid ASC



exec USP_UserLogin_jobs_New '',1357133









Select Top 10 * from pwd.PersonalInfo













Select Top 10 * from smsLogs Order by smsID Desc




Select Top 10 * from bdjResumes.dbo.smsLogs Where MobileNo = '01957693949' and SentOn = '2016-12-22 13:33:00'



SELECT GETDATE() 





Select Top 10 * from bdjLogs.sms.SentAlert Order by smsID Desc



Select Top 10 * from bdjLogs.sms.BalanceNotification Order by ID Desc




Select Top 10 * from UserPassCodes Order by ID Desc



Select Top 10 * from UserAccounts Order by accID Asc




Select Top 10 * from tmpUserAccounts where  tPhone = '01750752424'  order by tID desc




bdjActiveJobs..USP_JOBS_Search_MatchedForSMSAlert_V1 0,0,0,0,0,'M',0,0,1,1




bdjActiveJobs..USP_JOBS_Search_MatchedForSMSAlert_V1 70,0,1,20,30,'M',4368176,0,1,2




bdjActiveJobs..USP_JOBS_Search_MatchedForSMSAlert_V1 0,0,0,0,0,'M',21258,0,1,1




DECLARE @P_ID As int = 0 , @Today As varchar(10) = '' SET @Today = CONVERT(varchar(10), GETDATE(), 101) ;WITH Alert_CTE As (SELECT P_id FROM bdjLogs.sms.SentAlert WHERE P_ID = (CASE WHEN @P_ID = 0 THEN P_ID ELSE @P_ID END) AND CONVERT(varchar(10), SentOn, 101)=@Today GROUP BY P_ID) select distinct top 10 * from UserAccounts u inner join pwd.PersonalInfo p on u.accid=p.p_id LEFT JOIN Alert_CTE SA ON SA.P_ID = u.accid WHERE (SA.P_ID IS NULL ) and not p.p_id is null and u.accIsActivate=1 and u.accid > 50 ORDER BY u.accid ASC


3994845


exec USP_UserLogin_jobs_New '',1357133




bdjActiveJobs..USP_JOBS_Search_MatchedForSMSAlert_V1 9,5,10,30,40,'M',262615,1,0,1


bdjActiveJobs..USP_JOBS_Search_MatchedForSMSAlert_V1 9,5,10,30,40,'M',631043,1,0,1




Select Top 10 * from bdjLogs.sms.SentAlert Where JP_Id = '992222' Order by smsID Desc



Where JP_Id = '990408'



Sent:  990408



Use bdjCorporate



DECLARE @P_ID As int = 0 ,
 @Today As varchar(10) = ''
  SET @Today = CONVERT(varchar(10), GETDATE(), 101) 
;WITH Alert_CTE As (
SELECT P_id FROM bdjLogs.sms.SentAlert 
WHERE 
P_ID = (CASE WHEN @P_ID = 0 THEN P_ID ELSE @P_ID END) AND CONVERT(varchar(10), SentOn, 101)=@Today GROUP BY P_ID
) 
select distinct top 10 u.accid   from bdjResumes..UserAccounts u inner join 
bdjResumes.pwd.PersonalInfo p on u.accid=p.p_id
LEFT JOIN Alert_CTE SA ON SA.P_ID = u.accid 
WHERE  (SA.P_ID IS NULL ) and not p.p_id is null and u.accid>5137521 and u.accIsActivate=1
order by u.accid desc



Select Top 10 * from bdjLogs.sms.SentAlert



Use bdjResumes


Select Top 10 * from UserPassCodes order by ID desc     smsLogs 



Select Top 10 * from bdjResumes..smsUsers order by suID Desc



Select Top 10 * from bdjResumes..smsUsers



Select Top 10 * from bdjResumes..userpasscodes

Select Top 10 * from bdjResumes..userAccounts 


Select Top 10 * from bdjResumes..userpasscodes Order by CreatedOn Desc



