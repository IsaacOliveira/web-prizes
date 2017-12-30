# Web Prizes App

Web app that allows a costumer to subscribe to our store with their email, to get news, and apply for prizes

### Important concepts

#### Subscription

It's when a user enters the email on our landing page, each entry generates a subscription.
The only exception is that we don't accept more than one subscription for the same email in the same day.
If the subscription number matches a prize condition, it receives a prize.

#### Prize

It's defined by a name and a quantity, each time a prize is given to a subscriber, we decrease the quantity, when reaches zero the prize is no longer available.

#### Prize Condition

Each prize condition has a set of rules that are applied to against the subscription number, if all rules matches the number, the prize condition matches, a prize condition also has a prize, which will be given to the subscriber

#### Rule

A Rule is defined by an operator and a rule number, we setup the operators: 'Equal', 'Greater than', 'Multiple of', 'Smaller than', all relative to rule number against the subscriber number.
The admin when creates a prize condition, can chose one or more rules, each rule most be satisfied, so the prize condition be considered matched

### Subscriber prizes matcher engine

TODO

#Running the project

A running instance of project is available at: https://web-prizes.herokuapp.com
To run local will just need to clone the project then run:

```
bundle install
rake db:setup
rails s
```
Then access: http://localhost:3000

# Running the Specs

After you run bundle, you are ready to run the specs
Them to run all the specs:

```
rspec .
```
