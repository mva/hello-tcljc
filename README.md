## Project Template for `tcljc`

This repository serves as a basic project template, using the classic
"hello world" program.

### Prerequisites

- Linux.  Has not been tested with Window or macOS *at all*.

- An OpenJDK build of `jdk-sandbox`'s
  [classfile-api-branch](https://github.com/openjdk/jdk-sandbox/tree/classfile-api-branch).
  This branch holds the in-development Classfile API ([draft
  JEP](https://openjdk.org/jeps/8280389)) and also follows the OpenJDK
  development version on an irregular schedule (at the time of writing
  this will become JDK 20).  It holds code that may change at the drop
  of a hat, and that may never make it into a stable JDK release.

- A copy of `tcljc`'s modules matching the OpenJDK build from
  repository
  [bootstrap-tcljc](https://github.com/mva/bootstrap-tcljc).  As long
  as there are no releases, the modules are distributed as a
  repository of classfiles.

### Running the Thing

`Makefile` lists the most common commands.  They come as classic
one-shot invocations (like `make compile`), and as `watch-…` targets
(like `make watch-and-test`).  The latter start the compiler in a
looping mode.  Each time a source file changes, a recompile is
triggered and on success a parameterless function is called.

The makefile reads two environment variables:

- `JAVA_HOME` must point to the OpenJDK build and the JVM executable
  `$JAVE_HOME/bin/java` will be used.  Default is
  `~/local/jdk-classfile`.

- `TCLJC_MDIR` is the bootstrap-tcljc directory holding the three
  modules that comprise the compiler: runtime, core libraries, and the
  compiler itself.  Default is `../bootstrap-tcljc`.
