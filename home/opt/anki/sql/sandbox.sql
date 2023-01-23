-- This was copied as pasted from Datagrip
-- I see the data as a spreadsheet there, and the DDL button shows me the CREATE TABLE statements
-- This file is mostly to show people what I was exploring when I was developing the ease hell repair scripts

SELECT notes.sfld, cards.id, decks.name, cards.factor, cards.ivl, cards.due
FROM cards
         INNER JOIN decks ON cards.did == decks.id
         INNER JOIN notes on cards.nid == notes.id
WHERE factor < 2500
  AND queue != -1
  --AND name LIKE '%N3%'
  --AND notes.sfld = 'a'
  AND cards.ivl > 30
ORDER BY factor
;

SELECT * FROM cards;

UPDATE cards
SET factor = 2500
WHERE queue != -1
  AND factor < 2500
  --AND did = 1585255766437
  AND ivl > 30;

SELECT id, name
from decks;

SELECT notes.sfld, cards.id, decks.name, cards.factor, cards.ivl, cards.due
FROM cards
         INNER JOIN decks ON cards.did == decks.id
         INNER JOIN notes on cards.nid == notes.id
WHERE queue != -1
    AND ivl != 0
    AND due = 756
ORDER BY factor;

UPDATE cards SET due = 756 WHERE queue != -1 AND due > 756;

UPDATE cards SET ivl = 364 WHERE queue != -1 AND ivl > 364;
