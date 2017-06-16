#!/bin/bash
  
function create_configs() {
  if [ -d $1 ]; then
    for D in $(find $1 -maxdepth 2 -type d -name src); do
      echo "Configuring forest " + $D
      forest_config $D
    done
  else
    usage
  fi
}

function forest_config() {
  for d in $1/* ; do
    if [[ "$d" == ?*.?* ]] && [ -d "$d/share/classes" ]; then
      s=$(printf "%-20s" "=")
      echo "${s// /=}"
      echo -- "`basename $d`  ||"
      echo "${s// /=}"
      MODULE_DIR=$d
      MODULE_NAME=`basename $d`
      MODULE_RELATIVE_PATH=${MODULE_DIR#$JDK_ROOT}
      make_config $d/`basename $d`.iml
    #elif [ "$d" = "linux" ] | [ "$d" = "macosx" ] | [ "$d" = "solaris" ]; then
    fi
  done
}

function make_config() {
  add_module_to_projconfig
  echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $1
  echo "  <module type=\"JAVA_MODULE\" version=\"4\">" >> $1
  echo "  <component name=\"NewModuleRootManager\" inherit-compiler-output=\"false\">" >> $1
  echo "    <output url=\"$JDK_ROOT/build/linux-x86_64-normal-server-release/jdk/modules/$MODULE_NAME\" />" >> $1
  echo "    <output-test url=\"$JDK_ROOT/out/test/$MODULE_NAME\" />" >> $1
  if [ $MODULE_DIR != $JDK_ROOT/.idea/ ]; then
    add_sources_root $1
    configure_dependencies "$MODULE_DIR/share/classes/module-info.java"
    if [[ $MODULE_NAME != "jdk.base" ]]; then
        echo "    <orderEntry type=\"module\" module-name=\"java.base\" />" >> "$MODULE_DIR/$MODULE_NAME.iml"
    fi
  fi
  echo "    <orderEntry type=\"inheritedJdk\" />" >> $1
  echo "    <orderEntry type=\"sourceFolder\" />" >> $1
  echo "  </component>" >> $1
  echo "</module>" >> $1
}

function add_sources_root() {
  echo "    <exclude-output />" >> $1
  echo "      <content url=\"\$MODULE_DIR\$\">" >> $1
  echo "        <sourceFolder url=\"file://\$MODULE_DIR\$/share/classes/\" isTestSource=\"false\" />" >> $1
  echo "      </content>" >> $1
  echo "    <content url=\"file://\$MODULE_DIR\$/share/classes\" />" >> $1
}

function configure_dependencies() {
  echo Configuring dependencies...
  TRIGGER=""
  while IFS= read -r line
  do
    local trimmed=`echo -n ${line//[[:space:]]/}`
    if [[ $trimmed ==  "module$MODULE_NAME{" ]]; then
      TRIGGER="found"
    elif [[ $TRIGGER != "" ]] && [[ $trimmed == "requirestransitive"* || $trimmed == "requires"* ]]; then
      #echo $trimmed
      local dependency=$(echo $trimmed | sed 's:\(requirestransitive\|requires\)\(.*\);:\2:g')
      echo "    <orderEntry type=\"module\" module-name=\"$dependency\" />" >> "$MODULE_DIR/$MODULE_NAME.iml"
	    printf '\t%s\n' "::  $dependency"
    fi
  done <"$1"
}

function add_module_to_projconfig() {
  # each module appends one of these to project config
  echo "      <module fileurl=\"file://\$PROJECT_DIR\$$MODULE_RELATIVE_PATH/$MODULE_NAME.iml\" filepath=\"\$PROJECT_DIR\$$MODULE_RELATIVE_PATH/$MODULE_NAME.iml\" />" >> $MODULE_LIST

}

function init_project_root() {
  # initialize module.xml file
  echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $IDEA_CONFIG_DIR/modules.xml
  MODULE_LIST=$IDEA_CONFIG_DIR/modules.xml
  echo "<project version=\"4\">" >> $MODULE_LIST
  echo "  <component name=\"ProjectModuleManager\">" >> $MODULE_LIST
  echo "    <modules>" >> $MODULE_LIST
}

function complete_module_list() {
  # Append this part after registering all modules to complete .idea/modules.xml
  echo "    </modules>" >> $MODULE_LIST
  echo "  </component>" >> $MODULE_LIST
  echo "</project>" >> $MODULE_LIST
}


function usage() {
  printf "%s\t%s\n" "--Scipt arguments:"  "./intellij-configure.sh \$PATH_TO_JDK_SOURCE_ROOT"
  echo "exiting..."
  exit 1
}

s=$(printf "%-30s" "=")
echo "${s// /=}"
printf "%s\n" "Starting Intellij OpenJDK project configuration..."
echo "${s// /=}"
printf "%s\n" "checking for mercurial repository..."


if [ $# -eq 0 ] && [ -a $PWD"/get_source.sh" ]; then
  JDK_ROOT=${PWD}
  echo Found project root at $JDK_ROOT
  if [ ! -d ${PWD}/.idea ]; then
    echo initializing root project folder $IDEA_CONFIG_DIR...
    mkdir .idea
  fi
  IDEA_CONFIG_DIR=${PWD}/.idea
  $MODULE_DIR="$IDEA_CONFIG_DIR"
  $MODULE_NAME=`basename $PROJECT_DIR`
  echo initialized project config at $IDEA_CONFIG_DIR/$MODULE_NAME.iml
  init_project_root
  create_configs $JDK_ROOT
  complete_module_list
  echo "${s// /=}"
  printf "%s\n" "OpenJDK configuration complete!"
  echo "${s// /=}"
  echo NOTE: Module jdk.jshell requires tools.jar and rt.jar from Java 1.8
  printf '\t%s\n' 'tools.jar is located at $JAVA8_HOME/lib/tools.jar'
  printf '\t%s\n' 'tools.jar is located in $JAVA8_HOME/jre/lib/rt.jar'
  printf '\t%s\n' '--Go to File->Module Settings->Select jdk.jshell->Green + butoon->Add Jar dependency to resolve'
  exit
else
  printf '\n%s\n' "Error: Run this in a OpenJDK repository root" 
  usage 
fi 

