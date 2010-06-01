# encoding: utf-8
Dado /^que estou na página de nova apresentação$/ do
  visit "/"
end
Dado /^que preenchi "([^\"]*)" no campo "([^\"]*)"$/ do |value, field|
  fill_in field, :with => value 
end

Quando /^eu pressionar "([^\"]*)"$/ do |label|
   click_button label
end

Então /^devo ver "([^\"]*)"$/ do |texto|
   page.should have_content(texto)
end




