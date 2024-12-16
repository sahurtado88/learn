#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "use: $0 <version dist-yaml>"
  exit 1
fi
version=$1
echo "Dowloadesd version $version from https://raiderartifacts.centralus.raider.devops.rockwell.com/artifactory/raider-npm-dev/ra-ide-dist/-/"
url=https://raiderartifacts.centralus.raider.devops.rockwell.com/artifactory/raider-npm-dev/ra-ide-dist/-/ra-ide-dist-$version.tgz
curl "$url" -H 'authorization: Basic amFuZ2FyaXRhOmdnaGFwY2d0ZnVqbHBSOTc='  --output ./ra-ide-dist-$version.tgz


echo "Unzipping the file ..."
tar -xzf "./ra-ide-dist-$version.tgz" -C .
cp "./package/deployment_modes/qa_env.mode.yaml" . 
cp "./package/deployment_modes/qa_env.tier1.yaml" .
cp "./package/deployment_modes/qa_env.tier2.yaml" .
cp "./package/deployment_modes/qa_env.mode.yaml.base64" . 
cp "./package/deployment_modes/qa_env.tier1.yaml.base64" . 
cp "./package/deployment_modes/qa_env.tier2.yaml.base64" . 
rm -rf "./package/"
filename="./qa_env.mode.yaml" 
echo "Change variables and add info"


tier1="./qa_env.tier1.yaml" 
sed -e 's/USER_ENTITLEMENT: false/USER_ENTITLEMENT: true/' $tier1 > tier1.yaml
base64 tier1.yaml | tr -d '\n' > base64tier1.yaml
sed -i '/^$/d' base64tier1.yaml
tier1="./qa_env.tier2.yaml" 
sed -e 's/USER_ENTITLEMENT: false/USER_ENTITLEMENT: true/' $tier2 > tier2.yaml
base64 tier2.yaml | tr -d '\n' > base64tier2.yaml
sed -i '/^$/d' base64tier2.yaml
filename="./qa_env.mode.yaml" 
sed -e 's/USER_ENTITLEMENT: false/USER_ENTITLEMENT: true/' $filename > qa.yaml
base64 qa.yaml | tr -d '\n' > qa.yaml
sed -i '/^$/d' qa.yaml

echo "File that you need to use in pipeline to upgrade tier1 is base64tier1.yaml"
echo "File that you need to use in pipeline to upgrade tier2 is base64tier2.yaml"
echo "File that you need to use in pipeline to upgrade QA is qa_env.mode.yaml.base64"

echo "Delete old version of r-ide-dist"
find . -type f -name 'ra-ide-dist-*' ! -name ra-ide-dist-$version.tgz -exec rm -f {} +