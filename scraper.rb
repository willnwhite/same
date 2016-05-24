require 'rubygems'
require 'bundler/setup'

# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'
require "uuidtools"

agent = Mechanize.new

# Read in a page
page = agent.get("http://voixlibres.blogspot.co.uk/2014/02/blog-post_20.html")

# Find the text content of the siblings of a name on the page (using css selectors?)
names = page.at("[text()='- يعقوب المعطي']").parent.parent.children.text.split "\n\n"

names.each do |name|
  # Write out to the sqlite database using scraperwiki library
  ScraperWiki.save_sqlite(["name"],
    {
      "id" => UUIDTools::UUID.random_create.to_s,
      "name" => name
    }, "data")
end

# An arbitrary query against the database
pp ScraperWiki.select("* from data")

# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
