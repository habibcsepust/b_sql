

SELECT va.aId, va.qID, va.SourcePath, va.Duration, va.TotalViewed 
from bdjResumes.vdo.Answers va where P_Id = 241028





;WITH ViewedbyCompanies_CTE As (  SELECT ROUND(AVG(case when Rating > 0 then Rating end),
2) AS CompanyRating, SUM(TotalViewed) AS TotalViewed  ,COUNT(1) AS TotalCompanyUserViewed, COUNT(distinct CUA.CP_ID) AS TotalCompanyViewed FROM vdo.ViewedbyCompanies VbC  inner join bdjCorporate..CorporateUserAccess CUA On CUA.UserID = Vbc.ComUserId  WHERE P_Id = 241028  ) 
SELECT  (SELECT COUNT(*) FROM vdo.ResumeQuestions Q WHERE Q.qActivated >= 0) AS TotalQuestionCount, 
(SELECT COUNT(*) FROM vdo.Answers VA WHERE VA.P_ID = 241028) AS TotalAnswerCount,  
(SELECT VR.AllowToShow FROM vdo.VideoResumes VR WHERE VR.P_ID = 241028) AS AllowToShowData  , CompanyRating, TotalViewed, TotalCompanyViewed,(SELECT COUNT(*) FROM vdo.Answers VA WHERE VA.qID = 1 and VA.P_ID = 241028) AS ExistQ1  FROM ViewedbyCompanies_CTE




;WITH ViewedbyCompanies_CTE As (
SELECT ROUND(AVG(case when Rating > 0 then Rating end),2) AS CompanyRating, 
SUM(TotalViewed) AS TotalViewed  ,COUNT(1) AS TotalCompanyUserViewed, COUNT(distinct CUA.CP_ID) AS TotalCompanyViewed
FROM vdo.ViewedbyCompanies VbC  inner join bdjCorporate..CorporateUserAccess CUA On CUA.UserID = Vbc.ComUserId  
WHERE P_Id = 241028  )  
SELECT  (SELECT COUNT(*) FROM vdo.ResumeQuestions Q WHERE Q.qActivated >= 0) AS TotalQuestionCount,  
(SELECT COUNT(*) FROM vdo.Answers VA WHERE VA.P_ID = 241028) AS TotalAnswerCount, 
(SELECT VR.AllowToShow FROM vdo.VideoResumes VR WHERE VR.P_ID = 241028) AS AllowToShowData  , 

CompanyRating, TotalViewed, TotalCompanyViewed ,
(SELECT qid  FROM vdo.Answers VA WHERE VA.P_ID = 241028 and qid=1)As HasAnsweredQuestionNo1  FROM ViewedbyCompanies_CTE



;WITH ViewedbyCompanies_CTE As (
SELECT ROUND(AVG(case when Rating > 0 then Rating end),2) AS CompanyRating, 
SUM(TotalViewed) AS TotalViewed  ,COUNT(1) AS TotalCompanyUserViewed, COUNT(distinct CUA.CP_ID) AS TotalCompanyViewed
FROM vdo.ViewedbyCompanies VbC  inner join bdjCorporate..CorporateUserAccess CUA On CUA.UserID = Vbc.ComUserId  
WHERE P_Id = 241028  )  
SELECT  (SELECT COUNT(*) FROM vdo.ResumeQuestions Q WHERE Q.qActivated >= 0) AS TotalQuestionCount,  
(SELECT COUNT(*) FROM vdo.Answers VA WHERE VA.P_ID = 241028) AS TotalAnswerCount, 
(SELECT VR.AllowToShow FROM vdo.VideoResumes VR WHERE VR.P_ID = 241028) AS AllowToShowData  , 

CompanyRating, TotalViewed, TotalCompanyViewed ,
(SELECT A.qid  FROM vdo.Answers A WHERE A.P_ID = 241028 and A.qid=1)As HasAnsweredQuestionNo1  FROM ViewedbyCompanies_CTE







SELECT top 10* FROM vdo.ResumeQuestions

SELECT top 10* FROM vdo.ViewedbyCompanies where P_Id = 241028




SELECT COUNT(*) FROM vdo.Answers WHERE qID = 1 and P_ID = 241028



SELECT CASE WHEN qID=1 THEN 'y' ELSE 'no' END As IsExistQ1 FROM vdo.Answers where qID = 1 and P_Id = 241028





SELECT ROUND(AVG(case when Rating > 0 then Rating end),
2) AS CompanyRating from vdo.ViewedbyCompanies where P_Id = 241028


SELECT  (SELECT COUNT(*) FROM vdo.ResumeQuestions Q WHERE Q.qActivated >= 0) AS TotalQuestionCount

Select (SELECT COUNT(*) FROM vdo.Answers VA WHERE VA.P_ID = 241028) AS TotalAnswerCount


SELECT top 10 * FROM vdo.Answers VA WHERE VA.P_ID = 241028




SELECT FileType,DocumentType as path_doc,UpdatedOn FROM  bdjResumeFiles..ResumeFiles where p_id=201028




