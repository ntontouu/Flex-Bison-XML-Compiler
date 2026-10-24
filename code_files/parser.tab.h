/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 58 "parser.y"

    typedef struct {
        int kind;     // 0 = Int, 1 = String
        int ival;     
        char *sval;   
    } ValueData;

#line 57 "parser.tab.h"

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    T_LINEAR_LAYOUT = 258,         /* T_LINEAR_LAYOUT  */
    T_RELATIVE_LAYOUT = 259,       /* T_RELATIVE_LAYOUT  */
    T_TEXT_VIEW = 260,             /* T_TEXT_VIEW  */
    T_IMAGE_VIEW = 261,            /* T_IMAGE_VIEW  */
    T_BUTTON = 262,                /* T_BUTTON  */
    T_RADIO_GROUP = 263,           /* T_RADIO_GROUP  */
    T_RADIO_BUTTON = 264,          /* T_RADIO_BUTTON  */
    T_PROGRESS_BAR = 265,          /* T_PROGRESS_BAR  */
    A_LAYOUT_WIDTH = 266,          /* A_LAYOUT_WIDTH  */
    A_LAYOUT_HEIGHT = 267,         /* A_LAYOUT_HEIGHT  */
    A_ID = 268,                    /* A_ID  */
    A_ORIENTATION = 269,           /* A_ORIENTATION  */
    A_TEXT = 270,                  /* A_TEXT  */
    A_TEXT_COLOR = 271,            /* A_TEXT_COLOR  */
    A_SRC = 272,                   /* A_SRC  */
    A_PADDING = 273,               /* A_PADDING  */
    A_CHECKED_BUTTON = 274,        /* A_CHECKED_BUTTON  */
    A_MAX = 275,                   /* A_MAX  */
    A_PROGRESS = 276,              /* A_PROGRESS  */
    A_RADIO_COUNT = 277,           /* A_RADIO_COUNT  */
    V_STRING = 278,                /* V_STRING  */
    V_INT = 279,                   /* V_INT  */
    V_MATCH_PARENT = 280,          /* V_MATCH_PARENT  */
    V_WRAP_CONTENT = 281,          /* V_WRAP_CONTENT  */
    LT = 282,                      /* LT  */
    GT = 283,                      /* GT  */
    LT_SLASH = 284,                /* LT_SLASH  */
    SLASH_GT = 285,                /* SLASH_GT  */
    EQ = 286                       /* EQ  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 66 "parser.y"

    char *sval;   
    int ival;     
    ValueData val;

#line 111 "parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
