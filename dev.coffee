
require("calabash").do "doodle crx",
  "coffee -o lib/ -wbc coffee/"
  "jade -o build/ -wP layout/options.jade"