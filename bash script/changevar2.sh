#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "use: $0 <version dist-yaml>"
  exit 1
fi
version=$1
echo "Dowloadesd version $version from https://raiderartifacts.centralus.raider.devops.rockwell.com/artifactory/raider-npm-dev/ra-ide-dist/-/"
url=https://raiderartifacts.centralus.raider.devops.rockwell.com/artifactory/raider-npm-dev/ra-ide-dist/-/ra-ide-dist-$version.tgz
curl "$url"   'YOUR HEADERS'  --output ./ra-ide-dist-$version.tgz


echo "Unzipping the file ..."
tar -xzf "./ra-ide-dist-$version.tgz" -C .
cp "./package/deployment_modes/qa_env.mode.yaml" . 
cp "./package/deployment_modes/qa_env.mode.yaml.base64" . 
rm -rf "./package/"
filename="./qa_env.mode.yaml" 
echo "Change variables and add info"
sed -e 's/ONLINE_MONITORING: false/ONLINE_MONITORING: true/' -e 's/MOTION: false/MOTION: true/' -e 's/ST_EDITOR: false/ST_EDITOR: true/' $filename > ftdsdci010distmastercd1.yaml
sed -i '/charts\/workspace.yaml/a\    global:' ftdsdci010distmastercd1.yaml
sed -i '/global:/a\      probe: false' ftdsdci010distmastercd1.yaml
awk '{
    if (match($0, /raXservices/)) {
     count++;
     if (count == 2) {
       print;
       print "      env:"
       print "        ACCEPT_NEW_JARS: \"true\"";
       next;
       }
    }
    print;
}' ftdsdci010distmastercd1.yaml > temp && mv temp ftdsdci010distmastercd1.yaml
base64 ftdsdci010distmastercd1.yaml | tr -d '\n' > base64.yaml
sed -i '/^$/d' base64.yaml
echo "Delete old version of r-ide-dist"
find . -type f -name 'ra-ide-dist-*' ! -name ra-ide-dist-$version.tgz -exec rm -f {} +
echo "File that you need to use in pipeline is base64.yaml"