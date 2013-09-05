require 'spec_helper'

describe "StaticPages" do
  describe "Invests Pages" do
    it "should have table list of invests!" do
			visit '/invests'
			expect(page).to have_content('借款用途')
    end
  end
end
