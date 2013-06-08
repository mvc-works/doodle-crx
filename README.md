
doodle.crx a helper tool for doodle
------

### Usage

This is a Chrome extension for [`doodle`][doodle].  
Since `https://` connections blocked foreign scripts, I have to hack.  

APIs found by searching StackOverflow(using Google).

http://stackoverflow.com/questions/8342756/chrome-extension-api-for-refreshing-the-page
http://stackoverflow.com/questions/13804213/how-can-i-capture-events-triggered-on-an-extension-icon
http://stackoverflow.com/questions/11996053/detect-a-button-click-in-the-browser-action-form-of-a-google-chrome-extension
https://developer.chrome.com/extensions/browserAction.html
http://stackoverflow.com/questions/15575030/chrome-extension-send-message-from-background-to-content-script

[doodle]: https://github.com/jiyinyiyong/doodle

Install it in developer mode. And use it togather with [`doodle`][doodle].  
Open `Options` to specify `hosname` (default to `localhost`) and `port` (default to `7776`).  

Also in `Options` you may specify a string as a filter of URLs.  
Just notice that the filter is implemented by `.indexOf`.

By now it's quite rough. You may fork to help.

### Bugs

After changing options, this extension may break. Dont't know why it happens yet.

### Images

Icons from: http://www.iconfinder.com/search/?q=d

### License

MIT