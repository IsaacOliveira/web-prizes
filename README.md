# Web Prizes App

Web app that allows a costumer to subscribe to our store with their email, to get news, and apply for prizes.

### Important concepts

#### Subscription

It's when a user enters the email on our landing page, each entry generates a subscription.
The only exception is that we don't accept more than one subscription for the same email in the same day.

If the subscription number matches a prize condition, it receives a prize.

#### Prize

It's defined by a name and a quantity, each time a prize is given to a subscriber, we decrease the quantity, when reaches zero the prize is no longer available.

#### Prize Condition

Each prize condition has a set of rules that are applied to against the subscription number, if all rules matches the number, the prize condition matches, a prize condition also has a prize, which will be given to the subscriber.

#### Rule

A Rule is defined by an operator and a rule number, we setup the operators: 'Equal', 'Greater than', 'Multiple of', 'Smaller than', all rules are relative to the rule number against the subscriber number.

The admin when create a prize condition, can chose one or more rules.

Each rule must be satisfied to the prize condition be considered matched.

### Subscriber prizes matcher logic

The logic to find if a subscriber won a prizer is:

1 - We submit the subscriber number to all rules of a prize condition, if matches all rules, the prize condition is matched.

2 - We test the rules for all prize conditions that has prize quantity greater than zero.

4 - We put all prize conditions matched in a list.

5 - In the same list, at beginning of it, we put the overlapped prize conditions(matched before), so now we have the list of all matched and overlapped conditions ordered.

6 - The first condition of that list is the one the subscriber will win the prize.

7 - All the other left conditions matched will set as overlapped.

8 - We set the prize to the subscriber and decrease the quantity of the prize.

9 - If the list of matched conditions is empty, the subscriber did not win any prize.

## Admin

An admin site exists, is acessible by the link on top bar, after you login you be redirected to admin home

In admin home we have two lists, with prizes and prize conditions, that shows all the infos and offer actions to be done.

New prizes, and prizes conditions can be created and existing ones can be edited or deleted.

A prize with at least one prize condition associated can not be deleted.

#### Creating and Editing Prize conditions

In the prize condition form you need to chose which Prize will be given with that condition, and by which rules.

You must chose the operator and rule number of each rule.

A prize condition can have one or more rules, click the add other rule to show other rule form.

# Running the project

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
