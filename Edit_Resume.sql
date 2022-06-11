


Use bdjResumes

Use Resume


Select Top 10 * From bdjCorporate..Feedbacks Order by ID Desc





Select Top 10 * From bdjResumes..EDU where P_ID=5501313



Select Top 10 * From bdjResumes..Useraccounts where accPhone = '01301728315'





Select Top 10 * From bdjResumes..TRAINING where P_ID=241028



Select Top 10 * From bdjResumes..PEDU where P_ID=241028




Select Top 10 * From bdjResumes..PERSONAL where Mobile='01797295177'



SELECT * from bdjResumes..PERSONAL WHERE E_MAIL1 LIKE '%naimur.cse@gmail.com%'



Select Top 10 * From bdjResumes..EXP Where P_ID = 5278119


Select [OBJ], [CUR_SAL], [EXP_SAL], [PREF], [AVAILABLE],[Updatedon],[UPDATED_DATE] FROM PERSONAL where ID =3757342





USP_INSERT_Personal_Info 3757342


DECLARE @Cat_IDs varchar(100) = ''
SELECT @Cat_IDs=  COALESCE(@Cat_IDs + ',', ',') + CAST(Cat_ID AS varchar(5)) FROM UsersCategory WHERE P_ID = 3757342
if @Cat_IDs = '' 
set @Cat_IDs = ''
else set @Cat_IDs =@Cat_IDs +','
select u.accFirstName,u.accLastName,u.accGender,u.accPhone,u.accEmail,u.accCatID,p.FName,p.MName,p.Birth,p.M_Status,p.Nationality,p.Relegion, p.Present_Add,p.Permanent_Add, p.Current_Location,p.Home_Phone,p.Office_Phone,p.E_mail2,p.Obj,p.Cur_Sal,p.Exp_Sal,p.Pref,p.Available,@Cat_IDs,p.Pref_Job_Location, p.Type_Of_Org, o.Career_Summary, o.Spequa,o.Keywords,p.NID,u.accUNtype,BirthPlace,pHeight,pWeight,PassportNo,PassportIssueDate, u.accCountryCode,p.BloodGroup from UserAccounts u left join Personal P ON u.accID = P.ID  left join  personalOthers o on u.accid=o.p_id WHERE u.accID=3757342


SELECT dfvID, FieldValue, AddedOn FROM bdjDataset.dbo.DataFieldValues WHERE dfID = 4 And FieldValue LIKE '%ban%' ORDER BY FieldValue




select top 10 * from useraccounts 




;WITH cteReports AS
(
select top 10 count(*) as NO_Of_Exist, CONCAT(accFirstName, accLastName) as FullName
	from useraccounts 
	group by accFirstName, accLastName
	having count(*) > 1 and accFirstName ='Habib'
)

Select NO_Of_Exist, FullName FROM cteReports 
go














