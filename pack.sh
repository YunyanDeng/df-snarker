#!/bin/bash

tsc --project tsconfig.json

cd ./build
find -name "df-snarker.zip" -type f -print | xargs rm
find -name "node_modules" -type d -print | xargs rm -rf
cp -r ../node_modules ./

echo "Delete unused files..."
find -name "typescript" -type d -print | xargs rm -rf
find -name "prettier" -type d -print | xargs rm -rf
find -name "test" -type d -print | xargs rm -rf
find -name "doc" -type d -print | xargs rm -rf
find -name "*.ts" -type f -print | xargs rm
find -name "*.md" -type f -print | xargs rm

#we don't need this files now
for i in $(find ./node_modules/@darkforest_eth/snarks/{init,biomebase,reveal}.{zkey,wasm})
do
    > $i
done

if [[ $1 == "aliyun" ]]; then
    echo "Compressing files..."
    mv aliyun.js index.js
    zip -q -r df-snarker.zip index.js src/main.js node_modules
    mv index.js aliyun.js
fi

# if [[ $1 == "qcloud" ]]; then
#     echo "Compressing files..."
#     mv qcloud.js index.js
#     cp ../scf_bootstrap ./
#     zip -q -r snarker.zip index.js main.js scf_bootstrap node_modules
# fi

rm -r node_modules