echo "Load variables from config.sh"
source ./config.sh

old=$1
latest=$2

# if version parameter is not provided, exit with erro 2
if [[ $old -eq 0 || $latest -eq 0 ]]
  then
    echo "--------------------------------"
    echo "old version or latest is null "
    echo "You must supply two versions: "
    echo "--> old version to be repalced"
    echo "--> latest version to be updated"
    echo
    echo "program will abort with error 2 in here"
    exit 2
fi

echo "--------------------------------"
echo " Updating Custom Image Version in json templates"
echo "--------------------------------"
echo


for json in "${json_list[@]}"
do
    echo "updating --> $json"
    echo "updating previous version: $old to latest: $latest"
    sed -i -e "s/-v$old/-v$latest/g" ./DevTestLab/$json
done

