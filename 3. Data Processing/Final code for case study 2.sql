---1 joining tables 2 converting time 3 separate time and date 4 remove nulls 5 Dayname 6 grouping by age 
WITH base_data AS (
  SELECT 
       coalesce(A.UserID0, A.userid4, B.UserID, CAST(0 AS BIGINT)) AS Upd_User_ID,
       IFNULL(A.Channel2,'0') AS Upd_channel,
       IFNULL(date_format(A.RecordDate2, 'yyyy-MM-dd'),'0') AS Upd_SA_date,
       IFNULL(date_format(A.RecordDate2, 'HH:mm:ss'),'0') AS Upd_SA_Time,
       IFNULL(date_format(A.`Duration 2`, 'HH:mm:ss'),'0') AS Upd_SA_Duration,
       IFNULL(B.Name,'0') AS Upd_name,
       IFNULL(B.Surname,'0') AS Upd_Surname,
       IFNULL(B.Email,'0') AS Upd_Email,
       IFNULL(B.Gender,'No_Gender') AS Upd_Gender,
       IFNULL(B.Race, 'No_Race') As Upd_Race,
       IFNULL(B.Age,0)AS Upd_Age,
       IFNULL(B.Province,'No_Province')AS Upd_Province,
       IFNULL(B.`Social Media Handle`,'No_social-Meadia') AS Upd_Social_Media,
       from_utc_timestamp(to_timestamp(RecordDate2,'yyyy/MM/ddHH:mm'),'Africa/Johannesburg') AS SA_timestamp,
       date_format(RecordDate2, 'yyyy-MM-dd') AS SA_date,
       date_format(RecordDate2, 'HH:mm:ss') AS SA_Time,
       date_format(`Duration 2`, 'HH:mm:ss') AS SA_Duaration,
       dayname(RecordDate2),
       case 
         when IFNULL(B.Age,0) between 1 and 3 then 'baby'
         when IFNULL(B.Age,0) between 4 and 12 then 'child'
         when IFNULL(B.Age,0) between 13 and 17 then 'teenager'
         when IFNULL(B.Age,0) between 18 and 25 then 'young adult'
         when IFNULL(B.Age,0) between 26 and 35 then 'early middle age'
         when IFNULL(B.Age,0) between 36 and 45 then 'middle adulthood'
         when IFNULL(B.Age,0) between 46 and 60 then 'late adulthood age'
         when IFNULL(B.Age,0) > 60 then 'pensioner'
         else 'Unknown'
       end AS Age_Group
  FROM `exercises`.`casestudy2`.`viewership` AS A
  LEFT JOIN exercises.casestudy2.profile_dataset AS B
  ON A.UserID0 = B.UserID
)
SELECT * FROM base_data
