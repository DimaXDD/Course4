create database lab4_6_ris_main

use lab4_6_ris_main

CREATE TABLE Cl1 (
    id INT IDENTITY(1,1) PRIMARY KEY,
    date_time DATETIME2 NOT NULL,
    studentNumber INT NOT NULL,
    clNum INT NOT NULL,
    randomNumber INT NOT NULL
);

create database lab4_6_ris_local

use lab4_6_ris_local

CREATE TABLE Cl1 (
    id INT IDENTITY(1,1) PRIMARY KEY,
    date_time DATETIME2 NOT NULL,
    studentNumber INT NOT NULL,
    clNum INT NOT NULL,
    randomNumber INT NOT NULL
);

select * from Cl1

drop database lab4_6_ris_local