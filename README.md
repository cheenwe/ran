# README

DB: pg

Cache: redis

## usage

```shell
git clone xxxx imerp
cd imerp
bin/setup
```


## install

cnpm

>alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"

# Or alias it in .bashrc or .zshrc
>echo '\n#alias for cnpm\nalias cnpm="npm --registry=https://registry.npm.taobao.org \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npm.taobao.org/dist \
  --userconfig=$HOME/.cnpmrc"' >> ~/.zshrc && source ~/.zshrc





brew install yarn

cnpm install yarn -g

yarn config set registry https://registry.npm.taobao.org

npm install --save  angular angular-cookies angular-route  restangular  underscore simple-line-icons


## yarn

yarn install

yarn add [package]

yarn install --force


yarn remove [package]

yarn cache clean

yarn upgrade



## update npm
curl -0 -L http://npmjs.org/install.sh | sudo sh



npm install --force
