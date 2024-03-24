# Anki Word Frequency
Add word frequency to your Anki cards, powered by [wordfreq](https://github.com/rspeer/wordfreq).

Frequency value is logarithmically scaled for readability, 
defined [here](https://github.com/rspeer/wordfreq/blob/ce5307748723ddfb47eec26c3ece2eb8216c897a/README.md#usage).

Supported languages listed [here](https://github.com/rspeer/wordfreq/blob/ce5307748723ddfb47eec26c3ece2eb8216c897a/README.md#sources-and-supported-languages).

## Usage
1. Add a new field named "Frequency" (defined in config) to your card type.
1. Select target cards in the browser, they should have a field named "Front" (also configurable).
1. Right click and choose your language under "Word Frequency" tab to update the frequency field.

## Known Issues
- Tested on Windows, should support most variants of Linux and MacOS.
- Some custom tokenizers in the dependencies write logs to *stderr* (e.g. `jieba`), this will get displayed in a error popup window in Anki, but can be safely ignored.