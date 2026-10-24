%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
%}

%option noyywrap
%option yylineno

%%

[ \t\r\n]+  ;
"" ;

"</"        { return LT_SLASH; }
"/>"        { return SLASH_GT; }
"<"         { return LT; }
">"         { return GT; }
"="         { return EQ; }

"LinearLayout"      { return T_LINEAR_LAYOUT; }
"RelativeLayout"    { return T_RELATIVE_LAYOUT; }
"TextView"          { return T_TEXT_VIEW; }
"ImageView"         { return T_IMAGE_VIEW; }
"Button"            { return T_BUTTON; }
"ProgressBar"       { return T_PROGRESS_BAR; }
"RadioGroup"        { return T_RADIO_GROUP; }
"RadioButton"       { return T_RADIO_BUTTON; }

"android:layout_width"  { return A_LAYOUT_WIDTH; }
"android:layout_height" { return A_LAYOUT_HEIGHT; }
"android:id"            { return A_ID; }
"android:orientation"   { return A_ORIENTATION; }
"android:text"          { return A_TEXT; }
"android:textColor"     { return A_TEXT_COLOR; }
"android:src"           { return A_SRC; }
"android:padding"       { return A_PADDING; }
"android:checkedButton" { return A_CHECKED_BUTTON; }
"android:max"           { return A_MAX; }
"android:progress"      { return A_PROGRESS; }

"app:radio_count"       { return A_RADIO_COUNT; }

\"match_parent\" {
    yylval.sval = strdup("match_parent");
    return V_MATCH_PARENT;
}

\"wrap_content\" {
    yylval.sval = strdup("wrap_content");
    return V_WRAP_CONTENT;
}

\"[0-9]+\" {
    yylval.ival = atoi(yytext + 1);
    return V_INT;
}

\"[^"\n]*\" {
    yytext[yyleng-1] = '\0';
    yylval.sval = strdup(yytext + 1);
    return V_STRING;
}

. {
    printf("LEX ERROR: Unknown char '%s' at line %d\n", yytext, yylineno);
}

%%