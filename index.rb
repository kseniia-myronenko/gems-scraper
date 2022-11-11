# frozen_string_literal: true

require_relative 'requiries'

data = { browser: Capybara.current_session,
         link: 'https://rubygems.org',
         email: 'gli69824@nezid.com',
         password: 'Secure$password',
         letter: 'z',
         pages: 35 }

scrape = GemsNamesScraper.new(**data)
scrape.visit
scrape.log_in
scrape.select_gems_by_letter
gems = scrape.titles
gems = scrape.write_to_hash(gems)
scrape.write_to_yml(gems)
