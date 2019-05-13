require 'rails_helper'

feature 'User can search based on zipcode' do
  describe 'As a user' do
    it 'returns public electric/propane stations with 15 closest stations' do
      visit "/"

      fill_in ?, '80206'
      click_on 'Locate'

      expect(current_path).to eq('/search')
      expect(current_url).to include('=80206')

      expected_results = 90
      expect(page).to have_content("Total Results: #{expected_results}")

      expect(page).to have_css('.nearest-stations', text: 'Nearest Stations')

      expect(page).to have_css('.nearest-station', count: 15)
    end
  end
end

# As a user
# When I visit "/"
# And I fill in the search form with 80206 (Note: Use the existing search form)
# And I click "Locate"
# Then I should be on page "/search"
# Then I should see the total results of the stations that match my query, 90.
# Then I should see a list of the 15 closest stations within 5 miles sorted by distance
# And the stations should be limited to Electric and Propane
# And the stations should only be public, and not private, planned or temporarily unavailable.
# And for each of the stations I should see Name, Address, Fuel Types, Distance, and Access Times
