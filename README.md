##One stop shop for hacking OpenJdk 1.9 with Intellij IDE


Generates XML module and dependency configuration files for Intellij to set up all of the core ~68 modules set to be released with java 9. Three steps to get started:

1) Pull the latest source from the OpenJdk Mercurial repositories and run ./get_source in the project root

2) From the OpenJdk 9 root run `curl https://raw.githubusercontent.com/prestongarno/jdk-9-scripts/master/intellij-config-modules.sh > ./intellij-config-modules.sh`

3) Run `chmod +x intellij-config-modules.sh && ./intellij-config-modules.sh`

Just open Intellij and select "Open project" and then select the project root and wait for it to index. Afterwards your project-view will look like this:

![Imgur](http://i.imgur.com/O3oseeT.png)

NOTE: Use the dedicated build system for images and unit/integration tests. This is only to help take advantage of Intellij's code editing/refactoring tools
