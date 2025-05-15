-- 1. Pronadji sva imena studenata.
SELECT sname FROM student;

-- 2. Prikazi sve studente na drugoj godini.
SELECT * FROM student WHERE level = 2;

-- 3. Prikazi sve predmete koje drzi profesor Black.
SELECT title FROM course WHERE lname = 'Black';

-- 4. Pronadji sve ocene studenta sa prezimenom 'Burns'.
SELECT r.mark
FROM report r
JOIN student s ON r.sno = s.sno
WHERE s.sname = 'Burns';

-- 5. Prikazi sve kurseve i broj ucenja po kursu.
SELECT cno, COUNT(*) AS broj_studenata
FROM report
GROUP BY cno;

-- 6. Prikazi sve studente koji imaju ocjenu vecu od 70.
SELECT s.sname, r.mark
FROM student s
JOIN report r ON s.sno = r.sno
WHERE r.mark > 70;

-- 7. Prikazi prosjecnu ocjenu za svaki kurs.
SELECT cno, AVG(mark) AS prosjecna_ocena
FROM report
GROUP BY cno;

-- 8. Prikazi sve kurseve sa prosjecnom ocjenom vecom od 75.
SELECT cno, AVG(mark) AS prosjecna_ocjena
FROM report
GROUP BY cno
HAVING AVG(mark) > 75;

-- 9. Pronadji broj kurseva koje slusa svaki student.
SELECT sno, COUNT(cno) AS broj_kurseva
FROM report
GROUP BY sno;

-- 10. Prikazi sve kurseve koje studenti slusaju i ime profesora koji ih predaje.
SELECT c.title, c.lname
FROM course c
JOIN report r ON c.cno = r.cno;

-- 11. Pronadji sve predmete i broj studenata koji imaju vise od 1 studenta.
SELECT cno, COUNT(sno) AS broj_studenata
FROM report
GROUP BY cno
HAVING COUNT(sno) > 1;

-- 12. Prikazi sve studente i kurseve koje slusaju (ime studenta i naziv kursa).
SELECT s.sname, c.title
FROM student s
JOIN report r ON s.sno = r.sno
JOIN course c ON r.cno = c.cno;

-- 13. Pronadji sve profesore i koliko kurseva predaju.
SELECT lname, COUNT(*) AS broj_kurseva
FROM course
GROUP BY lname;
-- 14. Prikazi sve studente koji slusaju predmet kod profesora 'Holt'.
SELECT DISTINCT s.sname
FROM student s
JOIN report r ON s.sno = r.sno
JOIN course c ON r.cno = c.cno
WHERE c.lname = 'Holt';

-- 15. Pronadji najvisu ocenu koju je student 'Burns' dobio.
SELECT MAX(r.mark) AS najbolja_ocena
FROM report r
JOIN student s ON r.sno = s.sno
WHERE s.sname = 'Burns';

-- 16. Prikazi studente koji imaju vise od 1 kurs sa prosjesnom ocjenom vecom od 70.
SELECT s.sname
FROM student s
JOIN report r ON s.sno = r.sno
GROUP BY s.sname
HAVING AVG(r.mark) > 70 AND COUNT(r.cno) > 1;

-- 17. Prikazi sve studente koji imaju najmanje jedan kurs kod profesora 'Black'.
SELECT DISTINCT s.sname
FROM student s
JOIN report r ON s.sno = r.sno
JOIN course c ON r.cno = c.cno
WHERE c.lname = 'Black';

-- 18. Prikazi prosjecne ocjene svih studenata po kursevima.
SELECT s.sname, c.title, r.mark
FROM student s
JOIN report r ON s.sno = r.sno
JOIN course c ON r.cno = c.cno;

-- 19. Pronadji sve studente koji ne slusaju nijedan kurs (LEFT JOIN).
SELECT s.sname
FROM student s
LEFT JOIN report r ON s.sno = r.sno
WHERE r.sno IS NULL;

-- 20. Pronadji sve kurseve koje niko ne slusa (LEFT JOIN).
SELECT c.title
FROM course c
LEFT JOIN report r ON c.cno = r.cno
WHERE r.cno IS NULL;

-- 21. Prikazi prosjecne ocjene po svakom profesoru, ali samo za one kurseve koje slusa vise od 1 student.
SELECT
    c.lname AS profesor,
    c.title AS kurs,
    AVG(r.mark) AS prosecna_ocena,
    COUNT(r.sno) AS broj_studenata
FROM course c
JOIN report r ON c.cno = r.cno
GROUP BY c.lname, c.title
HAVING COUNT(r.sno) > 1;

-- 22. Prikazi imena svih studenata i prosecnu ocenu kod svakog profesora cije ime pocinje slovom 'H'.
SELECT
    s.sname AS student,
    c.lname AS profesor,
    AVG(r.mark) AS prosecna_ocena
FROM student s
JOIN report r ON s.sno = r.sno
JOIN course c ON r.cno = c.cno
WHERE c.lname LIKE 'H%'
GROUP BY s.sname, c.lname;

-- 23. Prikazi svakog studenta, predmete koje slusa, ime profesora i ocenu, ali samo ako je ocjena veca od prosjecne ocjene tog predmeta.
SELECT
    s.sname AS student,
    c.title AS predmet,
    c.lname AS profesor,
    r.mark AS ocena
FROM student s
JOIN report r ON s.sno = r.sno
JOIN course c ON r.cno = c.cno
WHERE r.mark > (
    SELECT AVG(r2.mark)
    FROM report r2
    WHERE r2.cno = r.cno
);

-- 24. Prikazi imena studenata i broj predmeta koje slusaju kod profesora cije ime sadrzi slovo 'a'.
SELECT s.sname AS student,
       COUNT(DISTINCT c.cno) AS broj_kurseva
FROM student s
JOIN report r ON s.sno = r.sno
JOIN course c ON r.cno = c.cno
WHERE LOWER(c.lname) LIKE '%a%'
GROUP BY s.sname;

-- 25. Prikazi sve profesore i prosecne ocjene studenata kod njih, ali samo one koji drze predmete ciji je broj izmedju 200 i 300.
SELECT c.lname AS profesor,
       AVG(r.mark) AS prosecna_ocena
FROM course c
JOIN report r ON c.cno = r.cno
WHERE c.cno BETWEEN 200 AND 300
GROUP BY c.lname;


-- 26. Prikazi sve studente koji imaju bar jedan predmet kod profesora 'Black',
-- i kod tog profesora imaju ocjenu vecu od prosecne ocjene tog predmeta.
SELECT DISTINCT s.sname, r.mark, c.title
FROM student s
JOIN report r ON s.sno = r.sno
JOIN course c ON r.cno = c.cno
WHERE c.lname = 'Black'
  AND r.mark > (
      SELECT AVG(r2.mark)
      FROM report r2
      WHERE r2.cno = c.cno
  );

-- 27. Prikazi sve predmete koji imaju tacno 2 razlicita studenta sa ocenom vecom od 70.
SELECT c.title, COUNT(DISTINCT r.sno) AS broj_studenata
FROM report r
JOIN course c ON r.cno = c.cno
WHERE r.mark > 70
GROUP BY c.title
HAVING COUNT(DISTINCT r.sno) = 2;

-- 28. Pronadji studente koji slusaju sve kurseve koje drzi profesor 'Holt'.
SELECT s.sname
FROM student s
WHERE NOT EXISTS (
    SELECT c.cno
    FROM course c
    WHERE c.lname = 'Holt'
    EXCEPT
    SELECT r.cno
    FROM report r
    WHERE r.sno = s.sno
);

-- 29. Prikazi imena studenata koji imaju bar dva razlicita predmeta sa ocenom izmedju 60 i 90.
SELECT s.sname
FROM student s
JOIN report r ON s.sno = r.sno
WHERE r.mark BETWEEN 60 AND 90
GROUP BY s.sname
HAVING COUNT(DISTINCT r.cno) >= 2;

-- 30. Pronadji sve profesore koji predaju predmet koji niko ne slusa.
SELECT DISTINCT c.lname
FROM course c
LEFT JOIN report r ON c.cno = r.cno
WHERE r.cno IS NULL;

-- 31. Prikazi sve studente koji imaju bar jedan predmet kod profesora cije ime pocinje slovom 'B' i ocjenu vecu od 80.
SELECT DISTINCT s.sname
FROM student s
JOIN report r ON s.sno = r.sno
JOIN course c ON r.cno = c.cno
WHERE c.lname LIKE 'B%' AND r.mark > 80;

-- 32. Pronadji predmete koje svi studenti slusaju (tj. broj studenata na predmetu = ukupnom broju studenata).
SELECT c.title
FROM course c
JOIN report r ON c.cno = r.cno
GROUP BY c.title
HAVING COUNT(DISTINCT r.sno) = (SELECT COUNT(*) FROM student);

-- 33. Pronadji prosečne ocjene po predmetima, ali samo za predmete koje predaje vise profesora (ako isti predmet ima vise predavaca).
SELECT c.title, AVG(r.mark) AS prosjecna
FROM course c
JOIN report r ON c.cno = r.cno
GROUP BY c.title
HAVING COUNT(DISTINCT c.lname) > 1;

-- 34. Prikazi imena studenata koji imaju vise od 2 predmeta kod profesora cije prezime sadrzi slovo 'e'.
SELECT s.sname
FROM student s
JOIN report r ON s.sno = r.sno
JOIN course c ON r.cno = c.cno
WHERE LOWER(c.lname) LIKE '%e%'
GROUP BY s.sname
HAVING COUNT(DISTINCT c.cno) > 2;

-- 35. Prikazi predmete i broj studenata koji su na njima dobili ocjenu vecu od 75, sortirano po broju studenata opadajuce.
SELECT c.title, COUNT(DISTINCT r.sno) AS broj_studenata
FROM course c
JOIN report r ON c.cno = r.cno
WHERE r.mark > 75
GROUP BY c.title
ORDER BY broj_studenata DESC;

-- 36. Prikazi sve studente koji slusaju makar jedan kurs kod svakog profesora cije ime pocinje na 'H'.
SELECT s.sname
FROM student s
WHERE NOT EXISTS (
    SELECT c.cno
    FROM course c
    WHERE c.lname LIKE 'H%'
    EXCEPT
    SELECT r.cno
    FROM report r
    WHERE r.sno = s.sno
);

-- 37. Prikazi sve profesore i maksimalnu ocjenu koju je neki student dobio kod njih.
SELECT c.lname AS profesor, MAX(r.mark) AS max_ocjena
FROM course c
JOIN report r ON c.cno = r.cno
GROUP BY c.lname;

-- 38. Prikazi sve kurseve koje slusa tacno 3 studenta i svi imaju ocjene izmedju 60 i 90.
SELECT c.title
FROM course c
JOIN report r ON c.cno = r.cno
WHERE r.mark BETWEEN 60 AND 90
GROUP BY c.title
HAVING COUNT(DISTINCT r.sno) = 3;

-- 39. Prikazi sve studente koji imaju sve ocjene vece od 50.
SELECT s.sname
FROM student s
WHERE NOT EXISTS (
    SELECT *
    FROM report r
    WHERE r.sno = s.sno AND r.mark <= 50
);

-- 40. Prikazi predmete i broj razlicitih profesora koji ih predaju.
SELECT c.title, COUNT(DISTINCT c.lname) AS broj_profesora
FROM course c
GROUP BY c.title;

-- 41. Prikazi imena studenata i ukupnu sumu ocjena koje su dobili kod profesora 'Smith'.
SELECT s.sname, SUM(r.mark) AS ukupno
FROM student s
JOIN report r ON s.sno = r.sno
JOIN course c ON r.cno = c.cno
WHERE c.lname = 'Smith'
GROUP BY s.sname;

-- 42. Prikazi sve profesore koji predaju predmete koje niko ne slusa sa ocjenom vecom od 60.
SELECT DISTINCT c.lname
FROM course c
LEFT JOIN report r ON c.cno = r.cno AND r.mark > 60
WHERE r.sno IS NULL;

-- 43. Prikazi sve studente koji slusaju sve predmete koje predaje profesor 'Brown'.
SELECT s.sname
FROM student s
WHERE NOT EXISTS (
    SELECT c.cno
    FROM course c
    WHERE c.lname = 'Brown'
    EXCEPT
    SELECT r.cno
    FROM report r
    WHERE r.sno = s.sno
);