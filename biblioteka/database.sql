-- Kreiranje baze biblioteka
CREATE DATABASE IF NOT EXISTS biblioteka;
USE biblioteka;

-- Tabela clan
CREATE TABLE IF NOT EXISTS clan (
    clan_id INT PRIMARY KEY,
    prezime TEXT NOT NULL,
    ime TEXT NOT NULL,
    adresa VARCHAR(64) NOT NULL
);

-- Tabela knjiga
CREATE TABLE IF NOT EXISTS knjiga (
    knjiga_id INT PRIMARY KEY,
    naziv VARCHAR(64) NOT NULL,
    autor TEXT NOT NULL,
    izdavac VARCHAR(64) NOT NULL
);

-- Tabela posudjivanje
-- (Primarni kljuc su clan_id + knjiga_id + datum_posudjivanja jer ista knjiga moze biti vise puta pozajmljena)
CREATE TABLE IF NOT EXISTS posudjivanje (
    clan_id INT,
    knjiga_id INT,
    datum_posudjivanja DATE NOT NULL,
    PRIMARY KEY (clan_id, knjiga_id, datum_posudjivanja),
    FOREIGN KEY (clan_id) REFERENCES clan(clan_id),
    FOREIGN KEY (knjiga_id) REFERENCES knjiga(knjiga_id)
);

-- Unos podataka u knjiga
INSERT INTO knjiga (knjiga_id, naziv, autor, izdavac)
VALUES
(125, 'Za kim zvono zvoni', 'Hemingway', 'Narodna knjiga'),
(130, 'Starac i more', 'Hemingway', 'Nova knjiga'),
(145, 'Prokleta avlija', 'Ivo Andrić', 'Narodna knjiga'),
(300, 'Derviš i smrt', 'Meša Selimović', 'Znanje'),
(302, 'Stranac', 'Alber Kami', 'Narodna knjiga');

-- Unos podataka u clan
INSERT INTO clan (clan_id, prezime, ime, adresa)
VALUES
(100, 'Milović', 'Sonja', 'Vuka Karadžića bb'),
(181, 'Peković', 'Darko', 'Novica Cerovića bb'),
(182, 'Mijović', 'Anja', 'Karađorđeva bb'),
(250, 'Marković', 'Maja', 'Vuka Mićunovića bb'),
(300, 'Petrović', 'Jovan', 'II Dalmatinska bb'),
(420, 'Joković', 'Ranko', 'Njegoševa bb');

-- Unos podataka u posudjivanje
INSERT INTO posudjivanje (knjiga_id, clan_id, datum_posudjivanja)
VALUES
(125, 250, '2019-04-02'),
(130, 181, '2019-04-14'),
(130, 182, '2019-04-24'),
(130, 250, '2019-03-22'),
(130, 300, '2019-01-01'),
(145, 181, '2019-04-25'),
(145, 182, '2019-04-05'),
(145, 250, '2019-03-12'),
(302, 300, '2020-04-03'),
(300, 300, '2019-04-18');