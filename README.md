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

Examples
-----------------------------

## irLessons data examples

Original irLessons data located at http://irfiit.github.com/data/1.html.

- analyze_irlessons_data.rb *(crawl and analyze using Ferret analyzers or custom analyzer)*
- crawl_irlessons_data.rb *(crawl and print crawled pages)*
- extract_irlessons_data.rb *(crawl and extract e-mails)*
- index_irlessons_data.rb *(crawl and index using ferret)*
- search_irlessons_data.rb *(search indexed pages)*
- segmentize_irlessons_data.rb *(replace li and br with dashes and newlines)*

## fiit.stuba.sk examples

Live site at http://www.fiit.stuba.sk/.

- analyze_fiit_stuba_sk.rb
- download_fiit_stuba_sk.rb
- extract_fiit_stuba_sk.rb
- index_fiit_stuba_sk.rb
- search_fiit_stuba_sk.rb

Development
-----------------------------

* Use your own branch. When your feature is finished, merge master into your branch and create a pull request.
* Write commit messages in English. See other commit messages and keep conventions.
* Write comments in English. Comment classes and methods using [RDoc syntax](https://github.com/rdoc/rdoc) (see other comments). Update documentation before committing.

```bash
  $ rdoc
  ```

That's all, good luck :)