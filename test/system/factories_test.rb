require "application_system_test_case"

class FactoriesTest < ApplicationSystemTestCase
  setup do
    @factory = factories(:one)
  end

  test "visiting the index" do
    visit factories_url
    assert_selector "h1", text: "Factories"
  end

  test "should create factory" do
    visit factories_url
    click_on "New factory"

    fill_in "Description", with: @factory.description
    fill_in "Name", with: @factory.name
    fill_in "Url", with: @factory.url
    click_on "Create Factory"

    assert_text "Factory was successfully created"
    click_on "Back"
  end

  test "should update Factory" do
    visit factory_url(@factory)
    click_on "Edit this factory", match: :first

    fill_in "Description", with: @factory.description
    fill_in "Name", with: @factory.name
    fill_in "Url", with: @factory.url
    click_on "Update Factory"

    assert_text "Factory was successfully updated"
    click_on "Back"
  end

  test "should destroy Factory" do
    visit factory_url(@factory)
    click_on "Destroy this factory", match: :first

    assert_text "Factory was successfully destroyed"
  end
end
