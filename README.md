# Square and Multiply

The Square and Multiply algorithm is used for quickly calculating exponent operations $a^b ~ (mod ~ n)$ where $a$ and $b$ are very large; this algorithm is famously useful for the RSA encryption algorithm which relies on such exponent operations.

## How to Run

The program includes a shebang so you can run it with `./` in Linux. You must have SBCL installed to run the program.

| Argument | Description                |
|----------|----------------------------|
| `-v`     | Run in verbose output mode |
| `a`      | Positional                 |
| `b`      | Positional                 |
| `n`      | Positional                 |