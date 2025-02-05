#!/bin/bash
echo run
chmod 777 build.sh
./build.sh
docker login -u nandhini1694 -p dckr_pat_iwWSgQJXmZBj65X-KQqiXNjVFMM
docker tag test nandhini1694/myrepo
docker push nandhini1694/myrepo

