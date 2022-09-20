UPDATE cards
SET factor = 2500
WHERE queue != -1
  AND factor < 2500
  --AND did = 1585255766437
  AND ivl > 30;
