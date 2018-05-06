# Welcome to Rubypedia
## A Rails5 application by Lucas Cuba

### Introduction

Rubypedia is a wiki-esque web application built in Rails5 by Lucas Cuba. Here you can sign up for an account and create/edit general knowledge articles styled with markdown. In order to create private posts and add others to those private posts, users must upgrade to premium status.

This application uses several gems to provide these services, including pundit, devise, and stripe.

A link to the deployed application can be found here: https://rubypedia-lcuba.herokuapp.com/

### User Role Information

This application has three roles for its users: standard, premium, and admin. There is also a guest tier that lets you do search around at a basic level. Standard users are non-paid and are established from the sign-up page. 
Using the devise gem, the application will send a confirmation email to the provided address in order to confirm the account.
They are permitted to create and edit public posts but only to delete those that they created. They cannot see private posts that they are not collaborators on. As a general note, the application will tend to not show options to users who are not permitted to execute those actions. 
Premium users are established when a standard user pays $15 through the stripe gem. Premium users have the authority to create private posts, where they can then assign users to become collaborators on those private posts. Added users will be given read/write permissions. 
Premium users are not able to see other premium users' private posts unless they are added as collaborators just like standard users.
Admin users are the top tier, and as the name suggests they can do every kind of CRUD operation on anything in the application. 

### Using the application

For testing, I have created three dummy accounts:

* standard@standard.com
* premium@premium.com
* admin@admin.com

All of these accounts have the same dummy password, "asdfjkl;", for testing. Simply sign-in on these accounts to test out different features. If you want to test out upgrading/downgrading your account, when prompted use the dummy information "4242424242424242" as the card number, "standard@standard.com" as the email, any month/year combo that isn't expired, and a random CVC 3-digit number.
Feel free to also test out the email confirmation system with an email address of your own, just keep in mind that you may need to check your spam folder for the confirmation email. 

Anyway, thanks for checking out Rubypedia!

