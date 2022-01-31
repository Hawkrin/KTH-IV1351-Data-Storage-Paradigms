/*QUESTION 1*/
declare
	amount bigint;
	individual_lessons bigint;
	group_lessons bigint;
	ensemble_lessons bigint;
	
	id_lesson bigint;
	
begin
	select count(*)
	into amount
	from lesson
	where EXTRACT(YEAR FROM date) = $1::numeric AND
	EXTRACT(MONTH FROM date) = $2::numeric;
	
	select lesson_id
	into id_lesson
	from lesson
	where EXTRACT(YEAR FROM date) = $1::numeric AND
	EXTRACT(MONTH FROM date) = $2::numeric;
	
	select count(*)
	into individual_lessons
	from individual_lesson
	where lesson_id=id_lesson;
	
	select count(*)
	into group_lessons
	from group_lesson
	where lesson_id=id_lesson;
		
	select count(*)
	into ensemble_lessons
	from ensembles
	where lesson_id=id_lesson;
	
	return  (individual_lessons::numeric+ group_lessons::numeric+ensemble_lessons::numeric)::name || ' ' || individual_lessons || ' ' || group_lessons || ' ' || ensemble_lessons;
	
	
end;


/*QUESTION 2*/
declare
	amount integer;
begin
	select avg(this_year_count) as this_year_avg
	into amount
	from
	(select count(*) as this_year_count
	from lesson
	where EXTRACT(YEAR FROM date) = $1::numeric
	) Z;
	
	return amount/12;
end;


/*QUESTION 3*/ 
SELECT 
        per.first_name,
        per.last_name,
        per.person_number
        FROM
            person as per
            JOIN instructor as ins
                ON per.person_id = ins.person_id
            JOIN lesson as les
                ON les.instructor_id = ins.instructor_id

        WHERE (SELECT count(*) WHERE les.instructor_id = ins.instructor_id) = ?;


/*QUESTION 4*/
SELECT * FROM 
    lesson AS les
    JOIN ensembles as ens
        ON les.lesson_id = ens.lesson_id
    WHERE 
        (ens.maximum_number_of_students - (SELECT COUNT() FROM lesson WHERE lesson_id = ens.lesson_id) >= 1) AND
        (ens.maximum_number_of_students - (SELECT COUNT() FROM lesson WHERE lesson_id = ens.lesson_id) <= 2)

SELECT * FROM 
    lesson AS les
    JOIN ensembles as ens
        ON les.lesson_id = ens.lesson_id
    WHERE 
        (ens.maximum_number_of_students - (SELECT COUNT(*) FROM lesson WHERE lesson_id = ens.lesson_id) = 0) 

SELECT * FROM 
    lesson AS les
    JOIN ensembles as ens
        ON les.lesson_id = ens.lesson_id
    WHERE 
        (ens.maximum_number_of_students - (SELECT COUNT(*) FROM lesson WHERE lesson_id = ens.lesson_id) > 2)
