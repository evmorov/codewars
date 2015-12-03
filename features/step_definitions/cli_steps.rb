Given(/^the config file does not exist$/) do
  step 'a file "~/.codewarsrc" does not exist'
end

Given(/^the config file with:$/) do |string|
  step 'a file "~/.codewarsrc" with:', string
end

Then(/^the config file should contain exactly:$/) do |string|
  step 'the file "~/.codewarsrc" should contain exactly:', string
end
