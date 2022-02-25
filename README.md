# Simple Makefile
Summary
--------------------
This project is a dummy-project allowing me to test/develop my makefile.  The makefile
features automatic dependency generation and enables the project to seperate source
files from build files.


Makefile
--------------------
Makefile Constraints:
    -two files with same name (even in different directories)
    -files with spaces in their names

Project Structure
--------------------
src
    source files (.c, .cpp, and .h)
build
    build files (.o and .d)
docs
    documentation associated with project (datasheets, code documentation, etc.)
util
    utillity programs used in development process (adsfasdfsfda
3rd_party
    3rd party libraries stuff (libraries, chip headers, etc.)
        -when possible use git submodules
test
    tests for TDD

References
--------------------
Inspiration for Makefile:
    -http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/
    -https://www.youtube.com/watch?v=NPdagdEOBnI
    -Robert Mecklenburg's, "Managing Projects with GNU Make"

Inspiration for Project Structure:
    -https://www.beningo.com/how-to-organize-a-firmware-project/
    -https://www.microforum.cc/blogs/entry/46-modular-code-and-how-to-structure-an-embedded-c-project/

