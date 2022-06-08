


Select Top 100 * from bdjCorporate..CompanyViewedCV where P_ID = 2889959 and CAST(Viewed_ON AS date) = '11/22/2021'


Select Top 100 * from bdjResumes..edu


 Select Top 100 * from vExpCount

 
Select Top 100 * from bdjAssessment.assmnt.CandidateAssesments


SELECT P.ID,P.Name,P.MOBILE, P.HOME_PHONE, P.PRESENT_ADD,P.BIRTH,P.E_MAIL1,v.Texp, Education=(select top 1 E.Education from edu as E where E.p_id=P.Id order by E.Sm_view desc,E.Edulevel desc, E.Passing_year desc) , INSTITUTE=(select top 1 E.INSTITUTE from bdjResumes..edu As E where E.p_id=P.Id order by E.Sm_view desc,E.Edulevel desc, E.Passing_year desc) ,isB2cComplite=(select top 1 AssId from bdjAssessment.assmnt.CandidateAssesments where jp_id is null and Participated =3 and p_id=241028 and cast(ExpiryDate as date) > cast(GETDATE() as date) ) FROM PERSONAL P left join vExpCount v on v.p_id=P.Id wHERE ID=241028


Select Top 100 * from bdjResumes..UserAccounts Where accId = 241028 


Select Top 100 * from bdjResumes..UserAccounts Where accId = 807530 



Select Top 100 * from bdjResumes..UserAccounts Where accId = 4361771 


Select Top 100 * from bdjResumes..tmpUserAccounts Where tPhone = '01580396792' 


Select Top 100 * from bdjResumes..tmpUserAccounts Where tPhone = '01755244111' Order by tCreatedOn ASC







Select Top 100 * from bdjResumes..UserAccounts Where accPhone = '01580396792' 



select tID,tFirstName,tLastName,tGender,tPhone,tCatId,tOTP,tEmail,tUsername,tPassword,CountryCode,tAccCreatedBy from tmpUserAccounts where tID=1115159 and tOTP=706067 and tCreatedOn > DATEADD(mi,
-10,GETDATE())













Select Top 100 * from bdjResumes..UserAccounts Where accPhone = '01952174288'







bdjCorporate..USP_MyBdjobs_ApplyPosition_New 1,241028,20,'EN','','',N'',null


bdjCorporate..USP_MyBdjobs_ApplyPosition_New 1,241028,200,'EN','','',N'',null


bdjCorporate..USP_MyBdjobs_ApplyPosition_New 1,241028,20,'EN','','',N'',6


select * from bdjResumes.vdo.VideoResumes Where p_id = 241028



 insert into smsLogs (P_ID,MobileNo,Reason,MessageId,smsStatus,ErrorCode,CurrentCredit,ProviderID) values (3757342,'8801750752424',4,'34266410837033825739',1,7,-65719.6,2)


select Top 50 * from smsLogs Where p_id = 3757342



select Top 10 * from bdjResumes..Personal Where mobile = '01750752424'

select Top 10 * from bdjResumes..userAccounts Where accID = 3757342



select PERSONAL.name,userAccounts.accUSerName,userAccounts.accEmail,userAccounts.accphone from userAccounts Left join PERSONAL on userAccounts.accID = PERSONAL.ID where ID=3757342 and BIRTH = '10/20/1994'















