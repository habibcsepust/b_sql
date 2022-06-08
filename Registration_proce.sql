

USE [bdjResumes]
GO
/****** Object:  StoredProcedure [dbo].[USP_USER_REGISTRATION]    Script Date: 5/14/2022 7:00:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************************
** File  :   StoredProcedure [dbo].[USP_USER_REGISTRATION]
** Name  :   dbo.USP_USER_REGISTRATION
** Desc  :   
** Author:   Bipul
** Date  :   April 08, 2015
******************************************************************************************/

ALTER PROCEDURE [dbo].[USP_USER_REGISTRATION]
(
	@FirstName As varchar(50) = ''
	, @LastName As varchar(50) = ''
	, @Gender As char(1) = ''
	, @EMail As varchar(50) = ''
	, @UserName As varchar(50) = null
	, @Password As varchar(15) = null
	, @Phone As varchar(50) = ''
	, @CategoryID As int = -1
	, @IDCode As varchar(6) = ''
	, @IsActivate As bit = 0
	, @AccCreatedBy As tinyint = 0
	, @IsFromSM as bit =0
	, @UseType as char(1)=''
	, @SocialMediaID as varchar(50)=''
	, @SocialMediaName as char(1)=''
	, @CountryCode As varchar(5) = ''
	, @accUNtype As tinyint = 0
	
)
AS
BEGIN
  IF @IsFromSM=1
	BEGIN
	 	DECLARE @ChaeckSMID As int = 0
		DECLARE @AccID As int = 0
		
		SET NOCOUNT ON

		SELECT @ChaeckSMID=COUNT(1) FROM UserSocialMedia WHERE SMID = @SocialMediaID

		IF @ChaeckSMID > 0
			SET @AccID = 0
		ELSE
			BEGIN
				BEGIN TRY
					BEGIN TRAN
						INSERT INTO UserAccounts (accFirstName, accLastName, accGender, accEmail, accPhone, accCatId, accIDcode, accIsActivate, AccCreatedBy, accUNtype, accCountryCode)
						VALUES (@FirstName, @LastName, @Gender, @Email, @Phone, @CategoryID, @IDCode, @IsActivate, @AccCreatedBy, @accUNtype, @CountryCode)
						--Select @P_ID =  Scope_Identity()
						SET  @AccID = (select top 1 accID FROM UserAccounts WHERE accEmail = @Email and accFirstName=@FirstName and accLastName=@LastName order by accId desc)

						INSERT INTO UsersCategory(P_ID, Cat_ID)
						VALUES (@AccID, @CategoryID)

						INSERT INTO UserSocialMedia(accID,SMID,SMName,UseType,SMFromSystem) 
						VALUES (@AccID,@SocialMediaID,@SocialMediaName,@UseType,@AccCreatedBy)

					COMMIT TRAN
				END TRY
				BEGIN CATCH
					ROLLBACK TRAN

					SET @AccID = 0
				-- Error Log
					INSERT INTO logs.Error_Log(ProcedureName, ErrorNumber, ErrorLine, ErrorMessage, ErrorSeverity, ErrorState)
					SELECT ERROR_PROCEDURE() As ProcedureName, ERROR_NUMBER() As ErrorNumber, ERROR_LINE() As ErrorLine, ERROR_MESSAGE() As ErrorMessage, ERROR_SEVERITY() As ErrorSeverity, ERROR_STATE() As ErrorState
				END CATCH
			END
	
		SELECT @AccID

		SET NOCOUNT OFF
	END 
  ELSE
       BEGIN
			DECLARE @ChaeckUN As int = 0
			DECLARE @P_ID As int = 0

			DECLARE @tmpPassword As binary(32) = Null
					, @encPassword As char(64) = Null

			IF (@Password IS NOT NULL) AND (@Password <> '')
				BEGIN
					SET @tmpPassword = HASHBYTES('SHA2_256', @Password)
					SET @encPassword = CONVERT(varchar(64), @tmpPassword, 2)
				END
		
			SET NOCOUNT ON

			SELECT @ChaeckUN=COUNT(1) FROM UserAccounts WHERE accUserName = @UserName

			IF @ChaeckUN > 0
				SET @P_ID = 0
			ELSE
				BEGIN
					BEGIN TRY
						BEGIN TRAN
							INSERT INTO UserAccounts (accFirstName, accLastName, accGender, accEmail, accUserName, accPassword, accPhone, accCatId, accIDcode, accIsActivate, AccCreatedBy, accUNtype, accCountryCode)
							VALUES (@FirstName, @LastName, @Gender, @EMail, @UserName, @encPassword, @Phone, @CategoryID, @IDCode, @IsActivate, @AccCreatedBy, @accUNtype, @CountryCode)
							
							SELECT @P_ID = accID FROM UserAccounts WHERE accUserName = @UserName
														
							INSERT INTO UsersCategory(P_ID, Cat_ID)
							VALUES (@P_ID, @CategoryID)
						COMMIT TRAN
					END TRY
					BEGIN CATCH
						ROLLBACK TRAN

						SET @P_ID = 0
					-- Error Log
						INSERT INTO logs.Error_Log(ProcedureName, ErrorNumber, ErrorLine, ErrorMessage, ErrorSeverity, ErrorState)
						SELECT ERROR_PROCEDURE() As ProcedureName, ERROR_NUMBER() As ErrorNumber, ERROR_LINE() As ErrorLine, ERROR_MESSAGE() As ErrorMessage, ERROR_SEVERITY() As ErrorSeverity, ERROR_STATE() As ErrorState
					END CATCH
				END
	
			SELECT @P_ID

			SET NOCOUNT OFF
		END
END

--USP_USER_REGISTRATION 'Ok vbbb','ghhh','f','mymunaakte@yahoo.com','','','855656',8,'Gmp563',1,3,1,'R','sR32XJepAMT8o8xoOTJdZkznKY734','G'











select top 10 * from logs.Error_Log

select top 10 * from UserSocialMedia

select top 10 * from UsersCategory 

select top 10 * from UserAccounts Where accCatId = 77



select top 10 * from Training Order by P_ID Desc


select top 10 * from bdjResumes..Edu Order by P_ID Desc





select top 10 * from EXP



select top 10 * from Skill

select top 10 * from REF

select top 10 * from Specialist

select top 2 * from Personal where NAME='Rana vanor'  order by ID Desc



select top 2 * from Useraccounts where accPhone='01301728315'   order by accID Desc


select top 10 * from bdjJobFair.dbo.ApplicantInfo where Fair_Id = 10809 





Select A.App_Name,A.Token_No,A.App_ContactNo,P.PhotoName,E.EDUCATION,T.T_ID,EX.Ex_ID,ref.R_ID,spe.P_ID As Ref_PID
From bdjJobFair.dbo.ApplicantInfo AS A
	Left JOIN Personal AS P ON A.P_ID = P.ID
	Left JOIN Edu AS E ON A.P_ID = E.P_ID
	Left JOIN Training AS T ON A.P_ID = T.P_ID
	Left JOIN EXP AS EX ON A.P_ID = EX.P_ID
	Left JOIN REF AS ref ON A.P_ID = ref.P_ID
	Left JOIN Specialist AS spe ON A.P_ID = spe.P_ID
where A.Fair_Id = 10809 and A.Token_No = '1003'



select * from bdjJobFair.dbo.ApplicantInfo where Fair_Id = 10809 and Token_No='1133'



select top 10 * from bdjJobFair.dbo.ApplicantInfo where Fair_Id = 10809 order by P_ID Desc


bdjResumes..USP_Mybdjobs_CheckData_V2 5485310


bdjResumes..USP_Mybdjobs_CheckData_V2 241028



USP_INSERT_Personal_Info 241028




select top 10 * from Training where P_ID = 3757342

DECLARE @Cat_IDs varchar(100) = ''
SELECT @Cat_IDs=  COALESCE(@Cat_IDs + ',', ',') + CAST(Cat_ID AS varchar(5)) FROM UsersCategory WHERE P_ID = 3757342
if @Cat_IDs = '' 
set @Cat_IDs = ''
else set @Cat_IDs =@Cat_IDs +','
select u.accFirstName,u.accLastName,u.accGender,u.accPhone,u.accEmail,u.accCatID,p.FName,p.MName,p.Birth,p.M_Status,p.Nationality,p.Relegion, p.Present_Add,p.Permanent_Add, p.Current_Location,p.Home_Phone,p.Office_Phone,p.E_mail2,p.Obj,p.Cur_Sal,p.Exp_Sal,p.Pref,p.Available,@Cat_IDs,p.Pref_Job_Location, p.Type_Of_Org, o.Career_Summary, o.Spequa,o.Keywords,p.NID,u.accUNtype,BirthPlace,pHeight,pWeight,PassportNo,PassportIssueDate, u.accCountryCode,p.BloodGroup from UserAccounts u left join Personal P ON u.accID = P.ID  left join  personalOthers o 
on u.accid=o.p_id WHERE u.accID=3757342


SELECT T_ID,TName, TLocation, TCountry, TInstitute, TTopic, TDuration, T_ID, TYEAR FROM Training WHERE P_ID=3757342





select top 10 * from Category

select 'https://my.bdjobs.com/photos/'+F.FolderName+'/'+RPI.PhotoName+'.jpg'
from PERSONAL P
LEFT JOIN ResumePhotoInfo RPI ON P.id=RPI.P_ID 
LEFT JOIN PhotoFolderInfo F ON RPI.FolderID=F.ID 
where  P.ID=241028



--For OTP Test: OTP is matching Or NOT Matching

select tID,tFirstName,tLastName,tGender,tPhone,tCatId,tOTP,tEmail,tUsername,tPassword,CountryCode,ttcID,gradID,KnowBy,DisabilityID from tmpUserAccounts where tID="&tid&" and tOTP="&optCode&" and tCreatedOn > DATEADD(mi,-60,GETDATE())




Select Top 10 * from Personal where MOBILE = '01301728315' order by ID desc



Select Top 10 * from Personal where MOBILE = '01707529590' order by ID desc


Select Top 10 * from Personal where MOBILE = '01750752424' order by ID desc


 



Select Top 10 * from Useraccounts where accPhone = '01301728315' order by accID desc 


Select Top 10 * from Useraccounts where accId = 5296544





Select Top 10 * from tmpUseraccounts order by tID desc 


UPDATE Personal SET HOME_PHONE = '01750752424' WHERE CustomerID = 1;









