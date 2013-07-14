
require("calabash").do "doodle crx",
  'pkill -f doodle'
  "coffee -o lib/ -wbcm coffee/"
  "jade -o build/ -wP layout/options.jade"
  'doodle build/ lib/ log:yes'