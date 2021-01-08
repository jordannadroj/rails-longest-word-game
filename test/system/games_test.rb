require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  # You can fill the form with a random word, click the play button, and get a message that the word is not in the grid.
  test "Fill in form with random word, play and receive message that word is not in grid" do
    visit new_url
    fill_in "attempt", with: "doinadoienaedin"
    click_on "Play"

    assert_selector "p", text: "Your word: #{@attempt}"
    take_screenshot
  end
end
