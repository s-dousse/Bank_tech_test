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
> rspec # run test to ensure it works
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

- [ ] make a **deposit**
- [ ] make a **withdrawal**
- [ ] creates a statement when a deposit is made (date, amount and balance)
- [ ] creates a statement when a withdrawal is made (date, amount and balance)
- [ ] show a list of **statements**

edge cases:

- user withdraws more money than she has on her account ?

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
