# Anki Word Frequency

Add word frequency to your Anki cards, powered by [wordfreq](https://github.com/rspeer/wordfreq).

Frequency value is logarithmically scaled for readability, 
defined [here](https://github.com/rspeer/wordfreq/blob/ce5307748723ddfb47eec26c3ece2eb8216c897a/README.md#usage).

Supported languages listed [here](https://github.com/rspeer/wordfreq/blob/ce5307748723ddfb47eec26c3ece2eb8216c897a/README.md#sources-and-supported-languages).

![recording](assets/recording.gif)

## Usage
1. Update your card type to include both the input and output fields defined in your config. For example, if you're studying English verb forms and your config looks like this:
    ```
    "fields": {
        "Front": "Base Frequency",
        "Past Tense": "Past Frequency",
        "Past Participle": "Participle Frequency"
    }
    ```
    then your card should have fields named `Front`, `Past Tense`, `Past Participle`, and matching output fields like `Base Frequency`, `Past Frequency`, and `Participle Frequency`.

1. In the Anki browser, select the cards you want to update, right-click and choose your desired language from the "Word Frequency" menu. The add-on will analyze each input field and update the corresponding output field with a frequency score.

## Config
| Field | Description |
| --- | --- |
| `fields` | A dictionary mapping input fields (to analyze) to output fields (to store frequency). Example: `{"Front": "Frequency"}`. |
| `output_is_inverted` | Whether the frequency should be inverted, i.e. {output_upper_bound} - {frequency}. |
| `output_upper_bound` | The maximum frequency value, anything above 8 is safe. |
| `listed_languages` | A list of [language codes](https://github.com/rspeer/wordfreq/blob/ce5307748723ddfb47eec26c3ece2eb8216c897a/README.md#sources-and-supported-languages) you want to display in Anki Word Frequency menu, e.g. `["en", "zh", "de"]`. An empty list will display all available options. |

## Known Issues
- For Chinese Japanese and Korean (CJK) support, you can find a CJK version in [GitHub releases](https://github.com/kamoo1/anki-word-freq/releases). It's too large for AnkiWeb.
- Some Linux distributions use newer versions of Python, you can find these builds (ranges from Python3.9 to 3.13) in [GitHub releases](https://github.com/kamoo1/anki-word-freq/releases), you can look up your Python version in Anki by going to `Help` > `About`.
- Some custom tokenizers in the dependencies write logs to *stderr* (e.g. `jieba`), this will get displayed in a error popup window in Anki, but can be safely ignored.