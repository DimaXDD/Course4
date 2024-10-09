CREATE TABLE BODK (
    IST CHAR(3) DEFAULT '-' CHECK (IST <= '999'), -- Код источника данных
    SUB CHAR(6) DEFAULT '-' CHECK (SUB <= '999999'), -- Код субъекта отрасли
    DATV_SET DATETIME DEFAULT GETDATE(), -- Дата-время записи в таблицу BODK
    KZAP SMALLINT DEFAULT 0 CHECK (KZAP <= 32767), -- Количество строк (записей)
    CONSTRAINT unique_combination UNIQUE (IST, SUB, DATV_SET, KZAP) -- Ограничение уникальности для комбинации полей
);
