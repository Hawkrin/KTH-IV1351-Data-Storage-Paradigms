/*QUESTION 1*/
CREATE OR REPLACE FUNCTION public.first_question(
	character varying,
	character varying)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
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
$BODY$;

ALTER FUNCTION public.first_question(character varying, character varying)
    OWNER TO postgres;


/*QUESTION 2*/
CREATE OR REPLACE FUNCTION public.second_question(
	character varying)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
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
	
	return amount;
end;
$BODY$;

ALTER FUNCTION public.second_question(character varying)
    OWNER TO postgres;


/*QUESTION 3*/ 
CREATE OR REPLACE FUNCTION public.third_question(
	character varying)
    RETURNS record
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	ret RECORD;
begin
	SELECT 
	per.first_name,
	per.last_name,
	per.person_number
	INTO ret
	FROM
		person as per
		JOIN instructor as ins
			ON per.person_id = ins.person_id
		JOIN lesson as les
			ON les.instructor_id = ins.instructor_id

	WHERE ins.person_id = 865;
	
	return ret;
end;
$BODY$;

ALTER FUNCTION public.third_question(character varying)
    OWNER TO postgres;

