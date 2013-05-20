function um() {
	local action=$1; project=$2; project_path=~/Development/

	if [[ $action = "dev" ]]; then
	  	echo "Lade Projekt '$project' in den Dev-Bereich...";

	  	cd "$project_path$project";

	  	aacm=$(git add . && git add -u && git commit -m "Automatic push to dev/pre");
	  	pom=$(git push origin master);
	elif [[ $action = "push" ]]; then
	  	echo "Lade Projekt '$project' in den Dev-Bereich und pushe es...";

	  	cd "$project_path$project";

	  	aacm=$(git add . && git add -u && git commit -m "Automatic push to dev/pre and production");
	  	pom=$(git push origin master);
	  	push=$(git-ftp push);
	elif [[ $action = "down" ]]; then
	  	echo "Lade Projekt '$project' lokal herunter...";

	  	cd "$project_path";

	  	clone=$(git clone ssh://um.dev/git/$project.git);
	elif [[ $action = "update" ]]; then
	  	echo "Update Projekt '$project' lokal...";

	  	cd "$project_path$project";

	  	pull=$(git pull origin master);
   elif [[ $action = "update-all" ]]; then
      echo "Update *alle* Projekte lokal...";

      cd "$project_path";

      for project_dir in $project_path*
      do
         echo "Update Projekt '$project_dir' lokal...";

         cd "$project_dir";
         pull=$(git pull origin master);
      done
	else
		echo "Befehl '$action' unbekannt. Bekannte Befehlt: dev, push, down oder update. Zum Beispiel: 'um push umsicht'";
	fi
}