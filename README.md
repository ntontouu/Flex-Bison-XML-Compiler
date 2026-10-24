# Android XML Compiler Front-end (Flex & Bison)

[![University](https://img.shields.io/badge/University-University%20of%20Ioannina-blue.svg)](https://www.uoi.gr)
[![Department](https://img.shields.io/badge/Department-Computer%20Science%20%26%20Telecommunications-lightgrey.svg)](https://www.dit.uoi.gr/)
[![Tools](https://img.shields.io/badge/Tools-Flex%20%7C%20Bison-orange.svg)]()
[![Language](https://img.shields.io/badge/Language-C-blueviolet.svg)]()

A robust C implementation of a Lexical (Lexer) and Syntax (Parser) analyzer for a subset of the Android XML language. Developed as a semester project for the Compilers course at the Department of Computer Science and Telecommunications, University of Ioannina.

---

## 📚 Table of Contents
1. [Overview](#-overview)
2. [Theoretical Background](#-theoretical-background)
3. [Project Structure & Code Architecture](#-project-structure--code-architecture)
4. [Experimental Results & Analysis](#-experimental-results--analysis)
5. [Getting Started & Execution](#-getting-started--execution)
6. [Author & Credits](#-author--academic-use)

## 🔍 Overview
This project implements a compiler front-end designed to parse and validate Android UI XML files. It ensures that the hierarchical structure of layouts (e.g., `LinearLayout`, `RelativeLayout`) and widgets (e.g., `TextView`, `RadioGroup`) is syntactically correct, while simultaneously enforcing strict semantic constraints.

## 📐 Theoretical Background

### BNF Grammar & Syntax Analysis (Bison)
The language's grammar is formally defined using Backus-Naur Form (BNF). The parser validates nested XML elements, ensuring tags are properly closed and hierarchical rules are respected (e.g., a `RadioButton` can only exist inside a `RadioGroup`).

### Lexical Analysis (Flex)
The lexer reads the raw XML input, ignores whitespaces and comments, and tokenizes tags, attributes, and values (e.g., stripping quotes from strings and dynamically converting integer values) to feed them to the parser.

### Semantic Rules & Symbol Table (C)
Custom C code embedded in the Bison parser handles complex semantic logic:
- **ID Uniqueness:** A Symbol Table tracks all `android:id` declarations to prevent duplicates.
- **Validation:** Ensures spatial constraints (e.g., `padding` > 0) and structural integrity (e.g., `checkedButton` references an existing ID).
- **Custom Attributes:** Verifies dynamic constraints like `app:radio_count` matching the actual number of nested radio buttons, and `android:progress` ≤ `android:max`.

## 🛠️ Project Structure & Code Architecture

| File | Description |
|------|-------------|
| `code_files/lexer.l` | Flex specifications containing Regular Expressions for XML tokenization. |
| `code_files/parser.y` | Bison grammar rules, C symbol table implementation, and error handling logic. |
| `test_files/` | Contains test XML files evaluating success paths and various semantic failures. |

## 📊 Experimental Results & Observations
The compiler was rigorously tested against multiple edge cases:
- **Success Scenarios (`test_swsto.xml`):** Fully validates correct XML structures.
- **Symbol Table Collisions (`test_duplicate.xml`):** Successfully catches duplicate `android:id` assignments across the document.
- **Logical Violations (`test_extra.xml`, `test_radio.xml`):** Identifies invalid progress bar states (progress > max), non-existent referenced IDs, and radio count mismatches.

## 🚀 Getting Started & Execution

1. **Prerequisites:** Ensure `flex`, `bison`, and `gcc` are installed on your development environment.
2. **Compilation:**
   ```bash
   bison -d code_files/parser.y
   flex -o code_files/lex.yy.c code_files/lexer.l
   gcc code_files/parser.tab.c code_files/lex.yy.c -o myParser.exe

Execution:

Bash
./myParser.exe test_files/test_swsto.xml

## 📝 Author & Academic Use
Student: Maria Alexandra Ndontou (ΜΑΡΙΑ ΑΛΕΞΑΝΔΡΑ ΝΤΟΝΤΟΥ)

Student ID: 2799

Institution: University of Ioannina — Department of Computer Science and Telecommunications

Course: Compilers (Μεταγλωττιστές) — Semester Project

This document is provided for academic reference and educational purposes.
