# ContentlyCalculator
###A calculator!

As a warning, I did't have the time to sit down and do nearly as much as I wanted, this weekend turned hectic.

Anyhow, Here it is, void of any specs or input validation and requires a rather strict format in order to be parsed properly!

#### Things to note

All numbers and operations and parentheses must have a space separating them (lame, I know, I am rather dissapointed myself!)

all numbers must be integers or decimals, nothing too fancy smancy, operators are `+ - * / ^`

parentheses can be used, go wild

#### TODO 
And I should definitely have some specs! Probably a long time ago!


#### Sample Output
```bash
~repos/ContentlyCalculator ruby calculator.rb
3 * 2 ^ ( ( 3 + 1 ) - 1 *  5 + 2 ) = 6.0

3 * 2 ^ ( ( 3 + 1 ) - 1 * ( 5 + 2 ) ) = 0.375

3 * 2 ^ ( ( 3 + 1 ) - 1 * ( 5 + 2 ) ) + 1.1 = 1.475

3*2^((3+1)-1(5+2))+1.1 = 1.475

3*2^((3+1)-1(5+2))+1.1 = 1.475

3*2^((3+(1))-1(((5+2))))+1.1 = 1.475
```
