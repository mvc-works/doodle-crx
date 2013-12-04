
Chrome Extension for Doodle
------

Extension for listening message from [Doodle][doodle] command line tool, and refresh a page.

[doodle]: https://github.com/jiyinyiyong/doodle

### Installation

* Via Chrome WebStore, add [doodle-crx][doodle-crx] to Chrome
* Download the lastest code and load the extension manually in developer mode.

[doodle-crx]: https://chrome.google.com/webstore/detail/doodle-crx/ibpfeagjdgnadgiibjhodaampkeldngl

### Usage

Left click the badge toggle `on` and `off`. The connection will be closed after too many fails.
Inspect the 'background page' if you want to see what goes wrong.

Right click the badge to open `Options` and specify:

* `hostname` (default to `localhost`)
* `port` (default to `7776`)
* `filter` (used by `.indexOf` to filter urls, and find the tab to reload)

`https://` connections blocked foreign scripts, so we need an extension. And it's better.

### Techs behind this extension

APIs found by searching StackOverflow(using Google).

http://stackoverflow.com/questions/8342756/chrome-extension-api-for-refreshing-the-page
http://stackoverflow.com/questions/13804213/how-can-i-capture-events-triggered-on-an-extension-icon
http://stackoverflow.com/questions/11996053/detect-a-button-click-in-the-browser-action-form-of-a-google-chrome-extension
https://developer.chrome.com/extensions/browserAction.html
http://stackoverflow.com/questions/15575030/chrome-extension-send-message-from-background-to-content-script
http://stackoverflow.com/a/15281976

### Bugs

Report ar [issues](https://github.com/jiyinyiyong/doodle-crx/issues) :)

### Images

Icons from: http://www.iconfinder.com/search/?q=d

### License

MIT
