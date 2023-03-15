# frozen_string_literal: true

require "spec_helper"

describe "Homepage", type: :system do
  let(:organization) { create(:organization) }
  let!(:hero) { create :content_block, organization: organization, scope_name: :homepage, manifest_name: :hero }
  let!(:slider) { create :slider, organization: organization }
  let!(:tab) { create :video_text_tab, organization: organization }
  let!(:tab2) { create :video_text_tab, organization: organization }

  before do
    switch_to_host(organization.host)
    visit decidim.root_path
  end

  it "is expected to find tab elements" do
    expect(page).to have_content(tab.settings.title["en"])
    expect(page).to have_content(tab.settings.cta["en"])
    expect(page).to have_content(tab.settings.content["en"])
  end

  it "is expected to find second tab elements" do
    expect(page).to have_content(tab2.settings.title["en"])
    expect(page).to have_content(tab2.settings.cta["en"])
    expect(page).to have_content(tab2.settings.content["en"])
  end

  it_behaves_like "accessible page" do
    before do
      within ".cookie-warning" do
        click_button "I agree"
      end
    end
  end
end
