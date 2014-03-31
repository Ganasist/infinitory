puts 'before'
test = SmarterCSV.process('zemp.csv', quote_char: "\'", force_simple_split: true, strip_chars_from_headers: /[\-"]/)
puts 'after'