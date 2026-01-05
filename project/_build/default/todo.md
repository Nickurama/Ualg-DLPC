# TODO
- print
- math expression

- constant pool for "immediate" floats
    - as Cst nodes are found, check if a constant already exists with that value and type
    - if not, create it (in an array of constants that will be added to .data), reference it and push it onto the stack
    - if it exists, just reference it and push it onto the stack
- types in expressions (inference)
- type errors (message + line + col)
- handle positive and negative values
- handle Add, Sub, Mul, Div for different types
- type conversion

- global variables
- global variables typing
- global variables type checking

- global variables
    - read the ast once and check how many unique global variables there are (and save them)
    - read the ast once and check how many local variables there are (and save them, with respective offset)
    - global variables are at the .data (initialized) or .bss (uninitialized)
    - local variables are at an offset from %rbp



- types
- type checking
- functions
- local variables
- for loops
- compiling error messages
- type checking error messages
- constant pool
- arrays
- resizeable vectors
- pointers?????
- report
