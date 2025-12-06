#!/bin/bash
firstline=$(head -n 1 source/changelog.md)
read -a splitfirstline <<< $firstline
version=${splitfirstline[1]}

echo "Do your want to start the script 
'1' for yes
'2' for no"
read versioncontinue
if [ $versioncontinue -eq 1 ]
then
  echo "To execute the rest of out script respond 'OK'"
  read continueQuestion
  if [ "$continueQuestion" == "OK" ]
  then
    echo "     The copy script      "
    echo "---- source directory ----"
    echo "Version:" $version
    for file in source/*; 
    do
      if [ "$file" != "source/secretinfo.md" ];
      then
        cp -r "$file" build/
        echo "$file is being copied"
      else
        sed 's/42/XX/g' source/secretinfo.md > build/secretinfo.md
        echo "source/secretinfo.md is being copied (with replacements)"
      fi
    done
    cd build/
    echo "Build version $version contains:"
    ls
    cd ..
  else
    echo "Please come back when you are ready"
  fi
else
  echo "Exiting..."
  exit
fi
