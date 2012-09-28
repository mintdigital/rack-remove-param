Rack Remove Param
=================

This can remove params from your POST reqs.

It could be used for anything, but I created it because as of iOS6 apple seems 
to be injecting extra params, causing rails to crash.

Namely should_group_accessibility_children.

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

