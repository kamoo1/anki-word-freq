# Anki Word Frequency

Add word frequency to your Anki cards, powered by [wordfreq](https://github.com/rspeer/wordfreq).

Frequency value is logarithmically scaled for readability, 
defined [here](https://github.com/rspeer/wordfreq/blob/ce5307748723ddfb47eec26c3ece2eb8216c897a/README.md#usage).

Supported languages listed [here](https://github.com/rspeer/wordfreq/blob/ce5307748723ddfb47eec26c3ece2eb8216c897a/README.md#sources-and-supported-languages).

![recording](assets/recording.gif)

## Usage
1. Add a new field named "Frequency" (defined in config) to your card type.
1. Select target cards in the browser, they should have a field named "Front" (also configurable).
1. Right click and choose your language under "Word Frequency" tab to update the frequency field.

## Config
| Field | Description |
| --- | --- |
| `input_field` | The name of the field containing the text to be analyzed. |
| `output_field` | The name of the field to be updated with the word frequency. |
| `output_is_inverted` | Whether the frequency should be inverted, i.e. {output_upper_bound} - {frequency}. |
| `output_upper_bound` | The maximum frequency value, anything above 8 is safe. |
| `listed_languages` | A list of [language codes](https://github.com/rspeer/wordfreq/blob/ce5307748723ddfb47eec26c3ece2eb8216c897a/README.md#sources-and-supported-languages) you want to display in Anki Word Frequency menu, e.g. `["en", "zh", "de"]`. An empty list will display all available options. |

## Known Issues
- For Chinese Japanese and Korean (CJK) support, you can find a CJK version in [GitHub releases](https://github.com/kamoo1/anki-word-freq/releases). It's too large for AnkiWeb.
- Tested on Windows and Linux, should be compatible with macOS.
- Some custom tokenizers in the dependencies write logs to *stderr* (e.g. `jieba`), this will get displayed in a error popup window in Anki, but can be safely ignored.