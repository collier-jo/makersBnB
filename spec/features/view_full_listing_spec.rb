feature 'Viewing the full listing' do 
    scenario 'User clicks view button' do
      listing = Listing.create(name: "House of Horrors", description: "A very scary house", price: "69.85")

      visit '/'

      expect(page).to have_content "House of Horrors A very scary house 69.85"

      first('.listing').click_button 'View'

      expect(current_path).to eq "/listings/#{listing.id}/show"

      expect(page).to have_content "House of Horrors A very scary house 69.85"
      #expect(page).to have_button "Enquiry"
      #expect(page).to have_content "Hello World!"
    end
end
