create table "school_Information"
(
	school_id uuid not null
		constraint schoolinformation_pk
			primary key,
	school_name varchar(150) not null,
	school_web_address varchar(150),
	phone varchar(20),
	fax varchar(20),
	email_contact varchar(150),
	about_us varchar(255),
	is_active boolean default true,
	created_at timestamp,
	updated_at timestamp
);

comment on table "school_Information" is 'School Information ';

alter table "school_Information" owner to postgres;

create unique index schoolinformation_school_id_uindex
	on "school_Information" (school_id);

create unique index schoolinformation_school_name_uindex
	on "school_Information" (school_name);

create table school_type
(
	school_type_id uuid not null
		constraint school_type_pk
			primary key,
	school_type_name varchar(50) not null,
	school_type_description varchar(255),
	is_active boolean default true,
	created_at timestamp not null,
	updated_at timestamp
);

comment on table school_type is 'type of school';

alter table school_type owner to postgres;

create unique index school_type_school_type_id_uindex
	on school_type (school_type_id);

create table schools_types
(
	school_id uuid not null
		constraint schools_types_school_information_school_id_fk
			references "school_Information",
	school_type_id uuid not null
		constraint schools_types_school_type_school_type_id_fk
			references school_type,
	created_at timestamp,
	updated_at timestamp,
	constraint schools_types_pkey
		primary key (school_id, school_type_id)
);

alter table schools_types owner to postgres;

create table prefix_name
(
	prefix_id serial not null
		constraint prefix_name_pk
			primary key,
	prefix_name varchar(50) not null,
	is_active boolean default true,
	created_at timestamp not null,
	updated_at timestamp
);

alter table prefix_name owner to postgres;

create table teaches
(
	teacher_id uuid not null
		constraint teaches_pk
			primary key,
	teacher_code varchar(20) not null,
	teacher_firstname varchar(50) not null,
	teacher_lastname varchar(50) not null,
	teacher_date_of_birth timestamp,
	gender char,
	phone varchar(10),
	mobile_no varchar(10),
	is_active boolean default true,
	created_at timestamp,
	updated_at timestamp
);

comment on column teaches.gender is 'M = Male
F = Female';

alter table teaches owner to postgres;

create unique index teaches_teacher_code_uindex
	on teaches (teacher_code);

create unique index teaches_teacher_id_uindex
	on teaches (teacher_id);

create table tchs_types
(
	teacher_id uuid not null
		constraint tchs_types_teaches_teacher_id_fk
			references teaches,
	school_type_ud uuid not null
		constraint tchs_types_school_type_school_type_id_fk
			references school_type,
	created_at timestamp not null,
	updated_at timestamp,
	constraint tchs_types_pkey
		primary key (teacher_id, school_type_ud)
);

comment on table tchs_types is 'อาจารย์สอนระดับชั้นไหนบ้าง';

alter table tchs_types owner to postgres;

create table subjects
(
	subject_id uuid not null
		constraint subject_pk
			primary key,
	subject_code varchar(10) not null,
	subject_name varchar(100) not null,
	subject_description varchar(255),
	subject_education_year varchar(4),
	subject_education_semester varchar(2),
	subject_education_section varchar(10),
	is_active boolean default true,
	created_at timestamp not null,
	updated_at timestamp
);

comment on table subjects is 'รายวิชา';

comment on column subjects.subject_education_section is 'เช้า
บ่าย
ค่ำ';

alter table subjects owner to postgres;

create unique index subject_subject_id_uindex
	on subjects (subject_id);

create table courses
(
	course_id uuid not null
		constraint courses_pk
			primary key,
	course_name varchar(100) not null,
	course_description varchar(255),
	course_education_year varchar(4) not null,
	course_education_semester varchar(2),
	course_education_section varchar(10),
	is_active boolean default true,
	created_at timestamp not null,
	updated_at timestamp,
	course_code varchar(10)
);

comment on column courses.course_education_section is 'เช้า
บ่าย
ค่ำ';

alter table courses owner to postgres;

create unique index courses_course_id_uindex
	on courses (course_id);

create unique index courses_course_name_uindex
	on courses (course_name);

create table courses_subjects
(
	course_id uuid not null
		constraint courses_subjects_courses_course_id_fk
			references courses,
	subject_id uuid not null
		constraint courses_subjects_subjects_subject_id_fk
			references subjects,
	constraint courses_subjects_pkey
		primary key (course_id, subject_id)
);

alter table courses_subjects owner to postgres;

create table lectures
(
	teacher_id uuid not null
		constraint lectures_teaches_teacher_id_fk
			references teaches,
	subject_id uuid not null
		constraint lectures_subjects_subject_id_fk
			references subjects,
	constraint lectures_pkey
		primary key (teacher_id, subject_id)
);

alter table lectures owner to postgres;




INSERT INTO public."school_Information" (school_id, school_name, school_web_address, phone, fax, email_contact, about_us, is_active, created_at, updated_at) VALUES ('4ce5a825-9f73-4d6e-9306-f35f30704a87', 'โรงเรียนของหนูอยู่ไกลไกล๊ไกล', 'www.myschool.com', null, null, null, null, true, '2020-11-06 15:26:23.000000', null);
INSERT INTO public.school_type (school_type_id, school_type_name, school_type_description, is_active, created_at, updated_at) VALUES ('020cbd59-81c4-4ebc-ad62-269c72077d6e', 'ระดับประถมอนุบาล', 'ประกอบไปด้วยชั้น อ1-อ3', true, '2020-11-06 15:20:54.000000', null);
INSERT INTO public.school_type (school_type_id, school_type_name, school_type_description, is_active, created_at, updated_at) VALUES ('253e2177-d3de-4cc1-91c4-ad182dd50653', 'ระดับประถมศึกษา', 'ประกอบไปด้วยชั้น ป1-ป6', true, '2020-11-06 15:20:54.000000', null);
INSERT INTO public.school_type (school_type_id, school_type_name, school_type_description, is_active, created_at, updated_at) VALUES ('f47ec015-b048-4a21-8064-57c75e7a6de8', 'ระดับมัธยมศึกษา', 'ประกอบไปด้วยชั้น ม1-ม6', true, '2020-11-06 15:20:54.000000', null);
INSERT INTO public.schools_types (school_id, school_type_id, created_at, updated_at) VALUES ('4ce5a825-9f73-4d6e-9306-f35f30704a87', '020cbd59-81c4-4ebc-ad62-269c72077d6e', null, null);
INSERT INTO public.schools_types (school_id, school_type_id, created_at, updated_at) VALUES ('4ce5a825-9f73-4d6e-9306-f35f30704a87', '253e2177-d3de-4cc1-91c4-ad182dd50653', null, null);
INSERT INTO public.schools_types (school_id, school_type_id, created_at, updated_at) VALUES ('4ce5a825-9f73-4d6e-9306-f35f30704a87', 'f47ec015-b048-4a21-8064-57c75e7a6de8', null, null);
INSERT INTO public.teaches (teacher_id, teacher_code, teacher_firstname, teacher_lastname, teacher_date_of_birth, gender, phone, mobile_no, is_active, created_at, updated_at) VALUES ('260384ff-0e4a-4d58-8d37-41a350c0cae4', 'TCH0002', 'teacher 2', 'teacher lastname 1', '1990-06-06 17:28:23.000000', 'F', '024444444', '0890000001', true, '2020-11-06 16:26:26.000000', null);
INSERT INTO public.teaches (teacher_id, teacher_code, teacher_firstname, teacher_lastname, teacher_date_of_birth, gender, phone, mobile_no, is_active, created_at, updated_at) VALUES ('dc0728b7-3a25-4ca8-8327-4db98efd539d', 'TCH0001', 'teacher 1', 'teacher lastname 1', '1899-03-26 17:28:36.000000', 'M', '023333333', '0800000000', true, '2020-11-06 16:26:26.000000', null);
INSERT INTO public.teaches (teacher_id, teacher_code, teacher_firstname, teacher_lastname, teacher_date_of_birth, gender, phone, mobile_no, is_active, created_at, updated_at) VALUES ('f29a39c5-a5f9-4ea6-8adc-c4e688ba22b7', 'TCH0003', 'teacher 3', 'teacher lastname 1', '1980-06-10 17:28:23.000000', 'M', '025555555', '0600000500', true, '2020-11-06 16:26:26.000000', null);
INSERT INTO public.courses (course_id, course_name, course_description, course_education_year, course_education_semester, course_education_section, is_active, created_at, updated_at, course_code) VALUES ('84f17ac9-ad0c-4d60-beee-0c905cf5590e', 'ประถม (ภาษาอังกฤษ)', 'หลักสูตร international', '2020', '1', null, true, '2020-11-06 16:46:35.000000', null, 'PEN001');
INSERT INTO public.courses (course_id, course_name, course_description, course_education_year, course_education_semester, course_education_section, is_active, created_at, updated_at, course_code) VALUES ('74fdde17-5016-482e-b350-99605ef5b3fe', 'มัธยม', 'หลักสูตร ปกติ', '2020', '1', null, true, '2020-11-06 16:46:35.000000', null, 'STH001');
INSERT INTO public.courses (course_id, course_name, course_description, course_education_year, course_education_semester, course_education_section, is_active, created_at, updated_at, course_code) VALUES ('f938ad33-bb87-40af-a684-08390fee3bfb', 'อนุบาล', 'หลักสูตร ปกติ', '2020', '1', null, true, '2020-11-06 16:46:35.000000', null, 'KTH001');
INSERT INTO public.courses (course_id, course_name, course_description, course_education_year, course_education_semester, course_education_section, is_active, created_at, updated_at, course_code) VALUES ('0f29bc33-06e4-40f2-bdb4-303f17ab5908', 'มัธยม (ภาษาอังกฤษ)', 'หลักสูตร international', '2020', '1', null, true, '2020-11-06 16:46:35.000000', null, 'SEN001');
INSERT INTO public.courses (course_id, course_name, course_description, course_education_year, course_education_semester, course_education_section, is_active, created_at, updated_at, course_code) VALUES ('ee35398b-4529-4a27-ab65-8d5972b384a4', 'ประถม', 'หลักสูตร ปกติ', '2020', '1', null, true, '2020-11-06 16:46:35.000000', null, 'PTH001');
INSERT INTO public.courses (course_id, course_name, course_description, course_education_year, course_education_semester, course_education_section, is_active, created_at, updated_at, course_code) VALUES ('dfb5955c-2729-4635-8974-1f49ed5b2f78', 'อนุบาล (ภาษาอังกฤษ)', 'หลักสูตร international', '2020', '1', null, true, '2020-11-06 16:46:35.000000', null, 'KEN001');
INSERT INTO public.subjects (subject_id, subject_code, subject_name, subject_description, subject_education_year, subject_education_semester, subject_education_section, is_active, created_at, updated_at) VALUES ('b3d927a8-9735-4f31-8ef2-87288ed74460', 'KTHTH101', 'ภาษาไทย 1 ชั้นอนุบาล', 'ภาษาไทย 1 ชั้นอนุบาล', '2020', '1', null, true, '2020-11-06 16:55:07.000000', null);
INSERT INTO public.subjects (subject_id, subject_code, subject_name, subject_description, subject_education_year, subject_education_semester, subject_education_section, is_active, created_at, updated_at) VALUES ('a141f3a2-1ee0-4f21-a8a8-706da1ca9703', 'KTHEN101', 'ภาษาไทย 1 ชั้นอนุบาล', 'ภาษาไทย 1 ชั้นอนุบาล สำหรับนักเรียนต่างชาติ', '2020', '1', null, true, '2020-11-06 16:55:07.000000', null);
INSERT INTO public.subjects (subject_id, subject_code, subject_name, subject_description, subject_education_year, subject_education_semester, subject_education_section, is_active, created_at, updated_at) VALUES ('5f4e3182-7963-4997-98ce-92ff382e7302', 'PSCTH101', 'วิทยาศาสตร์ 1 ประถม 1', 'วิทยาศาสตร์ 1 ประถม 1', '2020', '1', null, true, '2020-11-06 16:55:07.000000', null);
INSERT INTO public.subjects (subject_id, subject_code, subject_name, subject_description, subject_education_year, subject_education_semester, subject_education_section, is_active, created_at, updated_at) VALUES ('862bd179-16f2-4948-ab1e-e5ed5b5f381b', 'PSCEN101', 'วิทยาศาสตร์ 1 ประถม 1', 'วิทยาศาสตร์ 1 ประถม 1 สำหรับนักเรียนต่างชาติ', '2020', '1', null, true, '2020-11-06 16:55:07.000000', null);
INSERT INTO public.subjects (subject_id, subject_code, subject_name, subject_description, subject_education_year, subject_education_semester, subject_education_section, is_active, created_at, updated_at) VALUES ('2d385d50-8c27-49a8-84f3-56bd9c53f83a', 'KSCEN101', 'วิทยาศาสตร์ 1 ชั้นอนุบาล', 'วิทยาศาสตร์ 1 ชั้นอนุบาล สำหรับนักเรียนต่างชาติ', '2020', '1', null, true, '2020-11-06 16:55:07.000000', null);
INSERT INTO public.subjects (subject_id, subject_code, subject_name, subject_description, subject_education_year, subject_education_semester, subject_education_section, is_active, created_at, updated_at) VALUES ('28a94276-347e-4863-aecf-c79ffa7ed6f4', 'SSCEN101', 'วิทยาศาสตร์ 1 มัธยม', 'วิทยาศาสตร์ 1 มัธยม สำหรับนักเรียนต่างชาติ', '2020', '1', null, true, '2020-11-06 16:55:07.000000', null);
INSERT INTO public.subjects (subject_id, subject_code, subject_name, subject_description, subject_education_year, subject_education_semester, subject_education_section, is_active, created_at, updated_at) VALUES ('4fd12fc9-d57f-4cc2-905e-f01c00de1f12', 'SSCTH101', 'วิทยาศาสตร์ 1 มัธยม', 'วิทยาศาสตร์ 1 มัธยม', '2020', '1', null, true, '2020-11-06 16:55:07.000000', null);
INSERT INTO public.subjects (subject_id, subject_code, subject_name, subject_description, subject_education_year, subject_education_semester, subject_education_section, is_active, created_at, updated_at) VALUES ('7d96ba3b-dcd1-46fa-8a3e-7b14127853ed', 'KENEN101', 'ภาษาอังกฤษ 1 ชั้นอนุบาล', 'ภาษาอังกฤษ 1 ชั้นอนุบาล สำหรับนักเรียนต่างชาติ', '2020', '1', null, true, '2020-11-06 16:55:07.000000', null);
INSERT INTO public.courses_subjects (course_id, subject_id) VALUES ('dfb5955c-2729-4635-8974-1f49ed5b2f78', 'a141f3a2-1ee0-4f21-a8a8-706da1ca9703');
INSERT INTO public.courses_subjects (course_id, subject_id) VALUES ('dfb5955c-2729-4635-8974-1f49ed5b2f78', '2d385d50-8c27-49a8-84f3-56bd9c53f83a');
INSERT INTO public.courses_subjects (course_id, subject_id) VALUES ('ee35398b-4529-4a27-ab65-8d5972b384a4', '5f4e3182-7963-4997-98ce-92ff382e7302');
INSERT INTO public.courses_subjects (course_id, subject_id) VALUES ('dfb5955c-2729-4635-8974-1f49ed5b2f78', '7d96ba3b-dcd1-46fa-8a3e-7b14127853ed');
INSERT INTO public.tchs_types (teacher_id, school_type_ud, created_at, updated_at) VALUES ('dc0728b7-3a25-4ca8-8327-4db98efd539d', '020cbd59-81c4-4ebc-ad62-269c72077d6e', '2020-11-06 16:03:09.000000', null);
INSERT INTO public.tchs_types (teacher_id, school_type_ud, created_at, updated_at) VALUES ('dc0728b7-3a25-4ca8-8327-4db98efd539d', '253e2177-d3de-4cc1-91c4-ad182dd50653', '2020-11-06 16:03:09.000000', null);
INSERT INTO public.tchs_types (teacher_id, school_type_ud, created_at, updated_at) VALUES ('f29a39c5-a5f9-4ea6-8adc-c4e688ba22b7', 'f47ec015-b048-4a21-8064-57c75e7a6de8', '2020-11-06 16:03:09.000000', null);
INSERT INTO public.lectures (teacher_id, subject_id) VALUES ('dc0728b7-3a25-4ca8-8327-4db98efd539d', 'a141f3a2-1ee0-4f21-a8a8-706da1ca9703');
INSERT INTO public.lectures (teacher_id, subject_id) VALUES ('dc0728b7-3a25-4ca8-8327-4db98efd539d', '5f4e3182-7963-4997-98ce-92ff382e7302');
INSERT INTO public.lectures (teacher_id, subject_id) VALUES ('dc0728b7-3a25-4ca8-8327-4db98efd539d', '2d385d50-8c27-49a8-84f3-56bd9c53f83a');





select *
from courses;

select *
from subjects;

select cs.course_id,
       c.course_code,
       c.course_name,
       cs.subject_id,
       s.subject_code,
       s.subject_name,
       s.subject_description
from courses_subjects cs
         join courses c on cs.course_id = c.course_id
         join subjects s on s.subject_id = cs.subject_id



select *
from teaches;

select *
from school_type;

select tt.teacher_id,
       t.teacher_code,
       t.teacher_firstname,
       t.teacher_lastname,
       t.gender,
       t.teacher_date_of_birth,
       t.mobile_no,
       tt.school_type_ud,
       st.school_type_name
from tchs_types tt
         join teaches t on tt.teacher_id = t.teacher_id
         join school_type st on tt.school_type_ud = st.school_type_id


select l.teacher_id,
       t.teacher_firstname,
       t.teacher_lastname,
       t.gender,
       t.teacher_date_of_birth,
       t.mobile_no,
       l.subject_id,
       s.subject_code,
       s.subject_name,
       s.subject_description
from lectures l
         join subjects s on s.subject_id = l.subject_id
         join teaches t on t.teacher_id = l.teacher_id