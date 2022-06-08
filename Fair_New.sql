

USe bdjJobFair






;WITH NextEvent_CTE As (   select ROW_NUMBER() OVER(order by e.eventDate asc, e.EvenTime asc) As SL, e.eventID , e.eventDate, CONVERT(varchar(15), e.EvenTime, 100) As EventTime     , STUFF((SELECT '#$#' + epl.Name + '#^#' + epl.Designation FROM EventPanelist epl WHERE epl.EventID = e.EventID order by epl.SerialNo asc FOR XML PATH('') ), 1, 3, '' ) UserList     , ep.epID, case when e.EventType = 'panel discussion' then e.Topic else  ci.Company_Name end CompnayNamrOrTopic     , e.EventDuration,e.EventURL, e.EventPass, e.LiviStreamingON, e.StreamingURL, 1 As EvntType   from EventInfo e     left join ViewFairInfo vfi on e.EventID = vfi.EventId     left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id     left join EventParticipants ep on e.EventID = ep.EventId and ep.P_ID = 241028   where e.fairID = 10808   and e.EventType= 'seminar'     and (case when e.EventType = 'panel discussion' then e.Topic else ci.Company_Name end <> '' OR e.EventType = 'seminar')    And e.EventDate >= CONVERT(varchar(10), GETDATE(), 101) ), ExpiredEvent_CTE As (   select ROW_NUMBER() OVER(order by e.eventDate asc, e.EvenTime asc) As SL, e.eventID , e.eventDate, CONVERT(varchar(15), e.EvenTime, 100) As EventTime     ,STUFF((SELECT '#$#' + epl.Name + '#^#' + epl.Designation FROM EventPanelist epl WHERE epl.EventID = e.EventID order by epl.SerialNo asc FOR XML PATH('') ), 1, 3, '' ) UserList     , ep.epID, case when e.EventType = 'panel discussion' then e.Topic else  ci.Company_Name end CompnayNamrOrTopic     , e.EventDuration,e.EventURL, e.EventPass,e.LiviStreamingON, e.StreamingURL, 2 As EvntType   from EventInfo e     left join ViewFairInfo vfi on e.EventID = vfi.EventId     left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id     left join EventParticipants ep on e.EventID = ep.EventId and ep.P_ID = 241028   where e.fairID = 10808   and e.EventType= 'seminar'     And (case when e.EventType = 'panel discussion' then e.Topic else  ci.Company_Name end <> ''  OR e.EventType = 'seminar')     And e.EventDate < CONVERT(varchar(10), GETDATE(), 101) ) SELECT eventID, eventDate, EventTime, UserList, epID, CompnayNamrOrTopic, EventDuration, EventURL, EventPass, LiviStreamingON, StreamingURL, EvntType,SL FROM NextEvent_CTE UNION SELECT eventID, eventDate, EventTime, UserList, epID, CompnayNamrOrTopic, EventDuration, EventURL, EventPass, LiviStreamingON, StreamingURL, EvntType, SL FROM ExpiredEvent_CTE ORDER BY EvntType, SL





;WITH NextEvent_CTE As (   select ROW_NUMBER() OVER(order by e.eventDate asc, e.EvenTime asc) As SL, e.eventID , e.eventDate, CONVERT(varchar(15), e.EvenTime, 100) As EventTime     , STUFF((SELECT '#$#' + epl.Name + '#^#' + epl.Designation FROM EventPanelist epl WHERE epl.EventID = e.EventID order by epl.SerialNo asc FOR XML PATH('') ), 1, 3, '' ) UserList     , ep.epID, case when e.EventType in ( 'panel discussion','seminar' )  then e.Topic else  ci.Company_Name end CompnayNamrOrTopic     , e.EventDuration,e.EventURL, e.EventPass, e.LiviStreamingON, e.StreamingURL, 1 As EvntType   from EventInfo e     left join ViewFairInfo vfi on e.EventID = vfi.EventId     left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id     left join EventParticipants ep on e.EventID = ep.EventId and ep.P_ID = 241028   where e.fairID = 10808   and e.EventType= 'seminar'     and (case when e.EventType = 'panel discussion' then e.Topic else ci.Company_Name end <> '' OR e.EventType = 'seminar')    And e.EventDate >= CONVERT(varchar(10), GETDATE(), 101) ), ExpiredEvent_CTE As (   select ROW_NUMBER() OVER(order by e.eventDate asc, e.EvenTime asc) As SL, e.eventID , e.eventDate, CONVERT(varchar(15), e.EvenTime, 100) As EventTime     ,STUFF((SELECT '#$#' + epl.Name + '#^#' + epl.Designation FROM EventPanelist epl WHERE epl.EventID = e.EventID order by epl.SerialNo asc FOR XML PATH('') ), 1, 3, '' ) UserList     , ep.epID, case when e.EventType in ( 'panel discussion','seminar' )  then e.Topic else  ci.Company_Name end CompnayNamrOrTopic     , e.EventDuration,e.EventURL, e.EventPass,e.LiviStreamingON, e.StreamingURL, 2 As EvntType   from EventInfo e     left join ViewFairInfo vfi on e.EventID = vfi.EventId     left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id     left join EventParticipants ep on e.EventID = ep.EventId and ep.P_ID = 241028   where e.fairID = 10808   and e.EventType= 'seminar'     And (case when e.EventType = 'panel discussion' then e.Topic else  ci.Company_Name end <> ''  OR e.EventType = 'seminar')     And e.EventDate < CONVERT(varchar(10), GETDATE(), 101) ) SELECT eventID, eventDate, EventTime, UserList, epID, CompnayNamrOrTopic, EventDuration, EventURL, EventPass, LiviStreamingON, StreamingURL, EvntType,SL FROM NextEvent_CTE UNION SELECT eventID, eventDate, EventTime, UserList, epID, CompnayNamrOrTopic, EventDuration, EventURL, EventPass, LiviStreamingON, StreamingURL, EvntType, SL FROM ExpiredEvent_CTE ORDER BY EvntType, SL






select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else  fwji.JobTitle_Name end JobTitle_Name   
	,fwji.JP_ID,ci.Com_Id   , ci.Company_Name Company_Name   ,ci.Image_Name
	,   case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription   
	,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority 
from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id    
	left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id    
	left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID    
	left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028   
	LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id   
where vfi.fair_id = 10806  
	--and vfi.att_id = 4603 --get  job
	--and jix.applyid is not null --get all apply 
order by Company_Name asc  OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY




Select Top 5 * from bdjCorporate..dbo_job_inbox



--Apply Count


Select count(1)
from ViewFairInfo vfi
	inner join  FairWithJobInfo  fwji on vfi.Att_Id = fwji.Att_Id
	inner join  bdjCorporate..dbo_job_inbox  jix on fwji.JP_ID = jix.JP_ID
where vfi.fair_id = 10808 and jix.p_id = 241028



--Presentation


Select count(1)
from EventInfo EI
where fairid = 10807  and EventType = 'Presentation'




Select Top 5 * From ViewFairInfo


as jix left join ViewFairInfo as vfi on fwji.Att_Id = vfi.Att_Id 


Select Top 5 * From ViewFairInfo




select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else fwji.JobTitle_Name end JobTitle_Name ,fwji.JP_ID,ci.Com_Id , ci.Company_Name Company_Name ,ci.Image_Name, case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription ,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028 LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id where vfi.fair_id = 10806 AND ci.CP_Id = 43110 order by Company_Name asc OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY





select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else  fwji.JobTitle_Name end JobTitle_Name   
	,fwji.JP_ID,ci.Com_Id   , ci.Company_Name Company_Name   ,ci.Image_Name
	,   case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription   
	,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority 
from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id    
	left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id    
	left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID    
	left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028   
	LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id   
where vfi.fair_id = 10806  
	and vfi.att_id = 4603 --get  job
	--and jix.applyid is not null --get all apply 
order by Company_Name asc  OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY



select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else  fwji.JobTitle_Name end JobTitle_Name   ,fwji.JP_ID,ci.Com_Id   , ci.Company_Name Company_Name   ,ci.Image_Name,   case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription   ,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id    left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id    left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID    left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028   LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id   where vfi.fair_id = 10806  order by Company_Name asc  OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY



select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else  fwji.JobTitle_Name end JobTitle_Name   ,fwji.JP_ID,ci.Com_Id   ,ci.Company_Name Company_Name   ,ci.Image_Name,   case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription,F.FairDate,jix.ApplyID,Jix.Priority from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id    left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id    left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID    left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028   LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id  where vfi.att_id = 4603



select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else  fwji.JobTitle_Name end JobTitle_Name   ,fwji.JP_ID,ci.Com_Id   , ci.Company_Name Company_Name   ,ci.Image_Name,   case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription   ,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id    left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id    left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID    left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028   LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id   where vfi.fair_id = 10806  and jix.applyid is not null  order by Company_Name asc  OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY



--Participated Organization

SELECT vfi.Att_Id,vfi.EventId,  ci.Company_Name Company_Name, ci.Image_Name,  evt.EventDate,evt.EvenTime,count(fwj.F_id),ci.cp_id,ci.PresentationURL,ci.PresentationType ,CountOrganization=(Select COUNT(Company_Name) from bdjJobFair..CompanyInfo CI left join bdjJobFair..ViewFairInfo vfi on vfi.Com_Id = ci.Com_Id where  vfi.Fair_Id=10806)  FROM bdjJobFair..ViewFairInfo vfi left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id left join FairWithJobInfo fwj on vfi.Att_Id = fwj.Att_Id left join EventInfo evt on vfi.EventId = evt.EventID left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID  where vfi.Fair_Id=10806  group by vfi.Att_Id,vfi.EventId,ci.Company_Name,ci.Image_Name,evt.EventDate,  evt.EvenTime,ci.cp_id,ci.PresentationURL,ci.PresentationType,evt.SerialNo,cp.NameBng  order by ci.Company_Name asc




select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else  fwji.JobTitle_Name end JobTitle_Name   ,fwji.JP_ID,ci.Com_Id   , ci.Company_Name Company_Name   ,ci.Image_Name,   case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription   ,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id    left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id    left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID    left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028   LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id   where vfi.fair_id = 10806  order by Company_Name asc  OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY




--Shorlisted Candidate Procedure

USe bdjJobFair



bdjCorporate.JobFair.USP_Fair_Shorlisted_Apllicant_Details 1, 20,10806, 0,'', 0




select App_Id from ApplicantInfo where Fair_Id = 10806 and p_id = 4947296


SELECT vfi.Att_Id,vfi.EventId,  ci.Company_Name Company_Name, ci.Image_Name,  evt.EventDate,evt.EvenTime,count(fwj.F_id),ci.cp_id,ci.PresentationURL,ci.PresentationType ,CountOrganization=(Select COUNT(Company_Name) from bdjJobFair..CompanyInfo CI left join bdjJobFair..ViewFairInfo vfi on vfi.Com_Id = ci.Com_Id where  vfi.Fair_Id=10807)  FROM bdjJobFair..ViewFairInfo vfi left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id left join FairWithJobInfo fwj on vfi.Att_Id = fwj.Att_Id left join EventInfo evt on vfi.EventId = evt.EventID left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID  where vfi.Fair_Id=10807  group by vfi.Att_Id,vfi.EventId,ci.Company_Name,ci.Image_Name,evt.EventDate,  evt.EvenTime,ci.cp_id,ci.PresentationURL,ci.PresentationType,evt.SerialNo,cp.NameBng  order by ci.Company_Name asc OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY





select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else  fwji.JobTitle_Name end JobTitle_Name   ,fwji.JP_ID,ci.Com_Id   , ci.Company_Name Company_Name   ,ci.Image_Name,   case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription   ,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id    left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id    left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID    left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 4947296   LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id   where vfi.fair_id = 10807  order by Company_Name asc  OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY



select top 1 eventID
from EventInfo 
where fairID = 10807 
	and getdate() between  cast( ( convert(varchar(20), eventDate, 101)  + ' ' + cast(REPLACE(EvenTime, ': AM', '') as varchar(10))) as smalldatetime) and DATEADD(n, EventDuration, cast( ( convert(varchar(20), eventDate, 101)  + ' ' + cast(REPLACE(EvenTime, ': AM', '') as varchar(10))) as smalldatetime))






SELECT  Fair_Id, Fair_TimeTable,FairDate, Duration, Place, ContactPerson,Fairtype, VenueBangla,Fair_Title,PlatformType,Fair_Description FROM FAIRINFO  where  fair_id = 10807







SELECT vfi.Att_Id,vfi.EventId,  ci.Company_Name Company_Name, ci.Image_Name,  evt.EventDate,evt.EvenTime,count(fwj.F_id),ci.cp_id,ci.PresentationURL,ci.PresentationType  
FROM bdjJobFair..ViewFairInfo vfi 
	left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id 
	left join FairWithJobInfo fwj on vfi.Att_Id = fwj.Att_Id 
	left join EventInfo evt on vfi.EventId = evt.EventID 
	left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID  
where vfi.Fair_Id=10807  
group by vfi.Att_Id,vfi.EventId,ci.Company_Name,ci.Image_Name,evt.EventDate,  evt.EvenTime,ci.cp_id,ci.PresentationURL,ci.PresentationType,evt.SerialNo,cp.NameBng  
order by ci.Company_Name asc



select top 2 * From bdjJobFair..ViewFairInfo

select top 2 * From CompanyInfo

select top 2 * From FairWithJobInfo

select top 2 * From EventInfo

select top 2 * From bdjCorporate..DBO_COMPANY_PROFILES







select Ci.Com_Id, Ci.Company_Name, CI.Image_Name, B.BusinessDetail, C.web, C.Address
	, ci.PresentationURL, ci.PresentationType
From ViewFairInfo vfi  
	inner join CompanyInfo CI on vfi.Com_Id = ci.Com_Id
	inner join bdjCorporate..DBO_COMPANY_PROFILES c on ci.CP_ID = C.CP_ID
	inner join bdjCorporate..COMPANY_BUSINESS B on B.CP_ID = c.CP_ID
where vfi.Fair_Id = 10807 and ci.CP_ID = 35450


select Ci.Com_Id, Ci.Company_Name, CI.Image_Name, B.BusinessDetail, C.web, C.Address, ci.PresentationURL, ci.PresentationType From ViewFairInfo vfi inner join CompanyInfo CI on vfi.Com_Id = ci.Com_Id inner join bdjCorporate..DBO_COMPANY_PROFILES c on ci.CP_ID = C.CP_ID inner join bdjCorporate..COMPANY_BUSINESS B on B.CP_ID = c.CP_ID where vfi.Fair_Id = 10807 and ci.CP_ID = 35450



USe bdjJobFair

select SJS_ID, Name, SurveyedOn from SelectedJobSeekers where p_id = 2410289





SELECT vfi.Att_Id,vfi.EventId, ci.Company_Name Company_Name, ci.Image_Name, evt.EventDate,evt.EvenTime,count(fwj.F_id),ci.cp_id,ci.PresentationURL,ci.PresentationType FROM bdjJobFair..ViewFairInfo vfi left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id left join FairWithJobInfo fwj on vfi.Att_Id = fwj.Att_Id left join EventInfo evt on vfi.EventId = evt.EventID left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID where vfi.Fair_Id=10807 group by vfi.Att_Id,vfi.EventId,ci.Company_Name,ci.Image_Name,evt.EventDate, evt.EvenTime,ci.cp_id,ci.PresentationURL,ci.PresentationType,evt.SerialNo,cp.NameBng order by ci.Company_Name asc



select Ci.Com_Id, Ci.Company_Name, CI.Image_Name, B.BusinessDetail, C.web, C.Address, ci.PresentationURL, ci.PresentationType From ViewFairInfo vfi inner join CompanyInfo CI on vfi.Com_Id = ci.Com_Id left join bdjCorporate..DBO_COMPANY_PROFILES c on ci.CP_ID = C.CP_ID inner join bdjCorporate..COMPANY_BUSINESS B on B.CP_ID = c.CP_ID where vfi.Fair_Id = 10807 and vfi.Att_Id = 4609


Select count(jix.ApplyID), count(case when ap.SchId > 0 then ap.prId else null end) from ViewFairInfo vfi inner join FairWithJobInfo fwji on vfi.Att_Id = fwji.Att_Id inner join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID inner join bdjCorporate.rp.ApplicantProcess ap on jix.ApplyID = ap.ApplyId and ap.LevelStatus = 1 where vfi.fair_id = 10807 and jix.p_id = 241028



select COUNT(1) from EventInfo e left join ViewFairInfo vfi on e.EventID = vfi.EventId left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id left join EventParticipants ep on e.EventID = ep.EventId and ep.P_ID = 241028 where e.fairID = 10807 and ep.P_ID = 241028



USe bdjJobFair

select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else fwji.JobTitle_Name end JobTitle_Name ,fwji.JP_ID,ci.Com_Id , ci.Company_Name Company_Name ,ci.Image_Name, case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription ,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 0 LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id where vfi.fair_id = 10807 and ci.CP_Id_= 35450 order by Company_Name asc OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY



select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else fwji.JobTitle_Name end JobTitle_Name ,fwji.JP_ID,ci.Com_Id , ci.Company_Name Company_Name ,ci.Image_Name, case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription ,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028 LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id where vfi.fair_id = 10807 and ci.CP_Id = 35450 order by Company_Name asc OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY


select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else fwji.JobTitle_Name end JobTitle_Name ,fwji.JP_ID,ci.Com_Id , ci.Company_Name Company_Name ,ci.Image_Name, case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription ,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028 LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id where vfi.fair_id = 10807 and ci.CP_Id = 35450 order by Company_Name asc OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY









select fwji.JP_ID
	, case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else  fwji.JobTitle_Name 
	end JobTitle_Name   ,ci.Com_Id   , ci.Company_Name Company_Name   ,ci.Image_Name,   
	case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription   
	,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority 
from FairWithJobInfo fwji 
	left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id    
	left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id   
	left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID
	left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028  
	LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id   
where vfi.fair_id = 10807  
order by Company_Name asc  OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY






USe bdjJobFair
SELECT vfi.Att_Id,vfi.EventId,  ci.Company_Name Company_Name, ci.Image_Name,  evt.EventDate,evt.EvenTime,count(fwj.F_id),ci.cp_id,ci.PresentationURL,ci.PresentationType  FROM bdjJobFair..ViewFairInfo vfi left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id left join FairWithJobInfo fwj on vfi.Att_Id = fwj.Att_Id left join EventInfo evt on vfi.EventId = evt.EventID left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID  where vfi.Fair_Id=10807  group by vfi.Att_Id,vfi.EventId,ci.Company_Name,ci.Image_Name,evt.EventDate,  evt.EvenTime,ci.cp_id,ci.PresentationURL,ci.PresentationType,evt.SerialNo,cp.NameBng  order by ci.Company_Name asc--><!-- sqlCountApply:  Select count(1) from ViewFairInfo vfi inner join  FairWithJobInfo  fwji on vfi.Att_Id = fwji.Att_Id  inner join  bdjCorporate..dbo_job_inbox  jix on fwji.JP_ID = jix.JP_ID  where vfi.fair_id = 10807 and jix.p_id = 241028--><!--sqlCountApply:  Select count(jix.ApplyID), count(case when ap.SchId > 0  and ap.Notify > 0 then ap.prId else null end) from ViewFairInfo vfi inner join  FairWithJobInfo  fwji on vfi.Att_Id = fwji.Att_Id  inner join  bdjCorporate..dbo_job_inbox  jix on fwji.JP_ID = jix.JP_ID  inner join bdjCorporate.rp.ApplicantProcess ap on jix.ApplyID = ap.ApplyId and ap.LevelStatus = 1  where vfi.fair_id = 10807 and jix.p_id = 241028





select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else fwji.JobTitle_Name end JobTitle_Name ,fwji.JP_ID,ci.Com_Id , ci.Company_Name Company_Name ,ci.Image_Name, 
	case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription ,
	count(1)over() as CountTotal, ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority 
	from bdjJobFair..FairWithJobInfo fwji 
left join bdjJobFair..ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id 
left join bdjJobFair..CompanyInfo ci on vfi.Com_Id = ci.Com_Id
left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID 
left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028 
LEFT join bdjJobFair..FairInfo F on vfi.Fair_Id = f.Fair_Id 
	where vfi.fair_id = 10806 
	order by Company_Name asc OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY






select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else fwji.JobTitle_Name end JobTitle_Name ,fwji.JP_ID,ci.Com_Id , ci.Company_Name Company_Name ,ci.Image_Name, 
	case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription ,
	count(1)over() as CountTotal, ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority 
	from bdjJobFair..FairWithJobInfo fwji 
left join bdjJobFair..ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id 
left join bdjJobFair..CompanyInfo ci on vfi.Com_Id = ci.Com_Id 
left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID 
left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028 
LEFT join bdjJobFair..FairInfo F on vfi.Fair_Id = f.Fair_Id 
	where vfi.fair_id = 10806 AND ci.CP_Id = 43110 
	order by Company_Name asc OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY




	bdjCorporate.JobFair.USP_Fair_Shorlisted_Apllicant_Details 1, 20,10806, 0,''


	Use bdjCorporate


select count(1) from jobFair..FairWithJobInfo fwji inner  join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id inner  join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID where jix.p_id = 241028 and Priority = 1 and vfi.fair_id = 10807






select case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else fwji.JobTitle_Name end JobTitle_Name ,fwji.JP_ID,ci.Com_Id , ci.Company_Name Company_Name ,ci.Image_Name, case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription ,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028 LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id where vfi.fair_id = 10807 order by Company_Name asc 







USe bdjJobFair

Select top 2 * from FairWithJobInfo

Select top 2 * from ViewFairInfo

Select top 2 * from  bdjCorporate..dbo_job_inbox


Select top 10 * from HPSupdates

Select COUNT(1) from HPSupdates


Select P_ID FROM HPSupdates Where P_ID = 241028 and JP_ID = 1001188 and Fair_ID = 10807



 
select top 10 * from IneligibleList where p_id = 241028


Select count(1) from ViewFairInfo vfi inner join  FairWithJobInfo  fwji on vfi.Att_Id = fwji.Att_Id  inner join  bdjCorporate..dbo_job_inbox  jix on fwji.JP_ID = jix.JP_ID  where vfi.fair_id = 10807 and jix.p_id = 241028





SELECT vfi.Att_Id,vfi.EventId,  ci.Company_Name Company_Name, ci.Image_Name,  evt.EventDate,CONVERT(varchar(15), evt.EvenTime, 100) EvenTime,count(fwj.F_id),ci.cp_id,ci.PresentationURL,ci.PresentationType ,CountOrganization=(Select COUNT(Company_Name) from bdjJobFair..CompanyInfo CI left join bdjJobFair..ViewFairInfo vfi on vfi.Com_Id = ci.Com_Id where  vfi.Fair_Id=10808)  FROM bdjJobFair..ViewFairInfo vfi left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id left join FairWithJobInfo fwj on vfi.Att_Id = fwj.Att_Id left join EventInfo evt on vfi.EventId = evt.EventID left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID  where vfi.Fair_Id=10808  group by vfi.SerialNo, vfi.Att_Id,vfi.EventId,ci.Company_Name,ci.Image_Name,evt.EventDate,  CONVERT(varchar(15), evt.EvenTime, 100),ci.cp_id,ci.PresentationURL,ci.PresentationType,evt.SerialNo,cp.NameBng  order by vfi.SerialNo, ci.Company_Name asc OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY








USe bdjJobFair



select fwji.JP_ID, case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else  fwji.JobTitle_Name end JobTitle_Name   ,ci.Com_Id   , ci.Company_Name Company_Name   ,ci.Image_Name,   case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription   ,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority,fwji.JobLang from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id    left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id    left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID    left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028   LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id   where vfi.fair_id = 10808  order by vfi.SerialNo, Company_Name asc  OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY






select top 100 * from bdjJobFair..FairWithJobInfo where JP_ID=1018293





select top 10 * from bdjCorporate..JobDescriptionBng












--stall Page
--English
SELECT vfi.Att_Id,vfi.EventId,  ci.Company_Name Company_Name, ci.Image_Name,  evt.EventDate,evt.EvenTime,count(fwj.F_id),ci.cp_id,ci.PresentationURL,ci.PresentationType FROM bdjJobFair..ViewFairInfo vfi  left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id  left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID  LEFT JOIN VacancyWiseCompany VWC ON VWC.CP_ID = CP.CP_ID  left join FairWithJobInfo fwj on vfi.Att_Id = fwj.Att_Id  left join EventInfo evt on vfi.EventId = evt.EventID where vfi.Fair_Id=10808  group by vfi.Att_Id,vfi.EventId,ci.Company_Name,ci.Image_Name,evt.EventDate,  evt.EvenTime,ci.cp_id,ci.PresentationURL,ci.PresentationType,VWC.SL,cp.NameBng order by VWC.SL asc



--Bangla
SELECT vfi.Att_Id,vfi.EventId,  ci.Company_Name Company_Name, ci.Image_Name,  evt.EventDate,evt.EvenTime,count(fwj.F_id),ci.cp_id,ci.PresentationURL,ci.PresentationType FROM bdjJobFair..ViewFairInfo vfi  left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id  left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID  LEFT JOIN VacancyWiseCompany VWC ON VWC.CP_ID = CP.CP_ID  left join FairWithJobInfo fwj on vfi.Att_Id = fwj.Att_Id  left join EventInfo evt on vfi.EventId = evt.EventID where vfi.Fair_Id=10808  group by vfi.Att_Id,vfi.EventId,ci.Company_Name,ci.Image_Name,evt.EventDate,  evt.EvenTime,ci.cp_id,ci.PresentationURL,ci.PresentationType,VWC.SL,vfi.SerialNo,cp.NameBng order by vfi.SerialNo, VWC.SL asc




select fwji.JP_ID, case when fwji.JobLang = 2 then fwji.JobTitle_NameBng else  fwji.JobTitle_Name end JobTitle_Name   ,ci.Com_Id   , ci.Company_Name Company_Name   ,ci.Image_Name,   case when fwji.JobLang = 2 then fwji.JobDescriptionBng else fwji.JobDescription end JobDescription   ,count(1)over(), ci.CP_ID, vfi.Att_Id,F.FairDate,jix.ApplyID,Jix.Priority from FairWithJobInfo fwji left join ViewFairInfo vfi on fwji.Att_Id = vfi.Att_Id    left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id    left join bdjCorporate..DBO_COMPANY_PROFILES CP On Ci.CP_ID = CP.CP_ID    left join bdjCorporate..dbo_job_inbox jix on fwji.JP_ID = jix.JP_ID and jix.p_id = 241028   LEFT join FairInfo F on vfi.Fair_Id = f.Fair_Id   where vfi.fair_id = 10808  order by vfi.SerialNo, Company_Name asc  OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY




select top 100 * from ViewFairInfo




select top 10 * from dbo.ApplicantInfo



select count(*) from dbo.ApplicantInfo









USe bdjJobFair

Select count(1)  
from EventInfo EI	  
	left join ViewFairInfo vfi on EI.EventID = vfi.EventId  	  
	left join CompanyInfo ci on vfi.Com_Id = ci.Com_Id  
where fairid = 10808
	and case when EI.EventType in ('panel discussion','Seminar', 'program') then ei.Topic else  ci.Company_Name end <> ''



select top 10 * from dbo.EventInfo

 where FairId = 10808





 Select TOP 1 *
from dbo.EventInfo
where EventDuration = (Select Min(EventDuration) from dbo.EventInfo) Order by EventDuration Asc









;with CTE_JObFairInfo as ( 	SELECT FI.Fair_Id, count(distinct VFI.Att_Id ) TCompany , count(distinct case when JP.OnlineJob = 1 And JP.RegionalJob = 4 then JP.JP_ID else null end) TJob 		, Count(distinct JI.ApplyID )  TApplication, Count(distinct case when AP.Notify = 1 Then AP.SchId else null end )  TSchedule 	FROM bdjJobFair..CompanyInfo CI 		INNER JOIN bdjJobFair..ViewFairInfo VFI ON VFI.Com_Id = CI.Com_Id 		INNER JOIN bdjJobFair..FairInfo FI ON FI.Fair_Id = VFI.Fair_Id 		left JOIN bdjJobFair..FairWithJobInfo FWI ON VFI.Att_ID = FWI.Att_ID 		left JOIN bdjCorporate..DBO_JOBPOSTINGS JP ON JP.CP_ID = CI.CP_ID And FWI.JP_ID = JP.JP_ID 		left JOIN bdjCorporate..DBO_COMPANY_PROFILES As CP ON JP.CP_ID = CP.CP_ID 		left JOIN bdjCorporate..DBO_JOB_INBOX JI ON JP.JP_ID = JI.JP_ID 		left JOIN bdjCorporate.rp.ApplicantProcess AP ON JI.ApplyID = AP.ApplyId And AP.LevelStatus = 1 	WHERE FI.Fair_Id =  10808 	Group by FI.Fair_Id ), CTE_Presentation as ( 	select JF.Fair_ID, Count( E.FairID) TPresentation 	from CTE_JObFairInfo JF 		left join bdjJobFair..EventInfo E on E.FairID = JF.Fair_ID and EventType = 'Presentation' 	group by JF.Fair_ID ), CTE_PanelDiscussion as ( 	select JF.Fair_ID, Count(E.FairID) TPanelDiscussion 	from  CTE_JObFairInfo JF 		left  join bdjJobFair..EventInfo E on E.FairID = JF.Fair_ID and EventType = 'Panel discussion' 	group by JF.Fair_ID ), CTE_ApplicantInfo as ( 	select JF.Fair_ID, count(a.App_Id) TApplicant 	from CTE_JObFairInfo JF 		left join ApplicantInfo A on A.Fair_Id = JF.Fair_ID 	group by JF.Fair_ID ) select JF.Fair_Id , ci.Company_Name,ci.Image_Name 	, TCompany,TJob, TApplication,TSchedule 	, P.TPresentation, TPanelDiscussion, A.TApplicant  from CTE_JObFairInfo JF 	inner join CTE_Presentation P On JF.Fair_ID = P.Fair_ID 	inner join CTE_PanelDiscussion PD On JF.Fair_ID = PD.Fair_ID  	inner join CTE_ApplicantInfo A On JF.Fair_ID = A.Fair_ID  	inner join viewFairInfo vfi on JF.Fair_ID =  VFI.Fair_Id 	left join CompanyInfo ci on VFI.Com_ID  = CI.Com_ID









Select count(1)
from ViewFairInfo vfi
	inner join  FairWithJobInfo  fwji on vfi.Att_Id = fwji.Att_Id
	inner join  bdjCorporate..dbo_job_inbox  jix on fwji.JP_ID = jix.JP_ID
where vfi.fair_id = 10808





Select Top 10 * from FairWithJobInfo

Select Top 10 * from bdjCorporate..dbo_job_inbox




