# frozen_string_literal: true

class GemsNamesScraper
  def initialize(params)
    @browser = params[:browser]
    @link = params[:link]
    @email = params[:email]
    @password = params[:password]
    @letter = params[:letter].upcase
    @gems_keeper = "yamls/gems_#{letter}_keeper.yml"
    @pages = params[:pages]
    @result = []
  end

  def visit
    browser.visit link
  end

  def log_in
    browser.find(:css, "a[href='/sign_in']").click
    browser.find(:css, "input[id$='session_who']").set(email)
    browser.find(:css, "input[id$='session_password']").set(password)
    browser.find(:css, "div[class$='form_bottom']").find(:css, "input[class$='form__submit']").click
  end

  def select_gems_by_letter
    browser.find(:css, "a[class$='header__nav-link']", text: 'GEMS').click
    browser.find(:css, "a[href='/gems?letter=#{letter}']").click
  end

  def titles
    pages.times do
      titles = browser.all(:css, "h2[class$='gems__gem__name']").map(&:text)

      titles.each do |title|
        result << title
      end

      pagination_cleaker
    end

    result
  end

  def pagination_cleaker
    browser.first(:xpath, '//a[@rel="next"]').click
  rescue StandardError
    puts 'You have exceeded pages limit.'
    nil
  end

  def write_to_hash(result)
    result.each_with_index do |item, index|
      result[index] = item
    end
  end

  def write_to_yml(gems)
    File.write(gems_keeper, gems.to_yaml)
  end

  private

  attr_reader :browser, :link, :email, :password, :letter, :gems_keeper, :result, :pages
end
