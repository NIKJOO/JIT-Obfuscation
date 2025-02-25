# JIT Compilation in Delphi

This project demonstrates **Just-In-Time (JIT) Compilation** in **Delphi** by dynamically allocating executable memory, decrypting bytecode at runtime, and executing it as a function.

## Features
- **JIT Compilation**: Executes dynamically generated machine code at runtime.
- **Runtime Encryption & Decryption**: Bytecode is **XOR-encrypted** and decrypted just before execution.
- **Memory Protection**: The allocated memory is wiped after execution to prevent reverse engineering.

## How It Works
1. The encrypted bytecode (`EncCode`) is stored in the program.
2. Before execution, it is **decrypted** using an **XOR-based encryption** method.
3. The decrypted bytecode is allocated in **executable memory** using `VirtualAlloc`.
4. The function is executed, and the output is printed.
5. After execution, the memory is **erased** and released to prevent analysis.

## Requirements
- Delphi 7 
- Windows OS

## Usage
Simply compile and run the program. It will decrypt and execute the JIT-compiled function, displaying the output.

## Security Considerations
- Uses **runtime encryption** to hide bytecode from static analysis.
- **Clears memory** after execution to prevent memory dumps.
- Can be extended with **polymorphic encryption** for stronger obfuscation.

## Contribution
Feel free to fork this repository, submit issues, or contribute improvements via pull requests.

