#!/bin/bash
set -e
echo '<style>ins,tr:not(:has(td.diff-deletedline)):not(:has(td>a))>td.diff-addedline{color:green}del,tr:not(:has(td.diff-addedline)):not(:has(td>a))>td.diff-deletedline{color:red}table{word-wrap:anywhere}</style>' > diffs.html; for x in work/*; do echo '<table>'; jql -r '"compare""*"' "$x"; echo '</table><hr>'; done >> diffs.html

