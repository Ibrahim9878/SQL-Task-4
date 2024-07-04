--Database "Library"   
 
--1. Display books with the minimum number 
--of pages issued by a particular publishing house.
--1. Hər Publisherin ən az səhifəli 
--kitabını ekrana çıxarın 

SELECT P.[Name] AS Publisher, MIN(Pages) AS MinPage
FROM Books AS B JOIN Press AS P ON B.Id_Press = P.Id
GROUP BY P.[Name],P.Id
ORDER BY MIN(B.Pages)

--2. Display the names of publishers who have issued books with an average number of pages larger than 100.	
--2. Publisherin ümumi çap etdiyi kitabların orta səhifəsi 100dən yuxarıdırsa, o Publisherləri ekrana çıxarın.

SELECT P.[Name] AS Publisher, AVG(Pages) AS AvgPage
FROM Books AS B JOIN Press AS P ON B.Id_Press = P.Id
GROUP BY P.[Name]
HAVING AVG(Pages) > 100
ORDER BY AVG(B.Pages)

--3. Output the total amount of pages of all the books in the library issued by the publishing houses BHV and BINOM.
--3. BHV və BİNOM Publisherlərinin kitabların bütün cəmi səhifəsini ekrana çıxarın

SELECT SUM(Pages)
FROM Books AS B JOIN Press AS P ON B.Id_Press = P.Id
GROUP BY P.[Name]
HAVING P.[Name] = 'BHV' OR P.[Name] = 'BINOM'
ORDER BY SUM(B.Pages)

--4. Select the names of all students who took books between January 1, 2001 and the current date.
--Yanvarın 1-i 2001ci il və bu gün arasında kitabxanadan kitab götürən bütün tələbələrin adlarını ekrana çıxarın

SELECT St.FirstName
FROM S_Cards AS S JOIN Books AS B ON B.Id = S.Id_Book JOIN Students AS St ON S.Id_Student = St.Id
WHERE S.DateOut > '1/1/2001' AND S.DateOut <= SYSDATETIME()

--5. Find all students who are currently working with the book "Windows 2000 Registry" by Olga Kokoreva.
--5. Olga Kokorevanın  "Windows 2000 Registry" kitabı üzərində işləyən tələbələri tapın

SELECT St.FirstName,St.LastName
FROM S_Cards AS S JOIN Books AS B ON B.Id = S.Id_Book JOIN Students AS St ON S.Id_Student = St.Id JOIN Authors AS A ON A.Id = B.Id_Author
WHERE (A.FirstName = 'Olga' AND A.LastName = 'Kokoreva') OR B.[Name] = 'Windows 2000 Registry'


--6. Display information about authors whose average volume of books (in pages) is more than 600 pages.
--6. Yazdığı bütün kitabları nəzərə aldıqda, orta səhifə sayı 600dən çox olan Yazıçılar haqqında məlumat çıxarın.

SELECT A.Id, A.FirstName, A.LastName ,AVG(Pages) AS AvgPage
FROM Books AS B JOIN Authors AS A ON B.Id_Author = A.Id
GROUP BY A.Id,A.FirstName,A.LastName
HAVING AVG(Pages) > 600
ORDER BY AVG(B.Pages)
--7. Display information about publishers, whose total number of pages of books published by them is more than 700.
--7. Çap etdiyi bütün kitabların cəmi səhifə sayı 700dən çox olan Publisherlər haqqında ekrana məlumat çıxarın
SELECT P.[Name] AS Publisher, SUM(Pages) AS SumPages
FROM Books AS B JOIN Press AS P ON B.Id_Press = P.Id
GROUP BY P.[Name]
HAVING SUM(Pages) > 700
ORDER BY SUM(B.Pages)