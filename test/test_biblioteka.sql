-- Zadatak 1: Prikazivanje svih studenata
SELECT * FROM student;

-- Zadatak 2: Prikazivanje svih kurseva
SELECT * FROM course;

-- Zadatak 3: Prikazivanje svih predavaca
SELECT * FROM lecturer;

-- Zadatak 4: Prikazivanje svih studenata sa njihovim imenom i nivoom
SELECT sname, level FROM student;

-- Zadatak 5: Prikazivanje svih kurseva sa naslovima i imenima predavaca
SELECT title, lname FROM course;

-- Zadatak 6: Prikazivanje studenata koji su na drugom nivou
SELECT * FROM student 
WHERE level = 2;

-- Zadatak 7: Prikazivanje kurseva na kojima predaje predavac "Holt"
SELECT title FROM course 
WHERE lname = 'Holt';

-- Zadatak 8: Prikazivanje svih ocjena za studenta sa brojem indeksa 864532
SELECT * FROM report 
WHERE sno = 864532;

-- Zadatak 9: Prikazivanje svih studenata koji nisu upisali kurs sa brojem 121
SELECT * FROM student 
WHERE sno NOT IN (SELECT sno FROM report WHERE cno = 121);

-- Zadatak 10: Prikazivanje svih kurseva na kojima nema studenata sa ocjenom ispod 50
SELECT title FROM course 
WHERE cno NOT IN (SELECT cno FROM report WHERE mark < 50);

-- Zadatak 11: Prikazivanje imena predavaca sa brojem ucionice
SELECT lname, roomno FROM lecturer;

-- Zadatak 12: Prikazivanje broja studenata na svakom nivou
SELECT level, COUNT(*) FROM student 
GROUP BY level;

-- Zadatak 13: Prikazivanje broja kurseva po svakom predavacu
SELECT lname, COUNT(*) FROM course 
GROUP BY lname;

-- Zadatak 14: Prikazivanje prosjecne ocjene za kurs "Compilers"
SELECT AVG(mark) FROM report 
WHERE cno = 121;

-- Zadatak 15: Prikazivanje svih studenata koji imaju prosjecnu ocjenu iznad 70 na svim ispitima
SELECT sno, AVG(mark) FROM report 
GROUP BY sno 
HAVING AVG(mark) > 70;

-- Zadatak 16: Prikazivanje svih studenata koji imaju visu ocjenu od 75 na kursu "Database Systems"
SELECT sname, mark FROM student 
JOIN report ON student.sno = report.sno 
JOIN course ON report.cno = course.cno 
WHERE course.title = 'Database Systems' AND mark > 75;

-- Zadatak 17: Prikazivanje svih studenata koji nisu upisali nijedan kurs
SELECT * FROM student 
WHERE sno NOT IN (SELECT sno FROM report);

-- Zadatak 18: Prikazivanje studenata koji su upisali vise od dva kursa
SELECT sno, COUNT(*) FROM report 
GROUP BY sno HAVING COUNT(*) > 2;

-- Zadatak 19: Prikazivanje studenata koji su upisali kurs "Software Engineering"
SELECT sname FROM student 
JOIN report ON student.sno = report.sno 
JOIN course ON report.cno = course.cno 
WHERE course.title = 'Software Engineering';

-- Zadatak 20: Prikazivanje predavaca koji predaju vise od jednog kursa
SELECT lname FROM course 
GROUP BY lname 
HAVING COUNT(*) > 1;

-- Zadatak 21: Prikazivanje studenata koji imaju ocjenu "NULL" za neki kurs
SELECT sname FROM student 
JOIN report ON student.sno = report.sno 
WHERE report.mark IS NULL;

-- Zadatak 22: Prikazivanje studenata koji nisu polozili nijedan ispit (mark < 50 za svaki kurs)
SELECT sname FROM student 
WHERE sno NOT IN (SELECT sno FROM report WHERE mark >= 50);

-- Zadatak 23: Prikazivanje svih studenata i njihovih ocjena za kurs "Numerical Analysis"
SELECT sname, mark FROM student 
JOIN report ON student.sno = report.sno 
JOIN course ON report.cno = course.cno 
WHERE course.title = 'Numerical Analysis';

-- Zadatak 24: Prikazivanje studenata koji su upisali barem jedan kurs sa ocjenom vecom od 80
SELECT DISTINCT sname FROM student 
JOIN report ON student.sno = report.sno 
WHERE report.mark > 80;

-- Zadatak 25: Prikazivanje svih kurseva sa ocjenama vecim od 70
SELECT title, mark FROM course 
JOIN report ON course.cno = report.cno 
WHERE mark > 70;

-- Zadatak 26: Prikazivanje studenata sa njihovim imenom i ukupnim brojem polozenih ispita (mark >= 50)
SELECT sname, COUNT(*) FROM student 
JOIN report ON student.sno = report.sno 
WHERE report.mark >= 50 
GROUP BY sname;

-- Zadatak 27: Prikazivanje broja studenata koji su upisali kurs "Compilers"
SELECT COUNT(DISTINCT sno) FROM report 
WHERE cno = 121;

-- Zadatak 28: Prikazivanje predavaca sa brojem kurseva koje predaju
SELECT lname, COUNT(*) FROM course 
GROUP BY lname;

-- Zadatak 29: Prikazivanje svih studenata koji imaju bar jedan kurs sa ocjenom ispod 60
SELECT DISTINCT sname FROM student 
JOIN report ON student.sno = report.sno 
WHERE report.mark < 60;

-- Zadatak 30: Prikazivanje svih kurseva koji imaju najmanje dva studenta sa ocjenama iznad 70
SELECT title FROM course 
JOIN report ON course.cno = report.cno 
GROUP BY title 
HAVING COUNT(DISTINCT sno) >= 2 AND AVG(mark) > 70;

-- Zadatak 31: Prikazivanje studenata koji su na nivou 3 i imaju prosjecnu ocjenu iznad 75
SELECT sno, AVG(mark) FROM student 
JOIN report ON student.sno = report.sno 
WHERE student.level = 3 
GROUP BY sno 
HAVING AVG(mark) > 75;

-- Zadatak 32: Prikazivanje svih kurseva koje predaje predavac "Quinn"
SELECT title FROM course 
WHERE lname = 'Quinn';

-- Zadatak 33: Prikazivanje studenata sa njihovim ocjenama na svim kursevima, samo za studente koji su prosli (mark >= 50)
SELECT sname, title, mark FROM student 
JOIN report ON student.sno = report.sno 
JOIN course ON report.cno = course.cno 
WHERE mark >= 50;

-- Zadatak 34: Prikazivanje studenata koji su imali 3 ili vise kurseva sa ocjenom vecom od 60
SELECT sno, COUNT(*) FROM report 
WHERE mark > 60 
GROUP BY sno 
HAVING COUNT(*) >= 3;

-- Zadatak 35: Prikazivanje predavaca koji predaju kurs "Numerical Analysis" sa njihovim ucionicama
SELECT lname, roomno FROM lecturer 
JOIN course ON lecturer.lname = course.lname 
WHERE course.title = 'Numerical Analysis';

-- Zadatak 36: Prikazivanje studenata koji imaju razlicite ocjene na svim kursevima
SELECT sname, COUNT(DISTINCT mark) FROM student 
JOIN report ON student.sno = report.sno 
GROUP BY sname 
HAVING COUNT(DISTINCT mark) > 1;

-- Zadatak 37: Prikazivanje svih kurseva koji nisu upisali studenti sa ocjenom ispod 50
SELECT title FROM course 
WHERE cno NOT IN (SELECT cno FROM report WHERE mark < 50);

-- Zadatak 38: Prikazivanje broja studenata koji su upisali vise kurseva od broja predavaca
SELECT COUNT(DISTINCT sno) FROM report 
GROUP BY sno 
HAVING COUNT(DISTINCT cno) > (SELECT COUNT(*) FROM lecturer);