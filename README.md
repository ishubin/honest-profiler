honest-profiler
===============

An attempt to have a usable and honest profiler for the JVM.

Design
------

The program has two major components. There is a small C++ jvmti agent which
writes out a log file describing a profile of the application it has been
attached to. Then a Java application can render/display a profile based on this
log. Generating a log means that profile can be analysed retrospective/offline.
It should be possible to do online profiling by writing the log file into a
memory mapped file which can then be concurrently read by the Java application.

Honest profiler takes the same approach outlined by Jeremy Manson where calls
are made to the `AsyncGetCallTrace` jvm method which avoids the need for threads
to reach a safe point in order to read their call trace. Consequently it avoids
a number of profiler accuracy issues that other sampling profilers suffer from.

The downside of using this method is that the code in your async callback has
horrific restrictions on it. What honest profiler does is copy the current
stack trace into a non-blocking, allocation free, circular MPSC queue. These
stack traces are then read by another thread which writes out the log file and
looks up information about useful things like methods names.

Based upon code originally open sourced by Jeremy Manson/Google:
http://jeremymanson.blogspot.co.uk/2013/07/lightweight-asynchronous-sampling.html

Compiling
---------

```
make
mvn package
```

Dependencies
------------

unittest++ - a unit testing library

To install on debian/ubuntu:
```
sudo apt-get install libunittest++-dev
```

