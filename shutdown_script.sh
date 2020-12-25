#!/bin/bash
# run:
# sudo cp ./shutdown_script.sh /etc/rc6.d/K99git_push_repo

repos_to_push=("~/Desktop/Notes")

for each_repo in "${repos_to_push[@]}"
do
    cd $each_repo
    git checkout master
    git add .
    git commit -m "yes"
    git push
done
