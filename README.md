#One stop shop for hacking OpenJdk 1.9 with Intellij IDE

Generates XML module and dependency configuration files for Intellij to set up all of the core ~68 modules set to be released with java 9. Three steps to get started with a pretty neat JDK - complete with an experimental AOT compiler, embedded JavaScript, the JShell REPL and more! 

1) Pull the latest source from the OpenJdk Mercurial repositories and run ./get_source in the project root

2) From the OpenJdk 9 root run "curl https://github.com/prestongarno/jdk-9-scripts/intellij-config-modules.sh > ./intellij-config-modules.sh"

3) Run `chmod +x intellij-config-modules.sh && ./intellij-config-modules.sh` and wait for it to complete

Just open Intellij and select "Open project" and then select the project root and wait for it to index. 
NOTE: Use the dedicated build system for images and unit/integration tests. This is only to help take advantage of Intellij's code editing/refactoring tools
