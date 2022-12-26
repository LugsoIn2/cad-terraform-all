#!/bin/bash
if ! command -v gh &> /dev/null
then
    echo "the dependency gh could not be found"
    echo "please install the github cli tool gh"
    exit
fi
gh release download --pattern 'userservice*.zip' --clobber --repo https://github.com/LugsoIn2/cad-event-userservice.git
unzip -o userservice.zip -d ./
#gh release download --pattern 'adm_ui_service*.zip' --clobber --repo https://github.com/LugsoIn2/cad-admin-ui-service.git
#unzip -o adm_ui_service.zip -d ./
