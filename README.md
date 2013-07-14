
doodle.crx a helper tool for doodle
------

### Usage

This is a Chrome extension for [`doodle`][doodle].  
SincAt fisrt `https://` connections blocked foreign scripts, I have to write an extension.  
Now I found using extensions, doodle is better.  

You need to `git clone` and install in developer mode.
[`doodle`][doodle] is required ifor watching file.  
Open `Options` to specify `hosname` (default to `localhost`) and `port` (default to `7776`).  

Also in `Options` you may specify a string as a filter of URLs.  
Just notice that the filter is implemented by `.indexOf`.

[doodle]: https://github.com/jiyinyiyong/doodle

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