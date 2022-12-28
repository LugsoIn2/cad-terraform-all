#!/bin/bash
#input ./script.sh ghtoken customer_nr https_enabled 
if ! command -v gh &> /dev/null
then
    echo "the dependency gh could not be found"
    echo "please install the github cli tool gh"
    exit
fi
# if ! command -v npm &> /dev/null
# then
#     echo "the dependency npm could not be found"
#     echo "please install npm"
#     exit
# fi


GH_TOKEN=$1
CUSTOMER_NR=$2
SERVICENAME=$3
HTTPS_ENABLED=$4


if [ $HTTPS_ENABLED -eq 1 ]; then
    VITE_API_ENVVAR="VITE_API_ENDPOINT=https://$CUSTOMER_NR$SERVICENAME.aws.netpy.de:443"
else
    VITE_API_ENVVAR="VITE_API_ENDPOINT=http://$CUSTOMER_NR$SERVICENAME.aws.netpy.de:80"
fi

mkdir -p tmp_$CUSTOMER_NR\_userservice
cd tmp_$CUSTOMER_NR\_userservice
echo $GH_TOKEN | gh auth login --with-token

# Admin Userservice
gh release download --archive zip --clobber --repo https://github.com/LugsoIn2/cad-event-userservice.git --output cad-event-userservice.zip
unzip -o cad-event-userservice.zip -d ./
cd cad-event-userservice*
npm install
echo $VITE_API_ENVVAR > .env
npm run build
cp -R dist ../
cd ../
rm -rf cad-event-userservice*
#gh auth logout