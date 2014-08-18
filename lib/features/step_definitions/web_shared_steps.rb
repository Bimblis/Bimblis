Then (/In (.*?), I check if element (.*?) contains the info of element (.*?)$/) do |page, element_objective, element_memory|
  on_page(page + 'Page').check_element_contains(element_objective, element_memory)
end

Then (/In (.*?), I hover over (.*?) and click in (.*?)$/) do |page, element1, element2|
  on_page(page + 'Page').hover_element(element1)
  on_page(page + 'Page').click_element(element2)
end

Then (/In (.*?), I click the element of (.*?)$/) do |page, element|
  on_page(page + 'Page').click_element(element)
end

Then (/In (.*?), I click internally the element of (.*?)$/) do |page, element|
  on_page(page + 'Page').click_element(element, true)
end

Then (/In (.*?), I hover the mouse over element (.*?)$/) do |page, element|
  on_page(page + 'Page').hover_element(element)
end

Then (/In (.*?), I choose option (.*?) in the select (.*?)$/) do |page, option, element|
  on_page(page + 'Page').select_element(option, element)
end

Then (/In (.*?), I choose internally option (.*?) in the select (.*?)$/) do |page, option, element|
  on_page(page + 'Page').select_element(option, element, true)
end

Then (/In (.*?), I check the (.*?) of element (.*?)$/) do |page, existance, element|
  on_page(page + 'Page').check_element_exists(existance, element)
end

Given(/^In (.*?), I fill (.*?) in text field (.*?)$/) do |page, lorem, element|
  on_page(page + 'Page').input_text_field(lorem, element)
end

Given(/^In (.*?), I fill internally (.*?) in text field (.*?)$/) do |page, lorem, element|
  on_page(page + 'Page').input_text_field(element, lorem, true)
end

Then (/In (.*?), I (.*?) the checkbox of (.*?)$/) do |page, check, element|
  on_page(page + 'Page').check_checkbox(check, element)
end

Then (/In (.*?), I (.*?) internally the checkbox of (.*?)$/) do |page, check, element|
  on_page(page + 'Page').check_checkbox(check, element, true)
end

Then (/I should be in webpage (.*?)$/) do |url|
  web = '$' + url.downcase.gsub(' ', '_')
  on_page(HomePage).check_url(web)
end

And (/^I navigate to this (.*?)$/) do |web|
  web = '$' + web.downcase.gsub(' ', '_')
  @browser.goto eval(web)
end

Then (/I select browser alert (.*?)$/) do |option|
  on_page(HomePage).browser_alert(option)
end

Then (/^In (.*?), I refresh the browser (.*?) times, every (.*?) seconds, until the element (.*?) is present$/) do |page, times, seconds, element|
  on_page(page + 'Page').refresh_until_element_exists(times, seconds, element)
end

Then (/^In (.*?), I refresh the browser (.*?) times, every (.*?) seconds, until the element (.*?) is NOT present$/) do |page, times, seconds, element|
  on_page(page + 'Page').refresh_until_element_not_exists(times, seconds, element)
end

Then (/In (.*?), I record the text of element (.*?)$/) do |page, element|
  on_page(page + 'Page').record_element_text(element)
end
