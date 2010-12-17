if defined?(MiniTest)
  raise "Do not require minitest before minitest/parallel\n"
end
require 'rubygems'
gem 'minitest', '=2.0.1'
gem 'parallel', '=0.5.1'
require 'parallel'
require 'minitest/unit'

module MiniTest::Parallel
  def self.included(base)
    base.class_eval do
      alias_method :_run_suites_in_series, :_run_suites
      alias_method :_run_suites, :_run_suites_in_parallel
    end
  end

  def self.processor_count=(procs)
    @processor_count = procs
  end

  def self.processor_count
    @processor_count ||= Parallel.processor_count
  end

  def _run_suites_in_parallel(suites, type)
    Parallel.map(suites, :in_processes => MiniTest::Parallel.processor_count) do |suite|
      _run_suite(suite, type)
    end
  end
end

MiniTest::Unit.send(:include, MiniTest::Parallel)
