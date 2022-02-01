# Bank Tech Test

This is my first tech test , I will practice my OO design and TDD skills, aiming to produce the best code I can when there is a minimal time pressure.

### Tools

- ruby 3.0.2
- rspec
- simplecov
- simplecov-console

## Quick start

clone this repo

```
> bundle install
> rspec # run tests to ensure everything works
```

### User stories

```
As a user,
so that I can add money to my account,
I would like to make a deposit.
```

```
As a user,
so that I can retrieve money from my account,
I would like to make a withdrawal.
```

```
As a user,
so that I can see how I used my money,
I would like to see my bank statement.
```

## Specifications:

- [x] make a **deposit**
- [x] make a **withdrawal**
- [x] creates a statement when a deposit is made (date, amount and balance)
- [x] creates a statement when a withdrawal is made (date, amount and balance)
- [x] show a list of **statements**
- [ ] edge cases

edge cases:

- user withdraws more money than she has on her account ?
- user can input the a negative balance when creating a statement?
- the amount withdrawn or deposit can't be negative?

## Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2023  
**And** a deposit of 2000 on 13-01-2023  
**And** a withdrawal of 500 on 14-01-2023  
**When** she prints her bank statement  
**Then** she would see

```
date || credit || debit || balance
14/01/2023 || || 500.00 || 2500.00
13/01/2023 || 2000.00 || || 3000.00
10/01/2023 || 1000.00 || || 1000.00
```

### Notes and Thoughts

**BankAccount class** : After creating a [Diagram (based on the specifications)](./img/Screenshot%202022-01-31%20at%2016.45.12.png), I realised that the `#withdraw` and `#deposit` methods would no longer return the `@balance` once I've added the Statement class.
This is why I created a `#print_balance` method to keep track of the current balance like #print_statements will keep track of all statements.

The `#withdraw` and `#deposit` methods will have an extra argument (date) in the future.

**Statement class** :My methods `#save_credit` and `#save_debit` are too similar to be different methods.
Merging them into one method and adding a status: like true makes is a credit statement and false a debit statement would help to keep my code DRY.

### IRB feature test for Statement class

```
3.0.3 :001 > load "./lib/statement.rb"
 => true
3.0.3 :002 > statement = Statement.new
 => #<Statement:0x00007fd9940c4570 @statements=[]>
3.0.3 :003 > statement.save_statement(100, "31/01/22", 1500, true)
 => [{:date=>"31/01/22", :balance=>"1500.00", :debit=>"100.00", :credit=>"-"}]
3.0.3 :004 > statement.save_statement(150, "03/02/22", 2000, false)
 =>
[{:date=>"31/01/22", :balance=>"1500.00", :debit=>"100.00", :credit=>"-"},
 {:date=>"03/02/22", :balance=>"2000.00", :debit=>"-", :credit=>"150.00"}]
3.0.3 :005 > puts statement.print_statements
date || credit || debit || balance
31/01/22 || 100.00 || - || 1500.00
03/02/22 || - || 150.00 || 2000.00
 => nil
```

So we are pretty close. The Statement class behaves as we expect, next step will be letting the Bank class create statement each time there is a withdrawal or deposit.

I will inject the statement class into the bank class so that any withdrawal or deposit will automatically create a statement.

the flow for the user will be as follow:

- a user can create an account
- a user can make a deposit
- a user can see her current balance
- a user can make a withdrawal
- a user can see all her statements (newest first)
