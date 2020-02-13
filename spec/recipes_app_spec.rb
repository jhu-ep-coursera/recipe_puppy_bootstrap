Capybara.app_host = "http://localhost:3000"

describe "Recipes App" do
  it "displays 'Recipes for chocolate' when visiting the root" do
    visit '/'
    expect(page).to have_content 'Recipes for chocolate'
  end

  it "displays 'Recipes for chocolate' when visiting recipes/index" do
    visit '/recipes/index'
    expect(page).to have_content 'Recipes for chocolate'
  end

  it "displays page for alternate search term (bread)" do
    visit "recipes/index?search=bread"
    expect(page).to have_content 'Our Daily Bread in a Crock - Weekly Make and Bake Rustic Bread'  	
  end

  it "displays utf-8 chars in the title correctly" do
    visit "/recipes/index?search=amarula"
    expect(page).to have_content 'Amarula Frappé'  	
  end

  context "examine page content (view) after visiting recipes/index" do
  	before { visit '/recipes/index' }

    it "displays table header row with 3 columns" do
      expect(page).to have_selector(:xpath, "//table//tr[count(th)=3]")
      expect(page).to have_xpath("//tr[1]/th[1]", text: 'Photo')
      expect(page).to have_xpath("//tr[1]/th[2]", text: 'Title')
      expect(page).to have_xpath("//tr[1]/th[3]", text: 'Ingredients')
    end

    it "displays table element that has a row with 3 columns" do
      expect(page).to have_selector(:xpath, "//table//tr[count(td)=3]")
    end

    it "column 1 should have the thumbnail inside img tag inside a link tag" do
      expect(page).to have_selector(:xpath, "//table//tr/td[1]//a//img")
    end

    it "title should be inside a second column inside a link tag" do
      expect(page).to have_selector(:xpath, "//table//tr/td[2]//a")
    end
  end
end
