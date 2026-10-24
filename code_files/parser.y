%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yylineno;
extern char *yytext;
void yyerror(const char *s);

/* --- ΚΑΘΟΛΙΚΕΣ ΜΕΤΑΒΛΗΤΕΣ --- */
int semantic_errors = 0;

/* ΠΙΝΑΚΑΣ ΣΥΜΒΟΛΩΝ */
#define MAX_SYMBOLS 100
char *symbol_table[MAX_SYMBOLS]; 
int symbol_count = 0; 

/* ΜΕΤΑΒΛΗΤΕΣ ΓΙΑ ΕΡΩΤΗΜΑΤΑ 3 & 2e */
int expected_radios = -1; 
int actual_radios = 0;
int current_max = -1;
int current_progress = -1;

/* ΓΙΑ ΝΑ ΜΠΟΥΝ ΤΑ ID ΣΤΟΝ ΠΙΝΑΚΑ */
void add_symbol(char *id) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i], id) == 0) {
            char msg[200];
            sprintf(msg, "Το ID '%s' χρησιμοποιείται ήδη! (Ερώτημα 2a)", id);
            yyerror(msg);
            return;
        }
    }
    if (symbol_count < MAX_SYMBOLS) {
        symbol_table[symbol_count++] = strdup(id);
    }
}

/* ΕΛΕΓΧΟΣ ΑΝ ΥΠΑΡΧΕΙ ΚΑΝ ΤΟ ID */
void check_id_exists(char *id) {
    int found = 0;
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i], id) == 0) {
            found = 1;
            break;
        }
    }
    if (!found) {
        char msg[200];
        sprintf(msg, "Το ID '%s' στο checkedButton δεν βρέθηκε! (Ερώτημα 2d)", id);
        yyerror(msg);
    }
}

%}

%code requires {
    typedef struct {
        int kind;     // 0 = Int, 1 = String
        int ival;     
        char *sval;   
    } ValueData;
}

%union {
    char *sval;   
    int ival;     
    ValueData val;
}

%token T_LINEAR_LAYOUT T_RELATIVE_LAYOUT
%token T_TEXT_VIEW T_IMAGE_VIEW T_BUTTON
%token T_RADIO_GROUP T_RADIO_BUTTON T_PROGRESS_BAR

%token <ival> A_LAYOUT_WIDTH A_LAYOUT_HEIGHT
%token <ival> A_ID A_ORIENTATION A_TEXT A_TEXT_COLOR
%token <ival> A_SRC A_PADDING A_CHECKED_BUTTON
%token <ival> A_MAX A_PROGRESS
%token <ival> A_RADIO_COUNT 

%token <sval> V_STRING
%token <ival> V_INT
%token <sval> V_MATCH_PARENT V_WRAP_CONTENT

%token LT GT LT_SLASH SLASH_GT EQ

%type <val> attribute_value
%type <ival> attribute_name

%%

program: root_element ;

root_element: linear_layout | relative_layout ;

elements_list: | elements_list element ;

element:
      linear_layout | relative_layout
    | text_view | image_view | button | progress_bar | radio_group
    ;

linear_layout: LT T_LINEAR_LAYOUT attributes GT elements_list LT_SLASH T_LINEAR_LAYOUT GT ;
relative_layout: LT T_RELATIVE_LAYOUT attributes GT elements_list LT_SLASH T_RELATIVE_LAYOUT GT ;

/* --- ΕΡΩΤΗΜΑ 3: RadioGroup --- */
radio_group: 
      LT T_RADIO_GROUP 
      { expected_radios = -1; actual_radios = 0; }
      attributes GT 
      radio_buttons_list 
      LT_SLASH T_RADIO_GROUP GT
      {
          if (expected_radios != -1 && expected_radios != actual_radios) {
              char msg[200];
              sprintf(msg, "Δηλώθηκαν %d κουμπιά αλλά βρέθηκαν %d. (Ερώτημα 3c)", expected_radios, actual_radios);
              yyerror(msg);
          }
      }
    ;

radio_buttons_list: radio_button | radio_buttons_list radio_button ;

radio_button: 
      LT T_RADIO_BUTTON attributes SLASH_GT 
      { actual_radios++; }
    ;

text_view: LT T_TEXT_VIEW attributes SLASH_GT ;
image_view: LT T_IMAGE_VIEW attributes SLASH_GT ;
button: LT T_BUTTON attributes SLASH_GT ;

/* --- ΕΡΩΤΗΜΑ 2e: ProgressBar --- */
progress_bar: 
      LT T_PROGRESS_BAR 
      { current_max = -1; current_progress = -1; }
      attributes SLASH_GT 
      {
          /* ΣΥΓΚΡΙΣΗ ΤΑΓΚΣ */
          if (current_progress != -1 && current_max != -1) {
              if (current_progress > current_max) {
                  char msg[200];
                  sprintf(msg, "Το progress (%d) δεν μπορεί να είναι μεγαλύτερο από το max (%d). (Ερώτημα 2e)", current_progress, current_max);
                  yyerror(msg);
              }
          }
      }
    ;


/* --- ATTRIBUTES --- */

attributes: | attributes attribute ;

attribute: attribute_name EQ attribute_value 
    {
        /* 2a: ΜΟΝΑΔΙΚΟ ΙΔ */
        if ($1 == A_ID && $3.kind == 1) add_symbol($3.sval);

        /* 2d: CheckedButton ΝΑ ΥΠΑΡΧΕΙ */
        if ($1 == A_CHECKED_BUTTON && $3.kind == 1) check_id_exists($3.sval);

        /* 3b: RADIO COUNT */
        if ($1 == A_RADIO_COUNT && $3.kind == 0 && $3.ival > 0) expected_radios = $3.ival;

        /* 2c: PADDING */
        if ($1 == A_PADDING && ($3.kind != 0 || $3.ival <= 0)) 
            yyerror("Το padding πρέπει να είναι θετικός ακέραιος.");

        /* 2b: ΥΨΟΣ - ΠΛΑΤΟΣ */
        if (($1 == A_LAYOUT_WIDTH || $1 == A_LAYOUT_HEIGHT)) {
             if ($3.kind == 0 && $3.ival <= 0) yyerror("Οι διαστάσεις πρέπει να είναι θετικές.");
             if ($3.kind == 1 && strcmp($3.sval, "match_parent") && strcmp($3.sval, "wrap_content"))
                 yyerror("Λάθος τιμή διάστασης.");
        }

			/*ΜΑΖΕΥΕΙ ΤΙΜΕΣ ΓΙΑ ΤΗΝ ΜΠΑΡΑ*/
        if ($1 == A_MAX && $3.kind == 0) current_max = $3.ival;
        if ($1 == A_PROGRESS && $3.kind == 0) current_progress = $3.ival;
    }
    ;

attribute_name:
      A_LAYOUT_WIDTH { $$ = A_LAYOUT_WIDTH; }
    | A_LAYOUT_HEIGHT { $$ = A_LAYOUT_HEIGHT; }
    | A_ID { $$ = A_ID; }
    | A_ORIENTATION { $$ = A_ORIENTATION; }
    | A_TEXT { $$ = A_TEXT; }
    | A_TEXT_COLOR { $$ = A_TEXT_COLOR; }
    | A_SRC { $$ = A_SRC; }
    | A_PADDING { $$ = A_PADDING; }
    | A_CHECKED_BUTTON { $$ = A_CHECKED_BUTTON; }
    | A_MAX { $$ = A_MAX; }
    | A_PROGRESS { $$ = A_PROGRESS; }
    | A_RADIO_COUNT { $$ = A_RADIO_COUNT; }
    ;

attribute_value:
      V_STRING { $$.kind = 1; $$.sval = $1; }
    | V_INT { $$.kind = 0; $$.ival = $1; }
    | V_MATCH_PARENT { $$.kind = 1; $$.sval = $1; }
    | V_WRAP_CONTENT { $$.kind = 1; $$.sval = $1; }
    ;

%%

void yyerror(const char *s) {
    semantic_errors++;
    fprintf(stderr, "Σφάλμα: %s στη γραμμή %d\n", s, yylineno);
}

int main(int argc, char **argv) {
    int parse_result = yyparse();
    if (parse_result == 0 && semantic_errors == 0) {
        printf("Η συντακτική ανάλυση ολοκληρώθηκε με ΕΠΙΤΥΧΙΑ.\n");
    } else {
        printf("Η συντακτική ανάλυση ΑΠΕΤΥΧΕ (%d σφάλματα).\n", semantic_errors + parse_result);
    }
    return 0;
}