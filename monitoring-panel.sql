

Use bdjResumes


SELECT Specialist.Skill_ID, spec.skills.skillName, Specialist.P_ID FROM Specialist LEFT JOIN spec.skills ON Specialist.Skill_ID=spec.skills.skillID where  Specialist.P_ID=241028

dbo.usp_ResumePersonalInfo 241028 


 SELECT Specialist.Skill_ID, spec.skills.skillName, Specialist.P_ID FROM Specialist LEFT JOIN spec.skills ON Specialist.Skill_ID=spec.skills.skillID where  Specialist.P_ID=241028


 select pp.P_ID, pp.DisabilityID from pwd.PersonalInfo pp where pp.P_ID =241028



 select pp.P_ID, pd.dName, pa.dLevel, pd.dType, pp.DisabilityID, pp.ShowInCV, count(1)over() as totalCount from pwd.PersonalInfo pp 
	 left join pwd.Assessments pa on pp.P_ID = pa.P_ID 
	 left join pwd.dTypes pd on pa.dtId = pd.dtId 
	 where pp.P_ID = 241028 and pp.ShowInCV = 1
	order by pa.dtId asc 


SELECT * from bdjResumes..PERSONAL WHERE E_MAIL1 LIKE '%naimur.cse@gmail.com%'



	select ID,NAME, HOME_PHONE FROM Personal where ID = 241028

	
	select top 5 * FROM bdjResumes..PersonalInfo



	select pp.P_ID, pd.dName, pa.dLevel, pd.dType, pp.DisabilityID, pp.ShowInCV, count(1)over() as totalCount from pwd.PersonalInfo pp left join pwd.Assessments pa on pp.P_ID = pa.P_ID left join pwd.dTypes pd on pa.dtId = pd.dtId where pp.P_ID = 241028 and pp.ShowInCV = 1 order by pa.dtId asc




select top 10 * from bdjJobFair.dbo.MonitoringUserAccounts 



select UserId,UserName,Password,Name,Phone,Email from bdjJobFair.dbo.MonitoringUserAccounts where UserName='habib' and Password='12345'




dbo.USP_PWD_Personal_Details_Info

dbo.USP_JobFair_Pwd_Applicant_SEARCH 





Use bdjCorporate

select L_ID, L_Name from location where L_ID IN (14,14,55,64) and OutsideBangladesh = 0





select top 10 * from bdjJobFair.dbo.UserComments where AppID=190558


select app_id from applicantInfo where p_id = 5229329 and fair_id = 10808


select CommentID, Fair_Id,AppID,Status,Comments,PostedOn,AssistiveDevice,AssistanceWorkplace,UserId from bdjJobFair.dbo.UserComments






bdjJobFair.dbo.USP_Applicant_JobMatching_Detail 5229329, 1016511






SELECT distinct CWS.SkillID,S.SkillName 
FROM bdjResumes.spec.CategoryWiseSkills CWS 
inner join bdjResumes.spec.Skills S On S.SkillID = CWS.SkillId 
WHERE CWS.SkillType LIKE '%Skill%' and ((S.UserDefined is null or S.UserDefined = 0) or (S.userDefined >= 1 and S.verifiedOn is not null)) and CWS.SkillID in (659,395,15014)
ORDER BY S.SkillName


SELECT * FROM bdjResumes.spec.CategoryWiseSkills 

SELECT * from bdjResumes..PERSONAL WHERE E_MAIL1 LIKE '%naimur.cse@gmail.com%'








SELECT C.CAT_NAME
FROM bdjCorporate..DBO_JOBPOSTINGS J
INNER JOIN bdjCorporate..Category C ON J.CAT_ID = C.CAT_ID
WHERE J.JP_ID = 1016511


SELECT Cat_NAME
FROM bdjResumes..UsersCategory U
INNER JOIN bdjResumes..Category C ON U.CAT_ID = C.CAT_ID
WHERE P_ID = 955











select * from UserAccounts where AccUserName = '01580396792'




select * from tmpUserAccounts where tID=1115159 and tOTP=706067 and tCreatedOn > DATEADD(mi,
-10,GETDATE())


USP_USER_REGISTRATION 'jubol','','O','','01580396792','','01580396792','66','0g3f8F',1,3,0,'','','','88',2







DECLARE @Cat_IDs varchar(100) = ''SELECT @Cat_IDs= COALESCE(@Cat_IDs + ',', ',') + CAST(Cat_ID AS varchar(5)) FROM UsersCategory WHERE P_ID = 5278119 if @Cat_IDs = '' set @Cat_IDs = ''else set @Cat_IDs =@Cat_IDs +','select u.accFirstName,u.accLastName,u.accGender,u.accPhone,u.accEmail,u.accCatID,p.FName,p.MName,p.Birth,p.M_Status,p.Nationality,p.Relegion, p.Present_Add,p.Permanent_Add, p.Current_Location,p.Home_Phone,p.Office_Phone,p.E_mail2,p.Obj,p.Cur_Sal,p.Exp_Sal,p.Pref,p.Available,@Cat_IDs,p.Pref_Job_Location, p.Type_Of_Org, o.Career_Summary, o.Spequa,o.Keywords,p.NID,u.accUNtype,BirthPlace,pHeight,pWeight,PassportNo,PassportIssueDate, u.accCountryCode,p.BloodGroup from UserAccounts u left join Personal P ON u.accID = P.ID left join personalOthers o on u.accid=o.p_id WHERE u.accID=4572665


 select pp.P_ID, pd.dName, pa.dLevel, pd.dType, pp.DisabilityID, pp.ShowInCV, count(1)over() as totalCount from pwd.PersonalInfo pp left join pwd.Assessments pa on pp.P_ID = pa.P_ID left join pwd.dTypes pd on pa.dtId = pd.dtId where pp.P_ID = 4572665 order by pa.dtId asc 





SELECT Specialist.Skill_ID, spec.skills.skillName, Specialist.P_ID FROM Specialist LEFT JOIN spec.skills ON Specialist.Skill_ID=spec.skills.skillID where Specialist.P_ID=4572665



SELECT * from bdjResumes..PERSONAL WHERE E_MAIL1 LIKE '%naimur.cse@gmail.com%'


SELECT * from bdjResumes..PERSONAL WHERE NAME LIKE '%Habibur%'



SELECT TOP 10 * from bdjResumes..PERSONAL WHERE NAME LIKE '%Habibur%' Order by UPDATED_DATE DESC 


