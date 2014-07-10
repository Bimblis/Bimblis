Then (/In (.*?), I click all the elements of "(.*?)"$/) do |page, element|
  on_page(page + 'Page').click_all_links(element)
end

Then (/In (.*?), I check element "(.*?)" contains the info of element "(.*?)"$/) do |page, element_objective, element_memory|
  on_page(page + 'Page').adv_check_element_contains(element_objective, element_memory)
end

Then (/In (.*?), I hover over "(.*?)" and click in "(.*?)"$/) do |page, element1, element2|
  on_page(page + 'Page').hover_element(element1)
  on_page(page + 'Page').click_element(element2)
end

Then (/In (.*?), I click the element of "(.*?)"$/) do |page, element|
  on_page(page + 'Page').click_element(element)
end

Then (/In (.*?), I hover the mouse over "(.*?)"$/) do |page, element|
  on_page(page + 'Page').hover_element(element)
end

Then (/In (.*?), I randomly select option in "(.*?)"$/) do |page, element|
  on_page(page + 'Page').input_select_list(element)
end

Then (/In (.*?), I choose option (.*?) in the select "(.*?)"$/) do |page, option, element|
  on_page(page + 'Page').select_element(option, element)
end

Then (/In (.*?), I click the link of "(.*?)"$/) do |page, element|
  on_page(page + 'Page').click_link(element)
end

Given(/^In (.*?), I click the button of "(.*?)"$/) do |page, element|
  on_page(page + 'Page').click_button(element)
end

Then (/In (.*?), I check the existence of element "(.*?)"$/) do |page, element|
  on_page(page + 'Page').check_exist_element(element)
end

Then (/In (.*?), I check the NON existence of element "(.*?)"$/) do |page, element|
  on_page(page + 'Page').check_element_not_exist(element)
end

Given(/^In (.*?), I fill (.*?) in field "(.*?)"$/) do |page, lorem, element|
  on_page(page + 'Page').input_text_field(element, lorem)
end

Given(/^In (.*?), I check if the element "(.*?)" contains the correct data$/) do |page, element|
  on_page(page + 'Page').check_element_content(element)
end

Given(/^In (.*?), I check if the element "(.*?)" NOT contains the erased data$/) do |page, element|
  on_page(page + 'Page').check_element_not_contains(element)
end

Then (/In (.*?), I (.*?) the checkbox of "(.*?)"$/) do |page, check, element|
  on_page(page + 'Page').check_checkbox(check, element)
end

Then (/I should be in webpage "(.*?)"$/) do |url|
  web = '$' + url.downcase.gsub(' ', '_')
  on_page(HomePage).check_actual_url(web)
end

And (/^I navigate to this (.*?)$/) do |web|
  web = '$' + web.downcase.gsub(' ', '_')
  @browser.goto eval(web)
end

Then (/I select browser alert "(.*?)"$/) do |option|
  on_page(HomePage).browser_alert(option)
end

Then (/^In (.*?), I refresh the browser "(.*?)" times, every "(.*?)" seconds, until the element "(.*?)" is present$/) do |page, times, seconds, element|
  on_page(page + 'Page').refresh_until_element_present(times, seconds, element)
end

Then (/^In (.*?), I refresh the browser "(.*?)" times, every "(.*?)" seconds, until the element "(.*?)" is NOT present$/) do |page, times, seconds, element|
  on_page(page + 'Page').refresh_until_element_not_present(times, seconds, element)
end

Then (/In (.*?), I record the text of element "(.*?)"$/) do |page, element|
  on_page(page + 'Page').record_element_text(element)
end