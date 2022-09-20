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
