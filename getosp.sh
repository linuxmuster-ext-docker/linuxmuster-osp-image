#!/bin/bash

wget https://www.openschulportfolio.de/ddl/openschulportfolio_20190207_beta.tgz -O osp_package.zip
tar -xzf osp_package.zip
mv openschulportfolio portfolio
rm osp_package.zip
