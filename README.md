# ContentlyCalculator
###A calculator!

As a warning, I did't have the time to sit down and do nearly as much as I wanted, this weekend turned hectic.

Anyhow, Here it is, void of any specs or input validation and requires a somewhat strict format in order to be parsed properly!

#### Things to note

all numbers must be integers or decimals, nothing too fancy smancy, operators are `+ - * / ^`

parentheses can be used, go wild

#### TODO
I should definitely have some specs! Probably a long time ago! Sorry I am on a
time crunch (I know its a poor excuse)

Make all the regex nonsense much cleaner and more reusable

Not put everything in the same file, sorry!


### RUNNING IT FROM COMMAND LINE

clone the repo then cd into the directory

chmod the executable (`chmod 775 calculator`)

run it with `./calculator`, supplying the expression you want it to solve as a String

ex.
```bash
~/repos/ContentlyCalculator(master ✗) ./calculator '3*2^((3+1)-1(5+2))--1'
```
should output
```bash
3 * 2 ^ ( ( 3 + 1 ) - 1 * ( 5 + 2 ) ) - -1 = 1.375
```



Examples:
```bash
~/repos/ContentlyCalculator(master ✗) ./calculator '4*2^((3+1)-1(((5+-2))))'
3 * 2 ^ ( ( 3 + 1 ) - 1 * ( ( ( 5 + -2 ) ) ) ) = 6.0

~/repos/ContentlyCalculator(master ✗) ./calculator '1 + 2 + 4 / 3'
1 + 2 + 4 / 3 = 4.333333333333333333


~/repos/ContentlyCalculator(master ✗) ./calculator '((((1.1 * 2.3))))'
( ( ( ( 1.1 * 2.3 ) ) ) ) = 2.53


~/repos/ContentlyCalculator(master ✗) ./calculator '1 * 2 + 3 ( 4 / 5 ) --5'
1 * 2 + 3 * ( 4 / 5 ) - -5 = 9.4
```
