# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

rails g scaffold posts title description when_went:datetime
rails g model comment content post:references user:references
rails g model reaction post:references user:references kind reaction_type comment:references
