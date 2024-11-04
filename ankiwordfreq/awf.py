__all__ = ("main",)
from logging import getLogger
from enum import Enum
from typing import Callable
from functools import partial

from wordfreq import zipf_frequency
from aqt.browser import Browser
from aqt import mw
from aqt.utils import (
    qconnect,
    ensure_editor_saved,
    skip_if_selection_is_empty,
)
from anki.hooks import addHook
from aqt.qt import QAction, QMenu
from anki.utils import pointVersion

logger = getLogger("awf")

# TODO: future-proof
if pointVersion() >= 231000:
    VER_2310 = True
else:
    VER_2310 = False

try:
    import MeCab
    import mecab_ko_dic
    import jieba
    import ipadic
except ImportError as e:
    logger.error(e)
    logger.warning("Not CJK")
    IS_CJK = False
else:
    IS_CJK = True


class Lang(Enum):
    Arabic = "ar"
    Bangla = "bn"
    Bosnian = "bs"
    Bulgarian = "bg"
    Catalan = "ca"
    if IS_CJK:
        Chinese = "zh"
    Croatian = "hr"
    Czech = "cs"
    Danish = "da"
    Dutch = "nl"
    English = "en"
    Finnish = "fi"
    French = "fr"
    German = "de"
    Greek = "el"
    Hebrew = "he"
    Hindi = "hi"
    Hungarian = "hu"
    Icelandic = "is"
    Indonesian = "id"
    Italian = "it"
    if IS_CJK:
        Japanese = "ja"
        Korean = "ko"
    Latvian = "lv"
    Lithuanian = "lt"
    Macedonian = "mk"
    Malay = "ms"
    Norwegian = "nb"
    Persian = "fa"
    Polish = "pl"
    Portuguese = "pt"
    Romanian = "ro"
    Russian = "ru"
    Slovak = "sk"
    Slovenian = "sl"
    Serbian = "sr"
    Spanish = "es"
    Swedish = "sv"
    Tagalog = "fil"
    Tamil = "ta"
    Turkish = "tr"
    Ukrainian = "uk"
    Urdu = "ur"
    Vietnamese = "vi"


@skip_if_selection_is_empty
@ensure_editor_saved
def add_word_freq(browser: Browser, lang_code: str, *_) -> None:
    config = mw.addonManager.getConfig(__name__)
    nids = browser.table.get_selected_note_ids()
    for nid in nids:
        input_field = config["input_field"]
        output_field = config["output_field"]
        note = mw.col.get_note(nid)
        front = note[input_field]
        freq = zipf_frequency(front, lang_code)
        output = (
            config["output_upper_bound"] - freq
            if config["output_is_inverted"] is True
            else freq
        )
        note[output_field] = "{:.2f}".format(output)
        mw.col.update_note(note)

    mw.progress.finish()
    mw.reset()


def make_add_word_freq(browser: Browser, lang_code: str) -> Callable[[], None]:
    func = partial(add_word_freq, browser, lang_code)
    return func


def setup_menu(browser: Browser) -> None:
    config = mw.addonManager.getConfig(__name__)
    listed_langs = [
        lang.lower() for lang in config["listed_languages"]
    ]
    menu_notes = browser.form.menu_Notes
    menu_notes.addSeparator()
    menu_awf = QMenu("Word Frequency", parent=menu_notes)
    menu_awf.setObjectName("menu_awf")

    for lang in Lang:
        if listed_langs and lang.value not in listed_langs:
            continue
        act = QAction(f"Add Frequency ({lang.name})", parent=menu_awf)
        act.setObjectName(f"menu_awf_{lang.name}")
        qconnect(act.triggered, make_add_word_freq(browser, lang.value))
        menu_awf.addAction(act)

    menu_notes.addMenu(menu_awf)


def main():
    addHook("browser.setupMenus", setup_menu)
