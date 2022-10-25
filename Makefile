JAVA_HOME ?= ~/local/jdk-classfile
TCLJC_MDIR ?= ../bootstrap-tcljc

JAVA_BIN=$(if $(JAVA_HOME),$(JAVA_HOME)/bin/,)
JAVA=$(JAVA_BIN)java

JAVA_OPTS=--enable-preview --add-modules jdk.incubator.concurrent \
  --add-exports java.base/jdk.classfile=tinyclj.compiler \
  --add-exports java.base/jdk.classfile.constantpool=tinyclj.compiler \
  --add-exports java.base/jdk.classfile.instruction=tinyclj.compiler \
  --add-exports java.base/jdk.classfile.attribute=tinyclj.compiler

TCLJC=$(JAVA) $(JAVA_OPTS) -p $(TCLJC_MDIR) -m tinyclj.compiler

MAIN_NS=hello.core
RUN_TESTS_NS=hello.run-tests


# Compile namespace to classes in default destination directory
# /tmp/$(USER)/tinyclj/hello-tcljc/.
compile:
	$(TCLJC) $(RUN_TESTS_NS)

# Loop: Watch for updates to source files, then compile.
watch-and-compile:
	$(TCLJC) --watch $(RUN_TESTS_NS)

# Compile namespace and run parameterless function.  No classes are written.
run:
	$(TCLJC) -d :none $(MAIN_NS)/run

# Loop: Watch for updates to source files, then compile & run.
watch-and-run:
	$(TCLJC) --watch $(MAIN_NS)/run


# Default destination directory of the compiler.
PROJECT_DIR=$(notdir $(PWD))
DEST_DIR=/tmp/$(USER)/tinyclj/$(PROJECT_DIR)

# Run static main method of hello.core using compiled classes.  Uses
# output of "make compile".  Does not load compiler classes.
run-main:
	$(JAVA) -p $(TCLJC_MDIR) --add-modules tinyclj.core -cp $(DEST_DIR) $(MAIN_NS).__ns $(ARGS)



# Run static main method of namespace hello.run-tests using compiled
# classes.  Uses output of "make compile".
test:
	$(JAVA) --enable-preview -p $(TCLJC_MDIR) --add-modules tinyclj.core -cp $(DEST_DIR) $(RUN_TESTS_NS).__ns

# Loop: Watch for updates to source files, then compile & run tests.
watch-and-test:
	$(TCLJC) --watch $(RUN_TESTS_NS)/run


clean:
	rm -rf "$(DEST_DIR)"/*

.PHONY: compile run test clean
