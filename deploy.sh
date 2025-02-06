#!/bin/bash
echo run
chmod 777 build.sh
./build.sh
docker login -u nandhini1694 -p dckr_pat_08XhH0G6oTntx5pCb0hPNQVtQ1k
docker tag test nandhini1694/portfolio
docker push nandhini1694/portfolio

