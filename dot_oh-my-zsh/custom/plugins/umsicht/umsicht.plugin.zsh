function um() {
  local action=$1; project=$2; option=$3; project_path=$UM_PROJECT_PATH; local_server=$UM_LOCAL_SERVER

  if [[ $action = "dev" ]]; then
     echo "Uploading project: '$project' into development area.";

     cd "$project_path$project";

     if [ -n "$option" ]; then
       echo "Only changes in folder: $option will be uploaded."
       aacm=$(git add $option && git commit -m "Automatic push to dev");
     else
       aacm=$(git add --all && git commit -m "Automatic push to dev");
     fi

     pom=$(git push origin master);
  elif [[ $action = "push" ]]; then
     echo "Uploading project: '$project' into development area and pushing it live.";

     cd "$project_path$project";

     aacm=$(git add --all && git commit -m "Automatic push to dev and production");
     pom=$(git push origin master);
     push=$(git-ftp push);
  elif [[ $action = "down" ]]; then
     echo "Downloading project: '$project' locally.";

     cd "$project_path";

     clone=$(git clone ssh://um.dev/git/"$project".git);

     open_browser=$(open "$local_server/$project");
     open_editor=$($EDITOR .);
  elif [[ $action = "update" ]]; then
     echo "Updating project: '$project' locally.";

     cd "$project_path$project";

     pull=$(git pull origin);

     open_browser=$(open "$local_server/$project");
     open_editor=$($EDITOR .);
  elif [[ $action = "init" ]]; then
     echo "Initializing project: '$project' on live server.";

     sshScript=$(ssh um.dev 'sh /www/htdocs/v080275/scripts/stage-project.sh' "$project" dev);

     cd "$project_path$project";

     aacm=$(git add --all && git commit -m "Automatic init to dev and production");
     pom=$(git push origin master);
     push=$(git-ftp init);
  elif [[ $action = "new" ]]; then
     echo "Creaing new project with name: '$project' and downloading it.";

     sshScript=$(ssh um.dev 'sh /www/htdocs/v080275/scripts/bootstrap-project.sh' "$project");

     cd "$project_path";

     clone=$(git clone ssh://um.dev/git/"$project".git);

     open_editor=$($EDITOR "$project");
  elif [[ $action = "config" ]]; then
     cd "$project_path$project";

     config=$(git config git-ftp.user "$3" && git config git-ftp.password "$4" && git config git-ftp.url "$5");

     echo "Config for $2 set with username: $3, password: $4 und url: $5\nInitialize project with: um init $2";
  elif [[ $action = "update-all" ]]; then
     echo "Updating *all* local projects.";

     cd "$project_path";

     for project_dir in $project_path*
     do
        echo "Updating project '$project_dir' locally.";

        cd "$project_dir";
        pull=$(git pull origin master);
     done
  elif [[ $action = "work" ]]; then
     echo "Setting up project '$project' to work on '$option' version.";

     cd "$project_path$project";

     fa=$(git pull --all);

     if ([ "$option" = "pre" ] || [ "$option" = "preview" ]); then
        co=$(git checkout preview);
     else
        co=$(git checkout master);
     fi

     open_browser=$(open "$local_server/$project");
     open_editor=$($EDITOR .);
  elif [[ $action = "reset" ]]; then
     echo "Removing and resetting '$project'!";

     rm -rf "$project_path$project";

     cd "$project_path";

     clone=$(git clone ssh://um.dev/git/"$project".git);
  elif [[ $action = "revert" ]]; then
     echo "Reverting last made changes on: '$project'!";

     cd "$project_path$project";

     checkout=$(git checkout -f);
  elif [[ $action = "browse" ]]; then
     open "$local_server/$project";
  elif [[ $action = "status" ]]; then
     cd "$project_path$project";
     echo "============= Last changes in dev =============="
     echo "# Change from: "
     git rev-list --format=format:'%cn %ci' --max-count=1 $(git rev-parse origin/HEAD)
     echo "\n"
     echo "# Changed files: "
     git show --no-pager --stat --oneline origin/HEAD
     echo "\n"
     SHA=$(curl --user $(git config git-ftp.user):$(git config git-ftp.password) -s ftp://$(git config git-ftp.url)/.git-ftp.log)
     echo "============= Last changes on production =============="
     echo "# Change from: "
     git rev-list --format=format:'%cn %ci' --max-count=1 $(git rev-parse "$SHA")
     echo "\n"
     echo "# Changed files: "
     git show --no-pager --stat --oneline "$SHA"
  else
     echo "Command '$action' unknown. Known commands e.g.: dev, push, down oder update. E.g.: 'um push umsicht'";
  fi
}
