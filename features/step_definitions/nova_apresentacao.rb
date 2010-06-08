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

Dado /^que inseri os seguintes dados$/ do |string|
    string.split("\n").each do |linha|
        Dado %{que preenchi "#{linha}" no campo "master"}
        Quando %{eu pressionar "add"}
    end
end

Dado /^que sou o autor "([^\"]*)" com email "([^\"]*)"$/ do |arg1, arg2|
  @author = Author.new :name => arg1, :email => arg2
end

Dado /^que crio uma nova apresentação com o titulo "([^\"]*)"$/ do |arg1|
  @presentation = Presentation.new :title => arg1, :author => @author
end

Quando /^eu salvar esta apresentação$/ do
    p @presentation
    @presentation.save
    p @presentation
  
end

Então /^terá uma pagina$/ do
    @presentation.should have(1).pages
end


