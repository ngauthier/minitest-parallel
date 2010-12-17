# MiniTest::Parallel

## Usage

    require 'minitest/parallel'

    # optionally set the number of processors
    MiniTest::Parallel.processor_count = 2
    # if you don't set the number of processors, it
    # defaults to the number of processors in your
    # system

You MUST require minitest/parallel before you require any other minitest
files. MiniTest::Parallel is a monkeypatch, and therefore requires a
specific version of the MiniTest gem to be activated.

## Gotchas

MiniTest::Parallel runs your tests in parallel. That means if you try to access
a shared object (like a database, or a third-party service) you need to
make sure that you can interact with that services in a parallel manner.

I suggest making a separate directory of serial tests. Then, create two
rake tasks, one for serial, and one for parallel. In the parallel task,
require MiniTest::Parallel.
