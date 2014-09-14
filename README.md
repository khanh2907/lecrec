Lecrec
================

The LECREC system is designed to include a multitude of specific functions to allow for the encouragement of learning throughout a lecture recording especially by utilising the section based video discussion thread feature. The project is expected to take 12 weeks, including project management, documentation and full implementation.

Features
-----------

- User Management
- Unit of Study Management
- Lecture Recording Upload and Managament
- Lecture Recording Discussion Threads and Comments
- Embedded video discussions for community users
- Lecture Quiz feature (maybe)

Requirements
-------------

This application requires:

- Ruby 2.1.1
- Rails 4.1.0
- Postgresql 9+

Getting Started
---------------

Create database user

	sudo su postgres
	createuser lecrec

Install Redis

	$ wget http://download.redis.io/releases/redis-2.8.15.tar.gz
	$ tar xzf redis-2.8.15.tar.gz
	$ cd redis-2.8.15
	$ make	

Start Redis

	$ src/redis-server	

Setup app

	$ git clone https://github.com/khanh2907/lecrec.git
	$ cd lecrec
	$ bundle install
	$ rake db:setup
	$ rake db:seed_uos

Start RESQUE worker

	$ bundle exec rake environment resque:work QUEUE=convert

Start app

	$ rails s