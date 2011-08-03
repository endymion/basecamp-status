Then /^"([^\"]+)" should not be visible$/ do |text|
  paths = [
    "//*[@style='display: none;']/*[contains(.,'#{text}')]",
    "//*[@style='display: none;']"
  ]
  xpath = paths.join '|'
  page.should have_xpath(xpath)
end
