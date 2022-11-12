# frozen_string_literal: true

require_relative 'requiries'

data = { browser: Capybara.current_session,
         link: 'https://rubygems.org',
         email: 'gli69824@nezid.com',
         password: 'Secure$password',
         letter: 'z',
         pages: 5 }

scraper = GemsNamesScraper.new(**data)
scraper.visit
scraper.log_in
scraper.select_gems_by_letter
gems = scraper.titles

writer = GemsNamesWriter.new(data[:letter], gems)
hash = writer.to_hash
writer.to_yml(hash)
