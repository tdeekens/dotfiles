function um() {
  local action=$1; project=$2; option=$3; project_path=$UM_PROJECT_PATH;

  while getopts folder: flag
  do
    case "${flag}" in
      f) folder=${OPTARG};;
    esac
  done

  exit;


}
