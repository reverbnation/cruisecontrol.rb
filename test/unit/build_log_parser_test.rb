require 'test_helper'

class BuildLogParserTest < ActiveSupport::TestCase

LOG_OUTPUT_NEW_TEST_UNIT = <<EOF
Loaded suite test/integration/signup_test
Started
F
===============================================================================
Failure: blah.
  kjdflas
  adfsjkl
  lkdas
test_flunk(SignupTest)
test/integration/signup_test.rb:111:in `test_flunk'
     108:   end
     109:
     110:   def test_flunk
  => 111:     flunk("blah")
     112:   end
     113:
     114:   protected
/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/activesupport-2.2.3/lib/active_support/testing/setup_and_teardown.rb:94:in `__send__'
/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/activesupport-2.2.3/lib/active_support/testing/setup_and_teardown.rb:94:in `run'
/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/actionpack-2.2.3/lib/action_controller/integration.rb:597:in `run'
===============================================================================
E
===============================================================================
Error: test_v3_artist_signup(SignupTest)
  NoMethodError: undefined method `d' for #<ActionController::Integration::Session:0x878c1e0>
/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/actionpack-2.2.3/lib/action_controller/test_process.rb:471:in `method_missing'
/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/actionpack-2.2.3/lib/action_controller/integration.rb:498:in `__send__'
/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/actionpack-2.2.3/lib/action_controller/integration.rb:498:in `method_missing'
test/integration/signup_test.rb:9:in `test_v3_artist_signup'
      6:
      7:   # New V3 Signup
      8:   def test_v3_artist_signup
  =>  9:     d-
     10:     # setup Artist to force successful verify of recaptcha
     11:     Artist.any_instance.stubs(:verify_recaptcha).returns(true)
     12:     GateKeeper.stubs(:open_for?).returns(true)
/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/activesupport-2.2.3/lib/active_support/testing/setup_and_teardown.rb:94:in `__send__'
/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/activesupport-2.2.3/lib/active_support/testing/setup_and_teardown.rb:94:in `run'
/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/actionpack-2.2.3/lib/action_controller/integration.rb:597:in `run'
===============================================================================


Finished in 2.867201 seconds.

2 tests, 1 assertions, 1 failures, 1 errors, 0 pendings, 0 omissions, 0 notifications
0% passed

0.70 tests/s, 0.35 assertions/s
EOF

PARSED_NEW_OUTPUT_EXPECTED = "---\n- !ruby/struct:TestErrorEntry\n  type: Failure\n  test_name: test_flunk(SignupTest)\n  message: ! \"blah.\\n  kjdflas\\n  adfsjkl\\n  lkdas\"\n  stacktrace: ! \"\\ntest/integration/signup_test.rb:111:in `test_flunk'\\n     108:\n    \\  end\\n     109:\\n     110:   def test_flunk\\n  => 111:     flunk(\\\"blah\\\")\\n\n    \\    112:   end\\n     113:\\n     114:   protected\\n/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/activesupport-2.2.3/lib/active_support/testing/setup_and_teardown.rb:94:in\n    `__send__'\\n/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/activesupport-2.2.3/lib/active_support/testing/setup_and_teardown.rb:94:in\n    `run'\\n/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/actionpack-2.2.3/lib/action_controller/integration.rb:597:in\n    `run'\"\n- !ruby/struct:TestErrorEntry\n  type: Error\n  test_name: ! ' test_v3_artist_signup(SignupTest)'\n  message: ! '  NoMethodError: undefined method `d'' for #<ActionController::Integration::Session:0x878c1e0>\n\n'\n  stacktrace: ! \"/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/actionpack-2.2.3/lib/action_controller/test_process.rb:471:in\n    `method_missing'\\n/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/actionpack-2.2.3/lib/action_controller/integration.rb:498:in\n    `__send__'\\n/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/actionpack-2.2.3/lib/action_controller/integration.rb:498:in\n    `method_missing'\\ntest/integration/signup_test.rb:9:in `test_v3_artist_signup'\\n\n    \\     6:\\n      7:   # New V3 Signup\\n      8:   def test_v3_artist_signup\\n  =>\n    \\ 9:     d-\\n     10:     # setup Artist to force successful verify of recaptcha\\n\n    \\    11:     Artist.any_instance.stubs(:verify_recaptcha).returns(true)\\n     12:\n    \\    GateKeeper.stubs(:open_for?).returns(true)\\n/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/activesupport-2.2.3/lib/active_support/testing/setup_and_teardown.rb:94:in\n    `__send__'\\n/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/activesupport-2.2.3/lib/active_support/testing/setup_and_teardown.rb:94:in\n    `run'\\n/home/drasch/.rvm/gems/ree-1.8.7-2012.02@reverbnation/gems/actionpack-2.2.3/lib/action_controller/integration.rb:597:in\n    `run'\"\n"




LOG_OUTPUT_WITH_NO_TEST_FAILURE = <<EOF
Started
..................................................................................
Finished in 0.687 seconds.

82 tests, 183 assertions, 0 failures, 0 errors
Loaded suite c:/ruby/lib/ruby/gems/1.8/gems/rake-0.7.1/lib/rake/rake_test_loader
Started
.......
Finished in 0.203 seconds.

7 tests, 13 assertions, 0 failures, 0 errors
Loaded suite c:/ruby/lib/ruby/gems/1.8/gems/rake-0.7.1/lib/rake/rake_test_loader
Started
..........
Finished in 15.689 seconds.

10 tests, 20 assertions, 0 failures, 0 errors
EOF

LOG_OUTPUT_WITH_MOCK_TEST_FAILURE = <<EOF
Finished in 4.377143 seconds.

  1) Failure:
test_should_check_force_build(PollingSchedulerTest) [./test/unit/polling_scheduler_test.rb:44]:
#<Mocha::Mock:0x-245ec74a>.force_build_if_requested - expected calls: 1, actual calls: 2

126 tests, 284 assertions, 1 failures, 0 errors

EOF

LOG_OUTPUT_WITH_TEST_ERRORS_ON_WINDOWS = <<EOF
Loaded suite c:/ruby/lib/ruby/gems/1.8/gems/rake-0.7.1/lib/rake/rake_test_loader
Started
....................................................................FF.............
Finished in 1.453 seconds.

  3) Error:
test_should_fail_due_to_comparing_same_objects_with_different_data(BuildLogParserTest):
NameError: undefined local variable or method `expectedFirstTestFixture' for #<BuildLogParserTest:0x3f65a60>
    C:/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/rails/actionpack/lib/action_controller/test_process.rb:456:in `method_missing'
    ./test/unit/test_failure_parser_test.rb:75:in `test_should_fail_due_to_comparing_same_objects_with_different_data'
    C:/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `__send__'
    C:/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `run'

83 tests, 185 assertions, 2 failures, 0 errors
EOF

LOG_OUTPUT_WITH_TEST_ERRORS_ON_UNIX = <<EOF
Loaded suite /usr/local/lib/ruby/lib/ruby/gems/1.8/gems/rake-0.7.1/lib/rake/rake_test_loader
Started
....................................................................FF.............
Finished in 1.453 seconds.

  3) Error:
test_should_fail_due_to_comparing_same_objects_with_different_data(BuildLogParserTest):
NameError: undefined local variable or method `expectedFirstTestFixture' for #<BuildLogParserTest:0x3f65a60>
    /home/user_name/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/rails/actionpack/lib/action_controller/test_process.rb:456:in `method_missing'
    ./test/unit/test_failure_parser_test.rb:75:in `test_should_fail_due_to_comparing_same_objects_with_different_data'
    /home/user_name/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `__send__'
    /home/user_name/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `run'

83 tests, 185 assertions, 2 failures, 0 errors
EOF


LOG_OUTPUT_WITH_NO_TEST_ERRORS = <<EOF
Started
..................................................................................
Finished in 0.687 seconds.

82 tests, 183 assertions, 0 failures, 0 errors
Loaded suite c:/ruby/lib/ruby/gems/1.8/gems/rake-0.7.1/lib/rake/rake_test_loader
Started
.......
Finished in 0.203 seconds.

7 tests, 13 assertions, 0 failures, 0 errors
Loaded suite c:/ruby/lib/ruby/gems/1.8/gems/rake-0.7.1/lib/rake/rake_test_loader
Started
..........
Finished in 15.689 seconds.

10 tests, 20 assertions, 0 failures, 0 errors
EOF

LOG_OUTPUT_WITH_TEST_FAILURE_ON_WINDOWS = <<EOF
Loaded suite c:/ruby/lib/ruby/gems/1.8/gems/rake-0.7.1/lib/rake/rake_test_loader
Started
....................................................................FF.............
Finished in 1.453 seconds.

  1) Failure:
test_should_fail(SubversionLogParserTest)
    [./test/unit/subversion_log_parser_test.rb:125:in `test_should_fail'
     C:/projects/cruisecontrol.rb/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `__send__'
     C:/projects/cruisecontrol.rb/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `run']:
<1> expected but was
<"abc">.

  2) Failure:
test_should_check_force_build(PollingSchedulerTest) [./test/unit/polling_scheduler_test.rb:44]:
#<Mocha::Mock:0x-245ea224>.force_build_if_requested - expected calls: 1, actual calls: 2

125 tests, 284 assertions, 1 failures, 0 errors
/usr/bin/ruby1.8 -Ilib:test "/usr/lib/ruby/1.8/rake/rake_test_loader.rb" "test/functional/projects_controller_test.rb"
Loaded suite /usr/lib/ruby/1.8/rake/rake_test_loader
Started
..........
Finished in 0.251448 seconds.

10 tests, 23 assertions, 0 failures, 0 errors
/usr/bin/ruby1.8 -Ilib:test "/usr/lib/ruby/1.8/rake/rake_test_loader.rb" "test/integration/builder_integration_test.rb"
Loaded suite /usr/lib/ruby/1.8/rake/rake_test_loader
Started
..............
Finished in 25.224997 seconds.

14 tests, 28 assertions, 0 failures, 0 errors
rake aborted!
Test failures
EOF

LOG_OUTPUT_WITH_TEST_FAILURE_ON_UNIX = <<EOF
Loaded suite /usr/local/lib/ruby/lib/ruby/gems/1.8/gems/rake-0.7.1/lib/rake/rake_test_loader
Started
....................................................................FF.............
Finished in 1.453 seconds.

  1) Failure:
test_should_fail(SubversionLogParserTest)
    [./test/unit/subversion_log_parser_test.rb:125:in `test_should_fail'
     /home/user_name/projects/cruisecontrol.rb/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `__send__'
     /home/user_name/projects/cruisecontrol.rb/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `run']:
<1> expected but was
<"abc">.

  2) Failure:
test_should_check_force_build(PollingSchedulerTest) [./test/unit/polling_scheduler_test.rb:44]:
#<Mocha::Mock:0x-245ea224>.force_build_if_requested - expected calls: 1, actual calls: 2

125 tests, 284 assertions, 1 failures, 0 errors
/usr/bin/ruby1.8 -Ilib:test "/usr/lib/ruby/1.8/rake/rake_test_loader.rb" "test/functional/projects_controller_test.rb"
Loaded suite /usr/lib/ruby/1.8/rake/rake_test_loader
Started
..........
Finished in 0.251448 seconds.

10 tests, 23 assertions, 0 failures, 0 errors
/usr/bin/ruby1.8 -Ilib:test "/usr/lib/ruby/1.8/rake/rake_test_loader.rb" "test/integration/builder_integration_test.rb"
Loaded suite /usr/lib/ruby/1.8/rake/rake_test_loader
Started
..............
Finished in 25.224997 seconds.

14 tests, 28 assertions, 0 failures, 0 errors
rake aborted!
Test failures
EOF

LOG_OUTPUT_OF_SUCCESSFUL_RSPEC_RUN = <<EOF
.

Finished in 0.006387 seconds

1 example, 0 failures
EOF

LOG_OUTPUT_WITH_RSPEC_FAILURE = <<EOF
.F

1)
'foo should fail' FAILED
expected: 2,
     got: 1 (using ==)
./fail_spec.rb:7:

Finished in 0.006825 seconds

2 examples, 1 failure
EOF

LOG_OUTPUT_WITH_RSPEC_ERROR = <<EOF
.F

1)
RuntimeError in 'foo should err'
oops
./foo_spec.rb:20:in `blow_up'
./err_spec.rb:7:

Finished in 0.006761 seconds

2 examples, 1 failure
EOF

LOG_OUTPUT_WITH_VARIETY_OF_RSPEC_STUFF = <<EOF
.FFP

Pending:
foo should be pending (Not Yet Implemented)

1)
'foo should fail' FAILED
expected: 2,
     got: 1 (using ==)
./fail_spec.rb:7:

2)
RuntimeError in 'foo should err'
oops
./foo_spec.rb:20:in `blow_up'
./err_spec.rb:7:

Finished in 0.007491 seconds

4 examples, 2 failures, 1 pending
EOF

COMPLEX_RSPEC_ERROR = <<-EOF
Running SeleniumFastSpecSuite
Starting GameServer with RAILS_ENV=selenium_test
Profiling enabled.
.FF


Top 10 slowest examples:
49.2588670 Game with two users game flow

1)
Polonium::PoloniumError in 'Single user game playing the game can answer questions'
We got a new page, but it was an application exception page.

/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/wait_for.rb:40:in `flunk'
/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/driver.rb:143:in `assert_page_loaded'
/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/driver.rb:77:in `click_and_wait'

2)
Polonium::PoloniumError in 'Single user game when an existing User is logged in time limits are short times out due to inactivity'
We got a new page, but it was an application exception page.

/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/wait_for.rb:40:in `flunk'
/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/driver.rb:143:in `assert_page_loaded'
/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/driver.rb:77:in `click_and_wait'

Finished in 59.190039 seconds

3 examples, 2 failures
rake aborted!
Failure
EOF

COMPLEX_RSPEC_FAILURE = <<-EOF
Running SeleniumFastSpecSuite
Starting GameServer with RAILS_ENV=selenium_test
Profiling enabled.
.FF


Top 10 slowest examples:
49.2588670 Game with two users game flow

1)
'Single user game playing the game can answer questions' FAILED
We got a new page, but it was an application exception page.

/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/wait_for.rb:40:in `flunk'
/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/driver.rb:143:in `assert_page_loaded'
/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/driver.rb:77:in `click_and_wait'

2)
'Single user game when an existing User is logged in time limits are short times out due to inactivity' FAILED
We got a new page, but it was an application exception page.

/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/wait_for.rb:40:in `flunk'
/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/driver.rb:143:in `assert_page_loaded'
/home/user/.cruise/projects/mole/work/vendor/plugins/polonium/lib/polonium/driver.rb:77:in `click_and_wait'

Finished in 59.190039 seconds

3 examples, 2 failures
rake aborted!
Failure
EOF


  context "#failures" do
    test "should not find test failures with a build with test errors on windows" do
      assert BuildLogParser.new(LOG_OUTPUT_WITH_TEST_ERRORS_ON_WINDOWS).failures.empty?
    end

    test "should not find test failures with a build with test errors on unix" do
      assert BuildLogParser.new(LOG_OUTPUT_WITH_TEST_ERRORS_ON_UNIX).failures.empty?
    end

    test "should find no test failures with a successful build" do
      assert BuildLogParser.new(LOG_OUTPUT_WITH_NO_TEST_FAILURE).failures.empty?
    end

    test "should find test failures on windows" do
      failures = BuildLogParser.new(LOG_OUTPUT_WITH_TEST_FAILURE_ON_WINDOWS).failures
      assert_equal [expected_first_test_failure_on_windows, expected_second_test_failure], failures
    end

    test "should find test failures on unix" do
      failures = BuildLogParser.new(LOG_OUTPUT_WITH_TEST_FAILURE_ON_UNIX).failures
      assert_equal [expected_first_test_failure_on_unix, expected_second_test_failure], failures
    end

    test "should correctly parse mocha test failures" do
      failures = BuildLogParser.new(LOG_OUTPUT_WITH_MOCK_TEST_FAILURE).failures
      assert_equal [expected_mock_test_failure], failures
    end

    test "should find RSpec failures" do
      failures = BuildLogParser.new(LOG_OUTPUT_WITH_RSPEC_FAILURE).failures
      assert_equal [expected_rspec_failure], failures
    end

    test "should find RSpec complex failures" do
      failures = BuildLogParser.new(COMPLEX_RSPEC_FAILURE).failures
      assert_equal 2, failures.length
    end
  end

  context "#errors" do
    test "should not find test errors with a build with test failures on windows" do
      assert BuildLogParser.new(LOG_OUTPUT_WITH_TEST_FAILURE_ON_WINDOWS).errors.empty?
    end

    test "should not find test errors with a build with test failures on unix" do
      assert BuildLogParser.new(LOG_OUTPUT_WITH_TEST_FAILURE_ON_UNIX).errors.empty?
    end

    test "should find no test errors with successful build" do
      assert BuildLogParser.new(LOG_OUTPUT_WITH_NO_TEST_ERRORS).errors.empty?
    end

    test "should find test errors with unsuccessful build on Windows" do
      assert_equal [expected_test_error_on_windows], BuildLogParser.new(LOG_OUTPUT_WITH_TEST_ERRORS_ON_WINDOWS).errors
    end

    test "should find test errors with unsuccessful build on Unix" do
      assert_equal [expected_test_error_on_unix], BuildLogParser.new(LOG_OUTPUT_WITH_TEST_ERRORS_ON_UNIX).errors
    end

    test "should find RSpec errors" do
      errors = BuildLogParser.new(LOG_OUTPUT_WITH_RSPEC_ERROR).errors
      assert_equal [expected_rspec_error], errors
    end

    test "should find RSpec complex errors" do
      errors = BuildLogParser.new(COMPLEX_RSPEC_ERROR).errors
      assert_equal 2, errors.length
    end
  end

  context "#failures_and_errors" do

    test "should process multiple errors and failures new test::unit" do
      failures_and_errors = BuildLogParser.new(LOG_OUTPUT_NEW_TEST_UNIT).failures_and_errors
      assert_equal YAML.load(PARSED_NEW_OUTPUT_EXPECTED) , failures_and_errors
    end

    test "should find no RSpec failures with a successful build" do
      assert BuildLogParser.new(LOG_OUTPUT_OF_SUCCESSFUL_RSPEC_RUN).failures_and_errors.empty?
    end

    test "should process multiple errors and failures" do
      failures_and_errors = BuildLogParser.new(LOG_OUTPUT_WITH_VARIETY_OF_RSPEC_STUFF).failures_and_errors
      assert_equal [expected_rspec_failure, expected_rspec_error], failures_and_errors
    end
  end

  private

    def expected_test_error_on_windows
      TestErrorEntry.create_error("test_should_fail_due_to_comparing_same_objects_with_different_data(BuildLogParserTest)",
                                  "NameError: undefined local variable or method `expectedFirstTestFixture' for #<BuildLogParserTest:0x3f65a60>",
                                  "    C:/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/rails/actionpack/lib/action_controller/test_process.rb:456:in `method_missing'\n" +
                                  "    ./test/unit/test_failure_parser_test.rb:75:in `test_should_fail_due_to_comparing_same_objects_with_different_data'\n" +
                                  "    C:/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `__send__'\n" +
                                  "    C:/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `run'")
    end

    def expected_test_error_on_unix
      TestErrorEntry.create_error("test_should_fail_due_to_comparing_same_objects_with_different_data(BuildLogParserTest)",
                                  "NameError: undefined local variable or method `expectedFirstTestFixture' for #<BuildLogParserTest:0x3f65a60>",
                                  "    /home/user_name/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/rails/actionpack/lib/action_controller/test_process.rb:456:in `method_missing'\n" +
                                  "    ./test/unit/test_failure_parser_test.rb:75:in `test_should_fail_due_to_comparing_same_objects_with_different_data'\n" +
                                  "    /home/user_name/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `__send__'\n" +
                                  "    /home/user_name/projects/cruisecontrol.rb/builds/ccrb/work/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `run'")
    end

    def expected_first_test_failure_on_windows
      TestErrorEntry.create_failure("test_should_fail(SubversionLogParserTest)",
                                    "<1> expected but was\n<\"abc\">.",
                                    "./test/unit/subversion_log_parser_test.rb:125:in `test_should_fail'\n" +
                                    "     C:/projects/cruisecontrol.rb/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `__send__'\n" +
                                    "     C:/projects/cruisecontrol.rb/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `run'")
    end

    def expected_first_test_failure_on_unix
      TestErrorEntry.create_failure("test_should_fail(SubversionLogParserTest)",
                                    "<1> expected but was\n<\"abc\">.",
                                    "./test/unit/subversion_log_parser_test.rb:125:in `test_should_fail'\n" +
                                    "     /home/user_name/projects/cruisecontrol.rb/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `__send__'\n" +
                                    "     /home/user_name/projects/cruisecontrol.rb/config/../vendor/plugins/mocha/lib/mocha/test_case_adapter.rb:19:in `run'")
    end

    def expected_second_test_failure
      TestErrorEntry.create_failure("test_should_check_force_build(PollingSchedulerTest)",
                                    "#<Mocha::Mock:0x-245ea224>.force_build_if_requested - expected calls: 1, actual calls: 2",
                                    "./test/unit/polling_scheduler_test.rb:44")
    end

    def expected_mock_test_failure
      TestErrorEntry.create_failure("test_should_check_force_build(PollingSchedulerTest)",
                                    "#<Mocha::Mock:0x-245ec74a>.force_build_if_requested - expected calls: 1, actual calls: 2",
                                    "./test/unit/polling_scheduler_test.rb:44")
    end

    def expected_rspec_failure
      TestErrorEntry.create_failure('foo should fail', "expected: 2,\n     got: 1 (using ==)", "./fail_spec.rb:7:")
    end

    def expected_rspec_error
      TestErrorEntry.create_error('foo should err', "RuntimeError in 'foo should err'\noops", "./foo_spec.rb:20:in `blow_up'\n./err_spec.rb:7:")
    end
end
