# frozen_string_literal: true

require './gems_names_scraper'

RSpec.describe GemsNamesScraper, js: true, type: :feauture do
  let(:data) do
    { browser: Capybara.current_session,
      link: 'https://rubygems.org',
      email: 'gli69824@nezid.com',
      password: 'Secure$password',
      letter: 'b',
      pages: 3 }
  end

  let(:per_page) { 30 }
  let(:object) { described_class.new(**data) }

  describe '#visit' do
    before { object.visit }

    it 'visits the right page' do
      expect(page).to have_css('h1', text: 'Find, install, and publish RubyGems.')
    end
  end

  describe '#log_in' do
    before do
      object.visit
      object.log_in
    end

    it 'shows content of the personal account' do
      expect(page).to have_css('.t-body',
                               text: "You're not subscribed to any gems yet. Visit a gem page to subscribe to one!")
    end

    it 'shows personal username in menu' do
      expect(page).to have_css('span', text: 'DAYZ911')
    end
  end

  describe '#select_gems_by_letter' do
    before do
      object.visit
      object.select_gems_by_letter
    end

    it 'shows gems that begin with right letter' do
      page.all('h2.gems__gem__name').each do |item|
        expect(item.text).to match(/^[bB]/)
      end
    end

    it 'expect gems with wrong letters not to be present' do
      page.all('h2.gems__gem__name').each do |item|
        expect(item.text).not_to match(/^[aA]/)
      end
    end
  end

  describe '#titles' do
    let(:array) { object.titles }

    before do
      object.visit
      object.select_gems_by_letter
    end

    it 'expects to return array with certain items' do
      expect(array.size).to eq(data[:pages] * per_page)
    end

    it 'expects to return items with letter-b gems' do
      array.map { |item| expect(item).to match(/^[bB]/) }
    end
  end

  describe '#pagination_cleaker' do
    before do
      object.visit
      object.select_gems_by_letter
      object.pagination_cleaker
    end

    it 'renders the right URL' do
      expect(page.current_url).to end_with('/gems?letter=B&page=2')
    end

    it 'renders the right gems on paginated page' do
      page.all('h2.gems__gem__name').each do |item|
        expect(item.text).to match(/^[bB]/)
      end
    end
  end
end
