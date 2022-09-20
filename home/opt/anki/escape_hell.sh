#!/bin/dash
exec sqlite3 ~/'.local/share/Anki2/User 1/collection.anki2' < sql/escape_hell.sql
