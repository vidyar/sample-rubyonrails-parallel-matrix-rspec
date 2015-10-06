

Sample for Rails application with running tests in parallel
===========================================================

This sample illustrates how to run RSpec tests in parallel on Shippable.

Splitting specs into groups
---------------------------

Splitting is done in the `spec/suite.rb` file, which implementation is heavily inspired
by [`cucumber_in_groups`](https://github.com/cloudcastle/cucumber_in_groups).

To run specific group of specs we set `TEST_GROUP` environment variable.

    env:
      matrix:
        - TEST_GROUP=1of3
        - TEST_GROUP=2of3
        - TEST_GROUP=3of3

We then run the tests by passing this file as target to the `rspec` command.
(of course, you can also create a Rake task that does the same):

    script:
      - rspec spec/suite.rb

Please note that the above will trigger three builds, to cover all the combinations
of the build settings. These builds will run in parallel only if number of available
minions is greater or equal to three.

Please refer to
[Shippable documentation](http://docs.shippable.com/en/latest/config.html#build-matrix)
on matrix builds for details.

Using Selenium
--------------

To simulate long-running tests, this sample uses Selenium to execute specs marked
with `:js => true`.
To make Selenium available in Shippable environment, we need to add the following
lines to the `shippable.yml` file:

    addons:
      firefox: "28.0"
    services:
      - selenium

    env:
      global:
        - DISPLAY=:99.0

    before_script: 
      - /etc/init.d/xvfb start 

    after_script:
      - /etc/init.d/xvfb stop

It will make sure that Selenium is installed on the minion and will start and then stop virtual
framebuffer device for X server to render to.

Also, remember to install the required gems by adding the following entries to the `Gemfile`:

    group :development, :test do
      gem 'rspec-rails', '~> 3.0.0'
    end

    group :test do
      gem 'simplecov'
      gem 'simplecov-csv'
      gem 'rspec_junit_formatter'

      gem 'capybara'
      gem 'selenium-webdriver'
    end

Configuring test reporting
--------------------------

To have RSpec output test and coverage reports to the directories expected by Shippable, we need
to declare the following environment variables:

    env:
      global:
        - CI_REPORTS=shippable/testresults COVERAGE_REPORTS=shippable/codecoverage

Then, add the following entries to the `Gemfile`:

    group :test do
      gem 'simplecov'
      gem 'simplecov-csv'
      gem 'rspec_junit_formatter'
    end

Finally, initialize the coverage support in `specs/spec_helper.rb`:

    require 'simplecov'
    require 'simplecov-csv'
    SimpleCov.formatter = SimpleCov::Formatter::CSVFormatter
    SimpleCov.coverage_dir(ENV["COVERAGE_REPORTS"])
    SimpleCov.start 'rails'

And add the required options to RSpec invocation by modifying `.rspec`:

    --format RspecJunitFormatter
    --out <%= ENV['CI_REPORTS'] %>/results.xml

For more detailed documentation, please see [section on Selenium](http://docs.shippable.com/en/latest/config.html#selenium) in Shippable docs.

This sample is built for Shippable, a docker based continuous integration and deployment platform.
