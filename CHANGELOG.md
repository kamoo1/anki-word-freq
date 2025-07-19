# CHANGELOG


## v0.3.5 (2025-07-19)

### Bug Fixes

- Unescape html
  ([`0259374`](https://github.com/kamoo1/anki-word-freq/commit/0259374b6b2ab541df745ffbcdb51a1d021185e6))

some cards in premade decks have trailing html-encoded non-breaking whitespaces (`&nbsp;`). we
  should unscape them so wordfreq can strip them.


## v0.3.4 (2025-05-16)

### Bug Fixes

- Bump minor version for ci test
  ([`92c7b97`](https://github.com/kamoo1/anki-word-freq/commit/92c7b971fa05eab41227308369add8113f93ade5))


## v0.3.3 (2025-05-14)

### Bug Fixes

- Output_field existence check
  ([`073efbf`](https://github.com/kamoo1/anki-word-freq/commit/073efbf0035ec8313a50b4c1b0da6a3207ce3fbc))


## v0.3.2 (2025-05-13)

### Bug Fixes

- Bump minor version for ci test
  ([`6dfb7eb`](https://github.com/kamoo1/anki-word-freq/commit/6dfb7eb0c019ff7eb5b48fe8c0272930d30e8b16))

### Documentation

- Update readme
  ([`8c742b2`](https://github.com/kamoo1/anki-word-freq/commit/8c742b24d8fb56041dffbcd10bac9bd09b7cac5c))


## v0.3.1 (2025-05-12)

### Bug Fixes

- Skip if field not found
  ([`ef78580`](https://github.com/kamoo1/anki-word-freq/commit/ef78580aff8690dd60d1eba5771010a2b3fbea96))

### Documentation

- Update readme
  ([`a6cd877`](https://github.com/kamoo1/anki-word-freq/commit/a6cd87751296582487a840b2c6728996c025ff3e))


## v0.3.0 (2025-05-10)

### Features

- Support for multiple field pairs
  ([`d52d614`](https://github.com/kamoo1/anki-word-freq/commit/d52d61437306efc697a8a0331b7ed200e7250625))

Refs #7


## v0.2.0 (2024-11-04)

### Features

- New features
  ([`4b1f82b`](https://github.com/kamoo1/anki-word-freq/commit/4b1f82bfebb4329eda3103b921a4493d98b4a88b))


## v0.1.3 (2024-03-26)


## v0.1.2 (2024-03-25)

### Bug Fixes

- Add manifest for manual install
  ([`62d2f9a`](https://github.com/kamoo1/anki-word-freq/commit/62d2f9a30b2e60f5b7e95ef21ed77f73bd9958c3))

- Fix ci build
  ([`75cde26`](https://github.com/kamoo1/anki-word-freq/commit/75cde265787fb0670b08cba8a81b5cbaa355a8cd))

remake build scripts, fix missing windows dll issue in linux. that's too much dependency hell for a
  day OTZ

- Hide cjk when dependencies don't meet
  ([`4169579`](https://github.com/kamoo1/anki-word-freq/commit/41695794231b8c671571131b1de8beafe4d6c528))

### Documentation

- Add recording
  ([`6b06ce7`](https://github.com/kamoo1/anki-word-freq/commit/6b06ce77000a3a30041e45fa7c550523031db481))

- Update readme
  ([`4ef323e`](https://github.com/kamoo1/anki-word-freq/commit/4ef323e8437565f6c8e401aa0189fad6ba3b5818))


## v0.1.1 (2024-03-25)

### Bug Fixes

- Ci version increment in python file
  ([`446132c`](https://github.com/kamoo1/anki-word-freq/commit/446132c77b2282fda4c5e05180745978e2a64214))


## v0.1.0 (2024-03-25)

### Features

- Init repo
  ([`6233988`](https://github.com/kamoo1/anki-word-freq/commit/623398846c4128fb0534bb5bca7361f6bd3cd7e2))
