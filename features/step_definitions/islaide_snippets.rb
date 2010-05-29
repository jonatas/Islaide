Given /^the following "([^\"]*)" should render the following "([^\"]*)"$/ do |what, expected, by_examples|
  by_examples.hashes.each do |example|
      expected.split(", ").each do |method|
       result = Islaide.send(method, example[what])
       result = result.join(" ") if result.kind_of? Array
       result.should == example[method]
      end
  end
end

