require "mechanize"

url = "https://library.osu.edu"

agent = Mechanize.new
page = agent.get(url)

button = page.link_with(id: 'searchBooksLink');
puts button.class

page = button.click

forms = page.forms
searchInput = forms[1];

searchInput.q = "mythology"

pp searchInput

page = agent.submit(searchInput);

pp page
