/*QUESTION 1*/
declare
	amount bigint;
begin
	select count(*)
	into amount
	from lesson
	where EXTRACT(YEAR FROM date) = $1::numeric AND
	EXTRACT(MONTH FROM date) = $2::numeric;
	
	return amount;
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
