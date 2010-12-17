require 'minitest/parallel'
require 'stringio'
class MiniTest::FirstTest < MiniTest::Unit::TestCase
  def test_sleep_one
    sleep(1)
  end
end

class MiniTest::SecondTest < MiniTest::Unit::TestCase
  def test_sleep_two
    sleep(1)
  end
end

$stdout.write "Beginning MiniTest::Parallel Tests\n"

# Stifle
MiniTest::Unit.output = StringIO.new

# On one processor, this should take at least two seconds
MiniTest::Parallel.processor_count = 1
start = Time.now
MiniTest::Unit.new.run
if Time.now-start < 2
  raise "MiniTest::Parallel went faster than it should have"
else
  $stdout.write "."
end

# On two processors, this should take less than 1.25 seconds
MiniTest::Parallel.processor_count = 2
start = Time.now
MiniTest::Unit.new.run
if Time.now-start > 1.25
  raise "MiniTest::Parallel did not accelerate the test suite"
else
  $stdout.write "."
end

$stdout.write "\n"

$stdout.write "All tests passed\n"
