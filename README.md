## Project Template for `tcljc`

This repository serves as a basic project template, using the classic
"hello world" program.

### Prerequisites

- Linux.  Has not been tested with Window or macOS *at all*.

- An **early-access** build of [OpenJDK](https://jdk.java.net/) (at
  the time of writing JDK 22 b27 aka `jdk-22+27`) that includes [JEP
  457: Class-File API (Preview)](https://openjdk.org/jeps/457).
  Please note that this JEP currently has the status of a *preview*
  and as such is subject to changes that won't be binary compatible to
  prior versions.

- A copy of `tcljc`'s modules from repository
  [bootstrap-tcljc](https://github.com/mva/bootstrap-tcljc) that match
  the early-access OpenJDK build.  As long as there are no releases,
  the modules will be distributed as a repository of class files.

### Running the Thing

`Makefile` lists the most common commands.  They come as classic
one-shot invocations (like `make compile`), and as `watch-…` targets
(like `make watch-and-test`).  The latter start the compiler in a
looping mode.  Each time a source file changes, a recompile is
triggered and on success a parameterless function is called.

The makefile reads two environment variables:

- `JAVA_HOME` must point to the OpenJDK build.  The JVM executable
  `$JAVA_HOME/bin/java` will be used.  Default is
  `~/local/jdk-classfile`.

- `TCLJC_MDIR` is the bootstrap-tcljc directory holding the three
  modules that comprise the compiler: runtime, core libraries, and the
  compiler classes.  Default is `../bootstrap-tcljc`.
