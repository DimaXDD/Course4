CREATE TABLE BODI (
    IST CHAR(3) DEFAULT '-' CHECK (IST <= '999'), -- Код источника данных
    TABL CHAR(5) DEFAULT '-', -- Код таблицы (в БД ГО)
    POK CHAR(4) DEFAULT '-', -- Код показателя
    UT CHAR(2) DEFAULT '00' CHECK (UT <= '99'), -- Код уточнения показателя
    SUB CHAR(6) DEFAULT '-' CHECK (SUB <= '999999'), -- Код субъекта
    OTN CHAR(2) DEFAULT '00' CHECK (OTN <= '99'), -- Код отношения
    OBJ CHAR(16) DEFAULT '0000000000000000' CHECK (OBJ <= '9999999999999999'), -- Код объекта
    VID CHAR(2) DEFAULT '-' CHECK (VID <= '99'), -- Код вида информации
    PER CHAR(2) DEFAULT '-' CHECK (PER <= '99'), -- Код периода
    DATV DATETIME DEFAULT GETDATE(), -- Дата-время
    DATV_SET DATETIME DEFAULT GETDATE(), -- Дата-время установки
    ZNC FLOAT DEFAULT 1.7E+308, -- Значение показателя
    PP CHAR(2) DEFAULT NULL, -- Признак показателя
    CONSTRAINT unique_combination_bodi UNIQUE (IST, TABL, POK, UT, SUB, OTN, OBJ, VID, PER) -- Ограничение уникальности для комбинации полей
);
