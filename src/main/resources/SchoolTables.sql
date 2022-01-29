CREATE TABLE "person" (
    "person_id" int GENERATED ALWAYS AS IDENTITY
    (start with 110 increment by 1),
    "age" VARCHAR(10) NOT NULL,
    "caregiver_phone_number" VARCHAR(10),
    "first_name" VARCHAR(100) NOT NULL,
    "last_name" VARCHAR(100) NOT NULL,
    "person_number" VARCHAR(10) NOT NULL
);

ALTER TABLE "person" ADD CONSTRAINT "PK_person" PRIMARY KEY ("person_id");

CREATE TABLE "student" (
    "student_id" int GENERATED ALWAYS AS IDENTITY
    (start with 320 increment by 1),
    "sibling_person_number" VARCHAR(10),
    "person_id" int NOT NULL 
);

ALTER TABLE "student" ADD CONSTRAINT "PK_student" PRIMARY KEY ("student_id");

CREATE TABLE "instructor" (
    "instructor_id" int GENERATED ALWAYS AS IDENTITY
    (start with 820 increment by 1),
    "instructor_arsenal" VARCHAR(100),
    "instructor_price" VARCHAR(100),
    "person_id" int NOT NULL 
);

ALTER TABLE "instructor" ADD CONSTRAINT "PK_instructor" PRIMARY KEY ("instructor_id");

CREATE TABLE "payment" (
	"payment_id" int GENERATED ALWAYS AS IDENTITY
	(start with 620 increment by 1),
    "date" TIMESTAMP(6),
    "time" TIMESTAMP(6),
    "amount_of_lessons" int,
    "type_of_lessons" VARCHAR(10),
    "lesson_skill_level" VARCHAR(10),
    "admin_id" int NOT NULL 
);

ALTER TABLE "payment" ADD CONSTRAINT "PK_payment" PRIMARY KEY ("payment_id");

CREATE TABLE "student_payment" (
    "student_payment_id" int GENERATED ALWAYS AS IDENTITY
    (start with 420 increment by 1),
    "student_id" int NOT NULL,
	"payment_id" int NOT NULL,
    "applied_discount" VARCHAR(100)
);

ALTER TABLE "student_payment" ADD CONSTRAINT "PK_student_payment" PRIMARY KEY ("student_payment_id");

CREATE TABLE "instructor_payment" (
    "instructor_payment_id" int GENERATED ALWAYS AS IDENTITY
    (start with 520 increment by 1),
    "instructor_id" int NOT NULL,
	"payment_id" int NOT NULL,
    "taxes" VARCHAR(100)
);


ALTER TABLE "instructor_payment" ADD CONSTRAINT "PK_instructor_payment" PRIMARY KEY ("instructor_payment_id");

CREATE TABLE "student_rented" (
    "student_rented_id" int GENERATED ALWAYS AS IDENTITY
    (start with 720 increment by 1),
    "student_id" int NOT NULL, 
    "rented_instruments" VARCHAR(10)
);


ALTER TABLE "student_rented" ADD CONSTRAINT "PK_student_rented" PRIMARY KEY ("student_rented_id");

CREATE TABLE "discount_for_siblings" (
    "discount_for_siblings_id" int GENERATED ALWAYS AS IDENTITY
    (start with 920 increment by 1),
    "student_id" int NOT NULL, 
    "student_payment_id" int NOT NULL,
    "percentage_discount" VARCHAR(10)
);


ALTER TABLE "discount_for_siblings" ADD CONSTRAINT "PK_discount_for_siblings" PRIMARY KEY ("discount_for_siblings_id");

CREATE TABLE "instrument_renting" (
    "instrument_renting_id" int GENERATED ALWAYS AS IDENTITY
    (start with 1010 increment by 1),
    "student_id" int NOT NULL, 
    "price" VARCHAR(10),
    "amount" VARCHAR(10),
    "date" TIMESTAMP(6)
);

ALTER TABLE "instrument_renting" ADD CONSTRAINT "PK_instrument_renting" PRIMARY KEY ("instrument_renting_id");

CREATE TABLE "skill_level" (
    "skill_level_id" int GENERATED ALWAYS AS IDENTITY
    (start with 200 increment by 1),
    "student_id" int NOT NULL, 
    "beginner" VARCHAR(1),
    "intermediet" VARCHAR(1),
    "advanced" VARCHAR(1)
);

ALTER TABLE "skill_level" ADD CONSTRAINT "PK_skill_level" PRIMARY KEY ("skill_level_id");

CREATE TABLE "lesson" (
    "lesson_id" int GENERATED ALWAYS AS IDENTITY
    (start with 10 increment by 1 ),
    "student_id" int NOT NULL,
    "instructor_id" int NOT NULL, 
    "instrument_type" VARCHAR(10),
    "date" TIMESTAMP(6),
    "time" TIMESTAMP(6)
);

ALTER TABLE "lesson" ADD CONSTRAINT "PK_lesson" PRIMARY KEY ("lesson_id");

CREATE TABLE "ensembles" (
    "ensembles_id" int GENERATED ALWAYS AS IDENTITY
    (start with 1 increment by 1),
    "lesson_id" int NOT NULL, 
    "maximum_number_of_students" VARCHAR(10),
    "minimum_number_of_students" VARCHAR(10),
    "genre" VARCHAR(100)
);


ALTER TABLE "ensembles" ADD CONSTRAINT "PK_ensembles" PRIMARY KEY ("ensembles_id");

CREATE TABLE "individual_lesson" (
    "individual_lesson_id" int GENERATED ALWAYS AS IDENTITY
    (start with 120 increment by 1),
    "lesson_id" int NOT NULL, 
    "appointments" VARCHAR(10)
);

ALTER TABLE "individual_lesson" ADD CONSTRAINT "PK_individual_lesson" PRIMARY KEY ("individual_lesson_id");

CREATE TABLE "group_lesson" (
    "group_lesson_id" int GENERATED ALWAYS AS IDENTITY
    (start with 320 increment by 1),
    "lesson_id" int NOT NULL, 
    "minimum_spot_limit" VARCHAR(10)
);


ALTER TABLE "group_lesson" ADD CONSTRAINT "PK_group_lesson" PRIMARY KEY ("group_lesson_id");

CREATE TABLE "school_server" (
    "web_page" VARCHAR(10)
);

CREATE TABLE "instrument_stock" (
    "instrument_stock_id" int GENERATED ALWAYS AS IDENTITY
    (start with 520 increment by 1),
    "instrument_type" VARCHAR(10),
    "instrument_quantity" VARCHAR(10),
    "instrument_brand" VARCHAR(10)
);

ALTER TABLE "instrument_stock" ADD CONSTRAINT "PK_instrument_stock" PRIMARY KEY ("instrument_stock_id");

CREATE TABLE "administrative_staff" (
    "admin_id" int GENERATED ALWAYS AS IDENTITY
    (start with 1 increment by 1),
    "bookings" VARCHAR(10),
    "person_id" int NOT NULL
);


ALTER TABLE "administrative_staff" ADD CONSTRAINT "PK_administrative_staff" PRIMARY KEY ("admin_id");

CREATE TABLE "instructor_scheduele" (
    "instructor_scheduele_id" int GENERATED ALWAYS AS IDENTITY
    (start with 1400 increment by 1),
    "instructor_id" int NOT NULL,
    "time" TIMESTAMP(6),
    "date" TIMESTAMP(6),
    "class_room" VARCHAR(100),
    "type_of_lesson" VARCHAR(100)
);

ALTER TABLE "instructor_scheduele" ADD CONSTRAINT "PK_instructor_scheduele" PRIMARY KEY ("instructor_scheduele_id");


/* FK DOWN */

ALTER TABLE "student" ADD CONSTRAINT "FK_student_0" FOREIGN KEY ("person_id") REFERENCES "person" ("person_id");

ALTER TABLE "instructor" ADD CONSTRAINT "FK_instructor_0" FOREIGN KEY ("person_id") REFERENCES "person" ("person_id");

ALTER TABLE "payment" ADD CONSTRAINT "FK_payment_0" FOREIGN KEY ("admin_id") REFERENCES "administrative_staff" ("admin_id");

ALTER TABLE "student_payment" ADD CONSTRAINT "FK_student_payment_0" FOREIGN KEY ("student_id") REFERENCES "person" ("person_id");
ALTER TABLE "student_payment" ADD CONSTRAINT "FK_student_payment_1" FOREIGN KEY ("payment_id") REFERENCES "payment" ("payment_id");

ALTER TABLE "instructor_payment" ADD CONSTRAINT "FK_instructor_payment_0" FOREIGN KEY ("instructor_id") REFERENCES "instructor" ("instructor_id");
ALTER TABLE "instructor_payment" ADD CONSTRAINT "FK_instructor_payment_1" FOREIGN KEY ("payment_id") REFERENCES "payment" ("payment_id");

ALTER TABLE "student_rented" ADD CONSTRAINT "FK_student_rented_0" FOREIGN KEY ("student_id") REFERENCES "student" ("student_id");

ALTER TABLE "discount_for_siblings" ADD CONSTRAINT "FK_discount_for_siblings_0" FOREIGN KEY ("student_id") REFERENCES "student" ("student_id");
ALTER TABLE "discount_for_siblings" ADD CONSTRAINT "FK_discount_for_siblings_1" FOREIGN KEY ("student_payment_id") REFERENCES "student_payment" ("student_payment_id");

ALTER TABLE "instrument_renting" ADD CONSTRAINT "FK_instrument_renting_0" FOREIGN KEY ("student_id") REFERENCES "student" ("student_id");

ALTER TABLE "skill_level" ADD CONSTRAINT "FK_skill_level_0" FOREIGN KEY ("student_id") REFERENCES "student" ("student_id");

ALTER TABLE "lesson" ADD CONSTRAINT "FK_lesson_0" FOREIGN KEY ("student_id") REFERENCES "student" ("student_id");
ALTER TABLE "lesson" ADD CONSTRAINT "FK_lesson_1" FOREIGN KEY ("instructor_id") REFERENCES "instructor" ("instructor_id");

ALTER TABLE "ensembles" ADD CONSTRAINT "FK_ensembles_0" FOREIGN KEY ("lesson_id") REFERENCES "lesson" ("lesson_id");

ALTER TABLE "individual_lesson" ADD CONSTRAINT "FK_individual_lesson_0" FOREIGN KEY ("lesson_id") REFERENCES "lesson" ("lesson_id");

ALTER TABLE "group_lesson" ADD CONSTRAINT "FK_individual_lesson_0" FOREIGN KEY ("lesson_id") REFERENCES "lesson" ("lesson_id");

ALTER TABLE "administrative_staff" ADD CONSTRAINT "FK_administrative_staff_0" FOREIGN KEY ("person_id") REFERENCES "person" ("person_id");

ALTER TABLE "instructor_scheduele" ADD CONSTRAINT "FK_instructor_scheduele_0" FOREIGN KEY ("instructor_id") REFERENCES "instructor" ("instructor_id");





