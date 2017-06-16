# A one stop shop for hacking OpenJdk 1.9 with Intellij IDE
<sub>*for bash shell only</sub>

This script configures module and dependency configuration files for Intellij to set up all of the core ~68 modules set to be released with java 9 (based on Project Jigsaw, the Java 9 module system). Three steps to get started with a pretty neat JDK - complete with an experimental AOT compiler, embedded JavaScript, the JShell REPL and more! 

Follow these simple steps to get the entire OpenJdk 9 codebase configured for Intellij:

1. Pull the latest source from the OpenJdk Mercurial repositories and run the get_source script:
```
    hg clone http://hg.openjdk.java.net/jdk9/jdk9 $PROJECT_ROOT
    cd YourOpenJDK
    chmod +x ./get_source.sh && ./get_source.sh
```
2. From `$PROJECT_ROOT` download this main script (example uses curl but you can also clone the repo) and run:
```
    curl https://raw.githubusercontent.com/prestongarno/jdk-9-scripts/master/intellij-config.sh > ./intellij-config.sh
    chmod +x intellij-config.sh && ./intellij-config.sh
```
3. Open `$PROJECT_ROOT` in Intellij and index. You should now see all 68 Java 9 modules listed in project view.  

    

Remember to add `rt.jar` and `tools.jar` to the `jdk.jshell` module dependencies *NOT* the project classpath.  To Intellij, this can be a standalone project without any Java 8 dependencies as `jdk.base` (core java libraries module) may cause some conflicts in static analysis to the IDE

Just open Intellij and select "Open project" and then select the project root and wait for it to index. 

NOTE: Use the dedicated build system for images and unit/integration tests. This script is only to help take advantage of Intellij's code editing/refactoring tools.

### More resources / Further reading:

* [Obuildfactory - a git repository for easy JDK builds complete with docker integration](https://github.com/hgomez/obuildfactory)
* [Adopt OpenJdk - get involved](https://github.com/AdoptOpenJDK)
* [How to contribute to the OpenJdk](http://openjdk.java.net/contribute/)
* [Overview of the repositories](http://openjdk.java.net/guide/repositories.html)
