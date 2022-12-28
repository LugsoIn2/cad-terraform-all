#!/bin/bash
#input ./script.sh ghtoken customer_nr servicename https_enabled 
if ! command -v gh &> /dev/null
then
    echo "the dependency gh could not be found"
    echo "please install the github cli tool gh"
    exit
fi
if ! command -v npm &> /dev/null
then
    echo "the dependency npm could not be found"
    echo "please install npm"
    exit
fi


GH_TOKEN=$1
CUSTOMER_NR=$2
SERVICENAME=$3
HTTPS_ENABLED=$4


if [ $HTTPS_ENABLED -eq 1 ]; then
    VITE_API_ENVVAR="VITE_API_ENDPOINT=https://$CUSTOMER_NR$SERVICENAME.aws.netpy:443"
else
    VITE_API_ENVVAR="VITE_API_ENDPOINT=http://$CUSTOMER_NR$SERVICENAME.aws.netpy:80"
fi

mkdir -p tmp_$CUSTOMER_NR\_admin_ui
cd tmp_$CUSTOMER_NR\_admin_ui
#echo $GH_TOKEN | gh auth login --with-token

# Admin UI Service
gh release download --archive zip --clobber --repo https://github.com/LugsoIn2/cad-admin-ui-service.git --output cad-admin-ui-service.zip
unzip -o cad-admin-ui-service.zip -d ./
cd cad-admin-ui-service*
npm install
echo $VITE_API_ENVVAR > .env
npm run build --if-present
cp -R dist ../
cd ../
rm -rf cad-admin-ui-service*

#gh auth logout