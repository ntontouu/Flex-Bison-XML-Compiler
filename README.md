# Flex-Bison-XML-Compiler

Λεκτικός (Lexer) και Συντακτικός (Parser) αναλυτής για ένα υποσύνολο της Android XML. Υλοποιήθηκε με χρήση Flex και Bison σε C.

## Δομή
* **code_files/**: Περιέχει τον πηγαίο κώδικα (lexer.l, parser.y).
* **test_files/**: Περιέχει τα δοκιμαστικά αρχεία XML (επιτυχή και με σφάλματα).

## Μεταγλώττιση και Εκτέλεση
`ash
bison -d code_files/parser.y
flex -o code_files/lex.yy.c code_files/lexer.l
gcc code_files/parser.tab.c code_files/lex.yy.c -o myParser.exe

./myParser.exe test_files/test_swsto.xml
