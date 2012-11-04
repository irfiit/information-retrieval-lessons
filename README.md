Information Retrieval Lessons
=============================

This repository contains example crawler, indexer, analyzer, extractor and other stuff related to [Information Retrieval classes](http://vi.ikt.ui.sav.sk/) at [FIIT STU BA](http://www.fiit.stuba.sk).

Installation
------------------------------

1. Install Ruby using RVM (doesn't require root user).

  https://rvm.io/rvm/install/

2. Install Bundler.

  ```bash
  $ gem install bundler
  ```

3. Clone repository.

  ```bash
  $ git clone git@github.com:irfiit/information-retrieval-lessons.git
  ```

4. Run Bundler to install dependencies.

  ```bash
  $ cd information-retrieval-lessons/
  $ bundle
  ```

5. Try examples.

   ```bash
  $ ruby examples/index_fiit_stuba_sk.rb
  $ ruby examples/search_fiit_stuba_sk.rb
  ```

Development
-----------------------------

* Use your own branch. When your feature is finished, merge master into your branch and create a pull request.
* Write commit messages in English. See other commit messages and keep conventions.
* Write comments in English. Comment classes and methods using RDoc syntax. 

That's all, good luck :)