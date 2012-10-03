Rack Remove Param
=================

This can remove unwanted params from your POST reqs.

Install
=======

Add this to your applications Gemfile:

    gem 'rack-remove-param'

And run:

    $ bundle

Usage
=====

In config/application.rb

    config.middleware.insert 'Rack::RemoveParam', 'should_group_accessibility_children'

Where 'should_group_accessibility_children' is the param you want to filter.

