#!/bin/sh

cd "$(dirname "$0")"

rm -f ./build/*
mkdir -p ./.work

echo 'build all symbols fonts...'
cp ./fonts/pomicons-regular.ttf ./build
cp ./fonts/fontawesome-regular.ttf ./build
cp ./fonts/devicons-regular.ttf ./build

./scripts/fu-relocate ./fonts/octicons-regular.ttf --save-as='.work/octicons-regular-relocated.ttf' --to='0xf200' 2> /dev/null
cp ./.work/octicons-regular-relocated.ttf ./build/octicons-regular.ttf


echo 'export maps for all fonts...'
./scripts/fu-map ./build/pomicons-regular.ttf --namespace 'POMICONS' 2> /dev/null > ./build/pomicons-regular.sh
./scripts/fu-map ./build/octicons-regular.ttf --namespace 'OCTICONS' 2> /dev/null > ./build/octicons-regular.sh
./scripts/fu-map ./build/fontawesome-regular.ttf --namespace 'AWESOME' 2> /dev/null > ./build/fontawesome-regular.sh
./scripts/fu-map ./build/devicons-regular.ttf --namespace 'DEVICONS' 2> /dev/null > ./build/devicons-regular.sh

for file in ./fonts/*.sh; do
  cat $file >> ./build/`basename $file`
done

echo 'you can find fonts and maps in local ./build directory :-)'
echo 'done!'
