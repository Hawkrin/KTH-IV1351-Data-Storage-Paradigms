/*QUESTION 1*/
SELECT 
    EXTRACT(month FROM lesson.date) AS month,
    EXTRACT(year FROM lesson.date) AS year,
    count(ensembles.genre) AS ensembles,
    count(group_lesson.*) AS "group lessos",
    count(individual_lesson.*) AS "individual lessons"
    FROM lesson
        FULL JOIN ensembles ON lesson.lesson_id = ensembles.lesson_id
        FULL JOIN group_lesson ON lesson.lesson_id = group_lesson.lesson_id
        FULL JOIN individual_lesson ON lesson.lesson_id = individual_lesson.lesson_id
    GROUP BY (EXTRACT(month FROM lesson.date)), (EXTRACT(year FROM lesson.date))
    ORDER BY (EXTRACT(month FROM lesson.date));


/*QUESTION 2*/
SELECT 
    EXTRACT(month FROM lesson.date) AS month,
    EXTRACT(year FROM lesson.date) AS year,
    count(ensembles.genre)::numeric / 12::numeric AS ensembles,
    count(group_lesson.*)::numeric / 12::numeric AS "group lesson",
    count(individual_lesson.*)::numeric / 12::numeric AS "individual lesson"
    FROM lesson
        FULL JOIN ensembles ON lesson.lesson_id = ensembles.lesson_id
        FULL JOIN group_lesson ON lesson.lesson_id = group_lesson.lesson_id
        FULL JOIN individual_lesson ON lesson.lesson_id = individual_lesson.lesson_id
    GROUP BY (EXTRACT(month FROM lesson.date)), (EXTRACT(year FROM lesson.date))
    ORDER BY (EXTRACT(month FROM lesson.date));


/*QUESTION 3*/ 
SELECT les.instructor_id,
    per.first_name,
    per.last_name,
    count(les.instructor_id) AS "given lessons",
        CASE
            WHEN count(les.instructor_id) > 1 THEN 'true'::text
            ELSE 'false'::text
            END AS overtime
    FROM lesson les
        JOIN instructor ins ON ins.instructor_id = les.instructor_id
        JOIN person per ON per.person_id = ins.person_id
    GROUP BY les.instructor_id, per.first_name, per.last_name
    HAVING count(les.instructor_id) > 1
    ORDER BY (count(les.instructor_id)) DESC;


/*QUESTION 4*/
SELECT ensembles.maximum_number_of_students,
    ensembles.minimum_number_of_students,
    ensembles.genre,
    EXTRACT(year FROM now()) AS year,
    EXTRACT(week FROM now()) + 1::numeric AS week_number,
    EXTRACT(day FROM now()) AS day,
            CASE
                WHEN (ensembles.maximum_number_of_students::numeric - (( SELECT count(*) AS count
                FROM lesson lesson_1
                WHERE lesson_1.lesson_id = ensembles.lesson_id))::numeric) = 0::numeric THEN 'Full booked'::text
                WHEN (ensembles.maximum_number_of_students::numeric - (( SELECT count(*) AS count
                FROM lesson lesson_1
                WHERE lesson_1.lesson_id = ensembles.lesson_id))::numeric) = 1::numeric OR (ensembles.maximum_number_of_students::numeric - (( SELECT count(*) AS count
                FROM lesson lesson_1
                WHERE lesson_1.lesson_id = ensembles.lesson_id))::numeric) = 2::numeric THEN 'A few spots are left'::text
                ELSE 'Has more seats left'::text
            END AS status
    FROM ensembles
        JOIN lesson ON ensembles.lesson_id = lesson.lesson_id
    GROUP BY (EXTRACT(year FROM now())), ensembles.genre, ensembles.maximum_number_of_students, ensembles.minimum_number_of_students, lesson.date, ensembles.ensembles_id
    ORDER BY (ROW(EXTRACT(day FROM lesson.date), ensembles.genre));

/*QUESTION 5*/
SELECT s.instrument_type instrument_type, s.instrument_brand brand, p.first_name, p.last_name, r.amount quantity FROM 
    instrument_renting r INNER
    JOIN instrument_stock s 
        ON r.instrument_stock_id = s.instrument_stock_id
    INNER JOIN student 
        ON student.student_id = r.student_id 
    INNER JOIN person p
        ON p.person_id = student.person_id

/*QUESTION 6*/ SELECT s.instrument_type,
    s.instrument_brand AS brand,
    p.first_name,
    p.last_name,
    r.amount AS quantity
    FROM instrument_renting r
        JOIN instrument_stock s ON r.instrument_stock_id = s.instrument_stock_id
        JOIN student ON student.student_id = r.student_id
        JOIN person p ON p.person_id = student.person_id;
