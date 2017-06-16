# A one stop shop for hacking OpenJdk 1.9 with Intellij IDE
<sub>*for bash shell only</sub>

Generates XML module and dependency configuration files for Intellij to set up all of the core ~68 modules set to be released with java 9. Three steps to get started:

1. Pull the latest source from the OpenJdk Mercurial repositories and run the get_source script:
```
    hg clone http://hg.openjdk.java.net/jdk9/jdk9 $PROJECT_ROOT
    cd $PROJECT_ROOT
    chmod +x ./get_source.sh && ./get_source.sh
```
2. From `$PROJECT_ROOT` download this main script (example uses curl but you can also clone the repo) and run:
```
    curl https://raw.githubusercontent.com/prestongarno/jdk-9-scripts/master/intellij-config.sh > ./intellij-config.sh
    chmod +x intellij-config.sh && ./intellij-config.sh
```
3) Run `chmod +x intellij-config-modules.sh && ./intellij-config-modules.sh`

Just open Intellij and select "Open project" and then select the project root and wait for it to index. Afterwards your project-view will look like this:

![Imgur](http://i.imgur.com/O3oseeT.png)

### More resources / Further reading:

* [Obuildfactory - a git repository for easy JDK builds complete with docker integration](https://github.com/hgomez/obuildfactory)
* [Adopt OpenJdk - get involved](https://github.com/AdoptOpenJDK)
* [How to contribute to the OpenJdk](http://openjdk.java.net/contribute/)
* [Overview of the repositories](http://openjdk.java.net/guide/repositories.html)
