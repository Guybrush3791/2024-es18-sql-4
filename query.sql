-- NOME REPOSITORY: 2024-es2-database

-- Esercizi solo con SELECT
-- 1. Seleziona tutti i professori dal dipartimento di Informatica.
-- res: 1

SELECT *
FROM professor
WHERE department LIKE 'Informatica'; 

-- 2. Elenca tutti gli studenti iscritti nell'anno 2021.
-- res: 2

SELECT *
FROM student
WHERE subscription_year = 2021

-- 3. Visualizza tutti i corsi offerti dal dipartimento di Fisica.
-- res: 1

SELECT *
FROM course 
WHERE department LIKE 'fisica';

-- 4. Mostra i nomi dei corsi insieme ai relativi dipartimenti.
-- res: 10

SELECT name, department 
FROM course

-- 5. Conta il numero totale di studenti iscritti all'università.
-- res: 1 (value: 10)

SELECT COUNT(*) 
FROM student

-- Esercizi con GROUP BY e HAVING
-- 6. Conta quanti corsi sono offerti in ogni dipartimento.
-- res: 10 (uno per dipartimento)

SELECT department, COUNT(*)
FROM course
GROUP BY department 

-- DELETED
-- 7. Trova i dipartimenti che hanno più di 3 corsi.
-- res: 
-- DELETED



-- 8. Elenca il numero di studenti iscritti per ogni anno di iscrizione.
-- res: 5 (3, 2, 2, 2, 1)

SELECT subscription_year, COUNT(*)
FROM student 
GROUP BY subscription_year 

-- DELETED
-- 9. Mostra il numero medio di studenti per corso in ogni dipartimento.
-- res: 
-- DELETED

-- DELETED
-- 10. Trova i professori che insegnano più di un corso.
-- res: 
-- DELETED


-- Esercizi con JOIN
-- 11. Mostra il nome di ogni studente insieme al nome del corso a cui e' iscritti.
-- res: 30

SELECT student.name, course.name
FROM student
	JOIN course_subscription
		ON student.id = course_subscription.student_id 
	JOIN course
		ON course_subscription.course_id = course.id

-- 12. Elenca tutti i corsi insieme ai nomi dei professori che li seguono.
-- res: 10

SELECT course.name, professor.name
FROM course
	JOIN professor
		ON course.professor_id = professor.id

-- 13. Trova gli studenti iscritti a corsi relativi al dipartimento di Chimica.
-- res: 3

SELECT student.name, course.name
FROM course
	JOIN course_subscription 
		ON course.id = course_subscription.course_id 
	JOIN student
		ON course_subscription.student_id = student.id
WHERE department LIKE 'Chimica'

-- 14. Visualizza i nomi degli studenti e i corsi che hanno frequentato nel 2022.
-- res: 6

SELECT student.name, course.name
FROM course
	JOIN course_subscription 
		ON course.id = course_subscription.course_id 
	JOIN student
		ON course_subscription.student_id = student.id
WHERE student.subscription_year = 2022

-- 15. Elencare i professori con i loro corsi e i relativi dipartimenti.
-- res: 10

SELECT professor.name, professor.department, course.name
FROM professor
	JOIN course
		ON professor.id = course.professor_id 

-- DELETED
-- 16. Trova i corsi senza studenti iscritti.
-- res: 
-- DELETED

-- DELETED
-- 17. Mostra i corsi con più di 5 iscritti.
-- res: 
-- DELETED

-- DELETED
-- 18. Elenca tutti i professori che non hanno corsi assegnati.
-- res: 
-- DELETED


-- 19. Visualizza i corsi con il maggior numero di studenti.
-- res: 1 (3)

-- VERSIONE ACCETTABILE (ma scorretta)
SELECT course.id, course.name, COUNT(*) AS ncourse
FROM course
	JOIN course_subscription 
		ON course.id = course_subscription.course_id  
GROUP BY course.id
ORDER BY ncourse DESC
LIMIT 1;

-- VERSIONE TOP
SELECT course.id, course.name, COUNT(*) AS ncourse
FROM course
	JOIN course_subscription 
		ON course.id = course_subscription.course_id  
GROUP BY course.id
HAVING ncourse = (
	SELECT COUNT(*) ncourse
	FROM course
		JOIN course_subscription 
			ON course.id = course_subscription.course_id  
	GROUP BY course.id
	ORDER BY ncourse DESC
	LIMIT 1
);

-- DELETED
-- 20. Trova gli studenti che sono iscritti a più di 3 corsi.
-- res: 
-- DELETED