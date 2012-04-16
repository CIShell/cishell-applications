CREATE TABLE "APP"."ADDRESSES"
(
   PK int PRIMARY KEY NOT NULL,
   CITY varchar(32000),
   COUNTRY varchar(32000),
   POSTAL_CODE varchar(32000),
   RAW_ADDRESS varchar(32000),
   STATE_OR_PROVINCE varchar(32000),
   STREET_ADDRESS varchar(32000)
)
;
CREATE TABLE "APP"."AUTHORS"
(
   DOCUMENT_ID int,
   PERSON_ID int,
   EMAIL_ADDRESS varchar(32000),
   ORDER_LISTED int
)
;
CREATE TABLE "APP"."CITATIONS"
(
   PK int PRIMARY KEY NOT NULL,
   ANNOTATION varchar(32000),
   ARTICLE_NUMBER varchar(32000),
   AUTHOR_ID int,
   DIGITAL_OBJECT_IDENTIFIER varchar(32000),
   OTHER_INFORMATION varchar(32000),
   PAGE_NUMBER int,
   DOCUMENT_ID int,
   RAW_CITATION varchar(32000),
   VOLUME int,
   SOURCE_ID int,
   "YEAR" int,
   STARRED varchar(32000)
)
;
CREATE TABLE "APP"."CITED_CITATIONS"
(
   DOCUMENT_ID int,
   CITATION_ID int
)
;
CREATE TABLE "APP"."CITED_PATENTS"
(
   DOCUMENT_ID int,
   PATENT_ID int
)
;
CREATE TABLE "APP"."DOCUMENT_KEYWORDS"
(
   DOCUMENT_ID int,
   KEYWORD_ID int,
   ORDER_LISTED int
)
;
CREATE TABLE "APP"."DOCUMENT_OCCURRENCES"
(
   DOCUMENT_ID int,
   FILE_ID int
)
;
CREATE TABLE "APP"."DOCUMENTS"
(
   PK int PRIMARY KEY NOT NULL,
   ABSTRACT varchar(32000),
   DOCUMENT_NUMBER varchar(32000),
   BEGINNING_PAGE int,
   CITED_CITATION_COUNT int,
   DIGITAL_OBJECT_IDENTIFIER varchar(32000),
   ISI_TYPE varchar(32000),
   VOLUME int,
   ENDING_PAGE int,
   FIRST_AUTHOR_ID int,
   FUNDING_AGENCY_AND_GRANT_NUMBER varchar(32000),
   FUNDING_TEXT varchar(32000),
   ISBN varchar(32000),
   ISI_DOCUMENT_DELIVERY_NUMBER varchar(32000),
   ISI_UNIQUE_ARTICLE_IDENTIFIER varchar(32000),
   ISSUE varchar(32000),
   LANGUAGE varchar(32000),
   PAGE_COUNT int,
   PART_NUMBER varchar(32000),
   PUBLICATION_DATE varchar(32000),
   PUBLICATION_YEAR int,
   SOURCE_ID int,
   SPECIAL_ISSUE varchar(32000),
   SUBJECT_CATEGORY varchar(32000),
   SUPPLEMENT varchar(32000),
   TIMES_CITED int,
   TITLE varchar(32000),
   CITE_AS varchar(32000)
)
;
CREATE TABLE "APP"."EDITORS"
(
   DOCUMENT_ID int,
   PERSON_ID int,
   ORDER_LISTED int
)
;
CREATE TABLE "APP"."FILES"
(
   PK int PRIMARY KEY NOT NULL,
   FORMAT_VERSION_NUMBER varchar(32000),
   NAME varchar(32000),
   FILE_TYPE varchar(32000)
)
;
CREATE TABLE "APP"."KEYWORDS"
(
   PK int PRIMARY KEY NOT NULL,
   NAME varchar(32000),
   TYPE varchar(32000)
)
;
CREATE TABLE "APP"."PATENTS"
(
   PK int PRIMARY KEY NOT NULL,
   NUMBER varchar(32000)
)
;
CREATE TABLE "APP"."PEOPLE"
(
   PK int PRIMARY KEY NOT NULL,
   ADDITIONAL_NAME varchar(32000),
   FAMILY_NAME varchar(32000),
   FIRST_INITIAL varchar(32000),
   FULL_NAME varchar(32000),
   MIDDLE_INITIAL varchar(32000),
   FIRST_NAME varchar(32000),
   RAW_NAME varchar(32000)
)
;
CREATE TABLE "APP"."PUBLISHER_ADDRESSES"
(
   PUBLISHER_ID int,
   ADDRESS_ID int
)
;
CREATE TABLE "APP"."PUBLISHERS"
(
   PK int PRIMARY KEY NOT NULL,
   CITY varchar(32000),
   NAME varchar(32000),
   SOURCE_ID int,
   WEB_ADDRESS varchar(32000)
)
;
CREATE TABLE "APP"."REPRINT_ADDRESS"
(
   DOCUMENT_ID int,
   ADDRESS_ID int
)
;
CREATE TABLE "APP"."RESEARCH_ADDRESSES"
(
   DOCUMENT_ID int,
   ADDRESS_ID int,
   ORDER_LISTED int
)
;
CREATE TABLE "APP"."SOURCES"
(
   PK int PRIMARY KEY NOT NULL,
   BOOK_SERIES_TITLE varchar(32000),
   BOOK_SERIES_SUBTITLE varchar(32000),
   CONFERENCE_HOST varchar(32000),
   CONFERENCE_LOCATION varchar(32000),
   CONFERENCE_SPONSORS varchar(32000),
   CONFERENCE_TITLE varchar(32000),
   CONFERENCE_DATES varchar(32000),
   FULL_TITLE varchar(32000),
   ISO_TITLE_ABBREVIATION varchar(32000),
   ISSN varchar(32000),
   PUBLICATION_TYPE varchar(32000),
   TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION varchar(32000)
)
;





INSERT INTO "APP"."AUTHORS" (DOCUMENT_ID,PERSON_ID,EMAIL_ADDRESS,ORDER_LISTED) VALUES (1,2,'',1);
INSERT INTO "APP"."AUTHORS" (DOCUMENT_ID,PERSON_ID,EMAIL_ADDRESS,ORDER_LISTED) VALUES (1,1,'',0);
INSERT INTO "APP"."AUTHORS" (DOCUMENT_ID,PERSON_ID,EMAIL_ADDRESS,ORDER_LISTED) VALUES (2,7,'',0);
INSERT INTO "APP"."AUTHORS" (DOCUMENT_ID,PERSON_ID,EMAIL_ADDRESS,ORDER_LISTED) VALUES (3,12,'',0);
INSERT INTO "APP"."AUTHORS" (DOCUMENT_ID,PERSON_ID,EMAIL_ADDRESS,ORDER_LISTED) VALUES (4,18,'',1);
INSERT INTO "APP"."AUTHORS" (DOCUMENT_ID,PERSON_ID,EMAIL_ADDRESS,ORDER_LISTED) VALUES (4,17,'',0);
INSERT INTO "APP"."AUTHORS" (DOCUMENT_ID,PERSON_ID,EMAIL_ADDRESS,ORDER_LISTED) VALUES (5,24,'',1);
INSERT INTO "APP"."AUTHORS" (DOCUMENT_ID,PERSON_ID,EMAIL_ADDRESS,ORDER_LISTED) VALUES (5,23,'',0);


INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (1,null,null,71,null,null,147,null,'Bensman SJ, 1998, LIBR RESOUR TECH SER, V42, P147',42,1,1998,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (2,null,null,93,null,null,479,null,'Brodman E, 1944, B MED LIB ASS, V32, P479',32,2,1944,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (3,null,null,63,null,null,108,null,'Garfield E, 1955, SCIENCE, V122, P108',122,3,1955,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (4,null,null,73,null,null,null,null,'Wellman B, 1989, SOCIAL STRUCTURES NE',null,4,1989,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (5,null,null,75,null,null,null,null,'Asimov A, 1963, GENETIC CODE',null,6,1963,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (6,null,null,65,null,null,234,null,'Lederberg J, 1972, NATURE, V239, P234',239,7,1972,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (7,null,null,79,null,null,65,null,'Xxxx X, 2000, INT MICROBIOL, V10, P65',10,5,2000,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (8,null,null,81,null,null,486,null,'Xxxx X, 2000, P ASIST ANNU MEET, V40, P486',40,9,2000,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (9,null,null,95,null,null,147,null,'Bensman SJ, 1999, LIBR RESOUR TECH SER, V42, P147',42,1,1999,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (10,null,null,67,null,null,479,null,'Brodman E, 1945, B MED LIB ASS, V32, P479',32,2,1945,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (11,null,null,77,null,null,108,null,'Garfield E, 1959, SCIENCE, V122, P108',122,3,1959,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (12,null,null,69,null,null,null,null,'Wellman B, 1981, SOCIAL STRUCTURES NE',null,4,1981,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (13,null,null,87,null,null,137,null,'Avery OT, 1944, J EXP MED, V79, P137',79,16,1944,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (14,null,null,91,null,null,147,null,'Small H, 1985, J INFORM SCI, V11, P147',11,10,1985,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (16,null,null,85,null,null,119,null,'Xxxx X, 2001, J INFORM SCI, V30, P119',30,10,2001,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (17,null,null,89,null,null,403,null,'Garfield E, 1985, ESSAYS INFORMATION S, V8, P403',8,21,1985,'0');
INSERT INTO "APP"."CITATIONS" (PK,ANNOTATION,ARTICLE_NUMBER,AUTHOR_ID,DIGITAL_OBJECT_IDENTIFIER,OTHER_INFORMATION,PAGE_NUMBER,DOCUMENT_ID,RAW_CITATION,VOLUME,SOURCE_ID,"YEAR",STARRED) VALUES (18,null,null,83,null,null,113,null,'Gilbert GN, 1977, SOC STUD SCI, V7, P113',7,22,1977,'0');


INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (1,4);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (1,3);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (1,2);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (1,1);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (2,8);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (2,7);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (2,6);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (2,5);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (3,12);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (3,11);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (3,10);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (3,9);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (4,16);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (4,7);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (4,14);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (4,13);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (5,8);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (5,7);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (5,18);
INSERT INTO "APP"."CITED_CITATIONS" (DOCUMENT_ID,CITATION_ID) VALUES (5,17);






INSERT INTO "APP"."DOCUMENT_OCCURRENCES" (DOCUMENT_ID,FILE_ID) VALUES (1,1);
INSERT INTO "APP"."DOCUMENT_OCCURRENCES" (DOCUMENT_ID,FILE_ID) VALUES (2,2);
INSERT INTO "APP"."DOCUMENT_OCCURRENCES" (DOCUMENT_ID,FILE_ID) VALUES (3,3);
INSERT INTO "APP"."DOCUMENT_OCCURRENCES" (DOCUMENT_ID,FILE_ID) VALUES (4,4);
INSERT INTO "APP"."DOCUMENT_OCCURRENCES" (DOCUMENT_ID,FILE_ID) VALUES (5,5);


INSERT INTO "APP"."DOCUMENTS" (PK,ABSTRACT,DOCUMENT_NUMBER,BEGINNING_PAGE,CITED_CITATION_COUNT,DIGITAL_OBJECT_IDENTIFIER,ISI_TYPE,VOLUME,ENDING_PAGE,FIRST_AUTHOR_ID,FUNDING_AGENCY_AND_GRANT_NUMBER,FUNDING_TEXT,ISBN,ISI_DOCUMENT_DELIVERY_NUMBER,ISI_UNIQUE_ARTICLE_IDENTIFIER,ISSUE,LANGUAGE,PAGE_COUNT,PART_NUMBER,PUBLICATION_DATE,PUBLICATION_YEAR,SOURCE_ID,SPECIAL_ISSUE,SUBJECT_CATEGORY,SUPPLEMENT,TIMES_CITED,TITLE,CITE_AS) VALUES (1,'The study of networks is gaining prominence in many disciplines as well as in the popular press. Information scientists, however, have studied networks for decades.',null,65,-1,null,null,10,null,1,null,null,null,null,null,'id 5',null,-1,null,null,2000,5,null,null,null,5,'Aaaa','Xxxx X, 2000, INT MICROBIOL, V10, P65');
INSERT INTO "APP"."DOCUMENTS" (PK,ABSTRACT,DOCUMENT_NUMBER,BEGINNING_PAGE,CITED_CITATION_COUNT,DIGITAL_OBJECT_IDENTIFIER,ISI_TYPE,VOLUME,ENDING_PAGE,FIRST_AUTHOR_ID,FUNDING_AGENCY_AND_GRANT_NUMBER,FUNDING_TEXT,ISBN,ISI_DOCUMENT_DELIVERY_NUMBER,ISI_UNIQUE_ARTICLE_IDENTIFIER,ISSUE,LANGUAGE,PAGE_COUNT,PART_NUMBER,PUBLICATION_DATE,PUBLICATION_YEAR,SOURCE_ID,SPECIAL_ISSUE,SUBJECT_CATEGORY,SUPPLEMENT,TIMES_CITED,TITLE,CITE_AS) VALUES (2,'To better understand the topic of this colloquium, we have created a series of databases related to knowledge domains (dynamic systems [small world/Milgram], information visualization [Tufte], co-citation [Small], bibliographic coupling [Kessler], and scientometrics [Scientometrics]).',null,119,-1,null,null,30,null,7,null,null,null,null,null,'id 4',null,-1,null,null,2001,10,null,null,null,2,'Dddd','Xxxx X, 2001, J INFORM SCI, V30, P119');
INSERT INTO "APP"."DOCUMENTS" (PK,ABSTRACT,DOCUMENT_NUMBER,BEGINNING_PAGE,CITED_CITATION_COUNT,DIGITAL_OBJECT_IDENTIFIER,ISI_TYPE,VOLUME,ENDING_PAGE,FIRST_AUTHOR_ID,FUNDING_AGENCY_AND_GRANT_NUMBER,FUNDING_TEXT,ISBN,ISI_DOCUMENT_DELIVERY_NUMBER,ISI_UNIQUE_ARTICLE_IDENTIFIER,ISSUE,LANGUAGE,PAGE_COUNT,PART_NUMBER,PUBLICATION_DATE,PUBLICATION_YEAR,SOURCE_ID,SPECIAL_ISSUE,SUBJECT_CATEGORY,SUPPLEMENT,TIMES_CITED,TITLE,CITE_AS) VALUES (3,'The study of networks is gaining prominence in many disciplines as well as in the popular press. Information scientists, however, have studied networks for decades. This session will explore the potential of using citation network analysis and social network analysis to provide structural assessments of scientific communication. Panelists will discuss their research and highlight the advantages and challenges of using these methods to derive a comprehensive portrait of the diffusion of scientific knowledge.',null,486,-1,null,null,40,null,12,null,null,null,null,null,'id 3',null,-1,null,null,2000,9,null,null,null,4,'Bbbb','Xxxx X, 2000, P ASIST ANNU MEET, V40, P486');
INSERT INTO "APP"."DOCUMENTS" (PK,ABSTRACT,DOCUMENT_NUMBER,BEGINNING_PAGE,CITED_CITATION_COUNT,DIGITAL_OBJECT_IDENTIFIER,ISI_TYPE,VOLUME,ENDING_PAGE,FIRST_AUTHOR_ID,FUNDING_AGENCY_AND_GRANT_NUMBER,FUNDING_TEXT,ISBN,ISI_DOCUMENT_DELIVERY_NUMBER,ISI_UNIQUE_ARTICLE_IDENTIFIER,ISSUE,LANGUAGE,PAGE_COUNT,PART_NUMBER,PUBLICATION_DATE,PUBLICATION_YEAR,SOURCE_ID,SPECIAL_ISSUE,SUBJECT_CATEGORY,SUPPLEMENT,TIMES_CITED,TITLE,CITE_AS) VALUES (4,'WoS export files are created in which all cited references for source documents are captured. These bibliographic collections are processed by HistCite, which generates chronological tables as well as historiographs that highlight the most-cited works in and outside the collection.',null,183,-1,null,null,22,null,17,null,null,null,null,null,'id 2',null,-1,null,null,2002,20,null,null,null,0,'Eeee','Xxxx X, 2002, INFORM TECHNOL LIBR, V22, P183');
INSERT INTO "APP"."DOCUMENTS" (PK,ABSTRACT,DOCUMENT_NUMBER,BEGINNING_PAGE,CITED_CITATION_COUNT,DIGITAL_OBJECT_IDENTIFIER,ISI_TYPE,VOLUME,ENDING_PAGE,FIRST_AUTHOR_ID,FUNDING_AGENCY_AND_GRANT_NUMBER,FUNDING_TEXT,ISBN,ISI_DOCUMENT_DELIVERY_NUMBER,ISI_UNIQUE_ARTICLE_IDENTIFIER,ISSUE,LANGUAGE,PAGE_COUNT,PART_NUMBER,PUBLICATION_DATE,PUBLICATION_YEAR,SOURCE_ID,SPECIAL_ISSUE,SUBJECT_CATEGORY,SUPPLEMENT,TIMES_CITED,TITLE,CITE_AS) VALUES (5,'The empirical question addressed in this contribution is: How does the relative frequency at which authors in a research field cite ''authoritative'' documents in the reference lists in their papers vary with the number of references such papers contain?',null,295,-1,null,null,60,null,23,null,null,null,null,null,'id 1',null,-1,null,null,2001,25,null,null,null,1,'Cccc','Yyyy Y, 2001, SCIENTOMETRICS, V60, P295');




INSERT INTO "APP"."FILES" (PK,FORMAT_VERSION_NUMBER,NAME,FILE_TYPE) VALUES (1,'','C:\Users\thgsmith\Desktop\sci2-dbrename\sampledata\scientometrics\isi\Test5Papers.isi','ISI Export Format');
INSERT INTO "APP"."FILES" (PK,FORMAT_VERSION_NUMBER,NAME,FILE_TYPE) VALUES (2,'','C:\Users\thgsmith\Desktop\sci2-dbrename\sampledata\scientometrics\isi\Test5Papers.isi','ISI Export Format');
INSERT INTO "APP"."FILES" (PK,FORMAT_VERSION_NUMBER,NAME,FILE_TYPE) VALUES (3,'','C:\Users\thgsmith\Desktop\sci2-dbrename\sampledata\scientometrics\isi\Test5Papers.isi','ISI Export Format');
INSERT INTO "APP"."FILES" (PK,FORMAT_VERSION_NUMBER,NAME,FILE_TYPE) VALUES (4,'','C:\Users\thgsmith\Desktop\sci2-dbrename\sampledata\scientometrics\isi\Test5Papers.isi','ISI Export Format');
INSERT INTO "APP"."FILES" (PK,FORMAT_VERSION_NUMBER,NAME,FILE_TYPE) VALUES (5,'','C:\Users\thgsmith\Desktop\sci2-dbrename\sampledata\scientometrics\isi\Test5Papers.isi','ISI Export Format');






INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (1,null,'Xxxx','X',null,null,null,'Xxxx, X');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (2,null,'Yyyy','Y',null,null,null,'Yyyy, Y');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (7,null,'Xxxx','X',null,null,null,'Xxxx, X');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (12,null,'Xxxx','X',null,null,null,'Xxxx, X');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (17,null,'Xxxx','X',null,null,null,'Xxxx, X');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (18,null,'Yyyy','Y',null,null,null,'Yyyy, Y');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (23,null,'Yyyy','Y',null,null,null,'Yyyy, Y');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (24,null,'Zzzz','Z',null,null,null,'Zzzz, Z');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (63,null,'Garfield','E',null,null,null,'Garfield, E');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (65,null,'Lederberg','J',null,null,null,'Lederberg, J');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (67,null,'Brodman','E',null,null,null,'Brodman, E');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (69,null,'Wellman','B',null,null,null,'Wellman, B');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (71,null,'Bensman','S',null,'J',null,'Bensman, SJ');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (73,null,'Wellman','B',null,null,null,'Wellman, B');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (75,null,'Asimov','A',null,null,null,'Asimov, A');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (77,null,'Garfield','E',null,null,null,'Garfield, E');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (79,null,'Xxxx','X',null,null,null,'Xxxx, X');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (81,null,'Xxxx','X',null,null,null,'Xxxx, X');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (83,null,'Gilbert','G',null,'N',null,'Gilbert, GN');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (85,null,'Xxxx','X',null,null,null,'Xxxx, X');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (87,null,'Avery','O',null,'T',null,'Avery, OT');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (89,null,'Garfield','E',null,null,null,'Garfield, E');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (91,null,'Small','H',null,null,null,'Small, H');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (93,null,'Brodman','E',null,null,null,'Brodman, E');
INSERT INTO "APP"."PEOPLE" (PK,ADDITIONAL_NAME,FAMILY_NAME,FIRST_INITIAL,FULL_NAME,MIDDLE_INITIAL,FIRST_NAME,RAW_NAME) VALUES (95,null,'Bensman','S',null,'J',null,'Bensman, SJ');










INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (1,null,null,null,null,null,null,null,null,null,null,null,'LIBR RESOUR TECH SER');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (2,null,null,null,null,null,null,null,null,null,null,null,'B MED LIB ASS');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (3,null,null,null,null,null,null,null,null,null,null,null,'SCIENCE');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (4,null,null,null,null,null,null,null,null,null,null,null,'SOCIAL STRUCTURES NE');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (5,null,null,null,null,null,null,null,null,null,null,null,'INT MICROBIOL');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (6,null,null,null,null,null,null,null,null,null,null,null,'GENETIC CODE');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (7,null,null,null,null,null,null,null,null,null,null,null,'NATURE');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (9,null,null,null,null,null,null,null,null,null,null,null,'P ASIST ANNU MEET');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (10,null,null,null,null,null,null,null,null,null,null,null,'J INFORM SCI');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (16,null,null,null,null,null,null,null,null,null,null,null,'J EXP MED');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (20,null,null,null,null,null,null,null,null,null,null,null,'INFORM TECHNOL LIBR');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (21,null,null,null,null,null,null,null,null,null,null,null,'ESSAYS INFORMATION S');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (22,null,null,null,null,null,null,null,null,null,null,null,'SOC STUD SCI');
INSERT INTO "APP"."SOURCES" (PK,BOOK_SERIES_TITLE,BOOK_SERIES_SUBTITLE,CONFERENCE_HOST,CONFERENCE_LOCATION,CONFERENCE_SPONSORS,CONFERENCE_TITLE,CONFERENCE_DATES,FULL_TITLE,ISO_TITLE_ABBREVIATION,ISSN,PUBLICATION_TYPE,TWENTY_NINE_CHARACTER_SOURCE_TITLE_ABBREVIATION) VALUES (25,null,null,null,null,null,null,null,null,null,null,null,'SCIENTOMETRICS');







CREATE UNIQUE INDEX SQL120413091333600 ON "APP"."ADDRESSES"(PK)
;
ALTER TABLE "APP"."AUTHORS"
ADD CONSTRAINT "PERSON_ID_CONSTRAINT_8b44ba03-6069-47a2-9c16-253e66c88674"
FOREIGN KEY (PERSON_ID)
REFERENCES "APP"."PEOPLE"(PK)
;
ALTER TABLE "APP"."AUTHORS"
ADD CONSTRAINT "DOCUMENT_ID_CONSTRAINT_12f30631-6837-45b8-bd5a-20a596880103"
FOREIGN KEY (DOCUMENT_ID)
REFERENCES "APP"."DOCUMENTS"(PK)
;
CREATE INDEX SQL120413091333910 ON "APP"."AUTHORS"(DOCUMENT_ID)
;
CREATE INDEX SQL120413091333920 ON "APP"."AUTHORS"(PERSON_ID)
;
ALTER TABLE "APP"."CITATIONS"
ADD CONSTRAINT "SOURCE_ID_CONSTRAINT_9ffe7874-49d4-47c4-bbca-2a2b4a132733"
FOREIGN KEY (SOURCE_ID)
REFERENCES "APP"."SOURCES"(PK)
;
ALTER TABLE "APP"."CITATIONS"
ADD CONSTRAINT "AUTHOR_ID_CONSTRAINT_4d1f9719-23d0-4db8-b829-7bf20df0743d"
FOREIGN KEY (AUTHOR_ID)
REFERENCES "APP"."PEOPLE"(PK)
;
ALTER TABLE "APP"."CITATIONS"
ADD CONSTRAINT "DOCUMENT_ID_CONSTRAINT_62b113cf-a878-479d-9474-d4fc6c3d5c79"
FOREIGN KEY (DOCUMENT_ID)
REFERENCES "APP"."DOCUMENTS"(PK)
;
CREATE UNIQUE INDEX SQL120413091333670 ON "APP"."CITATIONS"(PK)
;
CREATE INDEX SQL120413091333870 ON "APP"."CITATIONS"(DOCUMENT_ID)
;
CREATE INDEX SQL120413091333900 ON "APP"."CITATIONS"(SOURCE_ID)
;
CREATE INDEX SQL120413091333890 ON "APP"."CITATIONS"(AUTHOR_ID)
;
ALTER TABLE "APP"."CITED_CITATIONS"
ADD CONSTRAINT "CITATION_ID_CONSTRAINT_706c4847-5c49-4c8a-a4d4-0055b067d469"
FOREIGN KEY (CITATION_ID)
REFERENCES "APP"."CITATIONS"(PK)
;
ALTER TABLE "APP"."CITED_CITATIONS"
ADD CONSTRAINT "DOCUMENT_ID_CONSTRAINT_75d5389c-873d-4951-85a0-f2ab7d5f4365"
FOREIGN KEY (DOCUMENT_ID)
REFERENCES "APP"."DOCUMENTS"(PK)
;
CREATE INDEX SQL120413091333980 ON "APP"."CITED_CITATIONS"(DOCUMENT_ID)
;
CREATE INDEX SQL120413091333990 ON "APP"."CITED_CITATIONS"(CITATION_ID)
;
ALTER TABLE "APP"."CITED_PATENTS"
ADD CONSTRAINT "PATENT_ID_CONSTRAINT_a7a65f5d-1ad4-4eca-9fbf-bdeda9849927"
FOREIGN KEY (PATENT_ID)
REFERENCES "APP"."PATENTS"(PK)
;
ALTER TABLE "APP"."CITED_PATENTS"
ADD CONSTRAINT "DOCUMENT_ID_CONSTRAINT_bd60df17-9463-4f58-96f7-829d0022e3ef"
FOREIGN KEY (DOCUMENT_ID)
REFERENCES "APP"."DOCUMENTS"(PK)
;
CREATE INDEX SQL120413091333970 ON "APP"."CITED_PATENTS"(PATENT_ID)
;
CREATE INDEX SQL120413091333950 ON "APP"."CITED_PATENTS"(DOCUMENT_ID)
;
ALTER TABLE "APP"."DOCUMENT_KEYWORDS"
ADD CONSTRAINT "KEYWORD_ID_CONSTRAINT_c723afcf-4ad1-4bb3-9970-b68e9a0aeb16"
FOREIGN KEY (KEYWORD_ID)
REFERENCES "APP"."KEYWORDS"(PK)
;
ALTER TABLE "APP"."DOCUMENT_KEYWORDS"
ADD CONSTRAINT "DOCUMENT_ID_CONSTRAINT_c71692e9-5e6b-4dc3-99a0-5d398a98a346"
FOREIGN KEY (DOCUMENT_ID)
REFERENCES "APP"."DOCUMENTS"(PK)
;
CREATE INDEX SQL120413091334010 ON "APP"."DOCUMENT_KEYWORDS"(KEYWORD_ID)
;
CREATE INDEX SQL120413091334000 ON "APP"."DOCUMENT_KEYWORDS"(DOCUMENT_ID)
;
ALTER TABLE "APP"."DOCUMENT_OCCURRENCES"
ADD CONSTRAINT "DOCUMENT_ID_CONSTRAINT_3ecb392c-1ada-4c3d-80ab-e014017ed205"
FOREIGN KEY (DOCUMENT_ID)
REFERENCES "APP"."DOCUMENTS"(PK)
;
ALTER TABLE "APP"."DOCUMENT_OCCURRENCES"
ADD CONSTRAINT "FILE_ID_CONSTRAINT_2a915b76-23ef-48a8-bd47-81279b41c482"
FOREIGN KEY (FILE_ID)
REFERENCES "APP"."FILES"(PK)
;
CREATE INDEX SQL120413091334030 ON "APP"."DOCUMENT_OCCURRENCES"(DOCUMENT_ID)
;
CREATE INDEX SQL120413091334040 ON "APP"."DOCUMENT_OCCURRENCES"(FILE_ID)
;
ALTER TABLE "APP"."DOCUMENTS"
ADD CONSTRAINT "FIRST_AUTHOR_ID_CONSTRAINT_eadc359b-14c0-440c-97e4-004734646ebf"
FOREIGN KEY (FIRST_AUTHOR_ID)
REFERENCES "APP"."PEOPLE"(PK)
;
ALTER TABLE "APP"."DOCUMENTS"
ADD CONSTRAINT "SOURCE_ID_CONSTRAINT_7b95c7f7-70bb-41c1-8159-1c82be40cbc4"
FOREIGN KEY (SOURCE_ID)
REFERENCES "APP"."SOURCES"(PK)
;
CREATE INDEX SQL120413091333850 ON "APP"."DOCUMENTS"(SOURCE_ID)
;
CREATE INDEX SQL120413091333840 ON "APP"."DOCUMENTS"(FIRST_AUTHOR_ID)
;
CREATE UNIQUE INDEX SQL120413091333590 ON "APP"."DOCUMENTS"(PK)
;
ALTER TABLE "APP"."EDITORS"
ADD CONSTRAINT "PERSON_ID_CONSTRAINT_06978a7b-603c-4e19-a89b-641408e01f26"
FOREIGN KEY (PERSON_ID)
REFERENCES "APP"."PEOPLE"(PK)
;
ALTER TABLE "APP"."EDITORS"
ADD CONSTRAINT "DOCUMENT_ID_CONSTRAINT_56735dcf-1e85-41f0-9a7e-7a9454f171ce"
FOREIGN KEY (DOCUMENT_ID)
REFERENCES "APP"."DOCUMENTS"(PK)
;
CREATE INDEX SQL120413091333930 ON "APP"."EDITORS"(DOCUMENT_ID)
;
CREATE INDEX SQL120413091333940 ON "APP"."EDITORS"(PERSON_ID)
;
CREATE UNIQUE INDEX SQL120413091333620 ON "APP"."FILES"(PK)
;
CREATE UNIQUE INDEX SQL120413091333630 ON "APP"."KEYWORDS"(PK)
;
CREATE UNIQUE INDEX SQL120413091333640 ON "APP"."PATENTS"(PK)
;
CREATE UNIQUE INDEX SQL120413091333690 ON "APP"."PEOPLE"(PK)
;
ALTER TABLE "APP"."PUBLISHER_ADDRESSES"
ADD CONSTRAINT "ADDRESS_ID_CONSTRAINT_c48c5885-95a8-4bd6-bc13-942a1c7e8fba"
FOREIGN KEY (ADDRESS_ID)
REFERENCES "APP"."ADDRESSES"(PK)
;
ALTER TABLE "APP"."PUBLISHER_ADDRESSES"
ADD CONSTRAINT "PUBLISHER_ID_CONSTRAINT_67f2040c-7758-43cd-b805-c00adc94da44"
FOREIGN KEY (PUBLISHER_ID)
REFERENCES "APP"."PUBLISHERS"(PK)
;
CREATE INDEX SQL120413091334050 ON "APP"."PUBLISHER_ADDRESSES"(PUBLISHER_ID)
;
CREATE INDEX SQL120413091334060 ON "APP"."PUBLISHER_ADDRESSES"(ADDRESS_ID)
;
ALTER TABLE "APP"."PUBLISHERS"
ADD CONSTRAINT "SOURCE_ID_CONSTRAINT_5c5a3354-0102-4bff-af91-a15f693ab4cd"
FOREIGN KEY (SOURCE_ID)
REFERENCES "APP"."SOURCES"(PK)
;
CREATE INDEX SQL120413091333860 ON "APP"."PUBLISHERS"(SOURCE_ID)
;
CREATE UNIQUE INDEX SQL120413091333650 ON "APP"."PUBLISHERS"(PK)
;
ALTER TABLE "APP"."REPRINT_ADDRESS"
ADD CONSTRAINT "ADDRESS_ID_CONSTRAINT_d0b17334-7da5-4262-8f49-ab2835820fd2"
FOREIGN KEY (ADDRESS_ID)
REFERENCES "APP"."ADDRESSES"(PK)
;
ALTER TABLE "APP"."REPRINT_ADDRESS"
ADD CONSTRAINT "DOCUMENT_ID_CONSTRAINT_360ce3b9-c7ec-40de-a372-0b34e6633e37"
FOREIGN KEY (DOCUMENT_ID)
REFERENCES "APP"."DOCUMENTS"(PK)
;
CREATE INDEX SQL120413091334080 ON "APP"."REPRINT_ADDRESS"(DOCUMENT_ID)
;
CREATE INDEX SQL120413091334090 ON "APP"."REPRINT_ADDRESS"(ADDRESS_ID)
;
ALTER TABLE "APP"."RESEARCH_ADDRESSES"
ADD CONSTRAINT "ADDRESS_ID_CONSTRAINT_093c271f-91ec-496b-92c9-881f488d5fa4"
FOREIGN KEY (ADDRESS_ID)
REFERENCES "APP"."ADDRESSES"(PK)
;
ALTER TABLE "APP"."RESEARCH_ADDRESSES"
ADD CONSTRAINT "DOCUMENT_ID_CONSTRAINT_bdf04089-9eba-4ffe-8a2c-bad093c8d9a0"
FOREIGN KEY (DOCUMENT_ID)
REFERENCES "APP"."DOCUMENTS"(PK)
;
CREATE INDEX SQL120413091334110 ON "APP"."RESEARCH_ADDRESSES"(DOCUMENT_ID)
;
CREATE INDEX SQL120413091334120 ON "APP"."RESEARCH_ADDRESSES"(ADDRESS_ID)
;
CREATE UNIQUE INDEX SQL120413091333700 ON "APP"."SOURCES"(PK)
;



