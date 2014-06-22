R3ap
====

**R3ap** is a Command-line tool for scraping  websites. Or - to be more precise - it's the result of an attempt to build a Command-line tool for scraping websites. It stores the information (currently the pages' URIs and title) in a SQLite3 database.

## Installation

Go to your terminal and type in the following …

	$ git clone git@github.com:herschel666/r3ap.git
	$ cd r3ap
	$ bundle install

This should do the trick.

## Usage

To scrape a website with **R3ap** type the following into your terminal …

	$ cd path/to/r3ap
	$ ./bin/r3ap parse --db <db name> --source <website URI> --amount <amount of pages to store>

For example:

	$ ./bin/r3ap parse --db nyt --source http://www.nytimes.com --amount 10

This will store 10 pages of the New York Times' website into the database "nyt".

To list the stored pages of a website, enter the following into your terminal:

	$ ./bin/r3ap list --db nyt

This will ouput the contents of the "nyt" database as a useless flat list.

It's also possible to list only the pages of a specific source:

	$ ./bin/r3ap list --db nyt --source http://www.nytimes.com

## Footnote

If you need a CL tool to scrape websites, **R3ap** is the wrong tool!! It's just a personal project I started to learn Ruby. And the only reason it's published to GitHub is, that I want to be able ask the Rubyists among my fellows to review the code.

But if you're into Ruby, too, and you have some time to spare, you're invited to test the tool and review the code. I'm always grateful for getting helpful hints and advices! Thanks in advance for your help!

## License

Copyright 2014 Emanuel Kluge

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.