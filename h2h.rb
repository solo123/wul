Dir["#{File.join(File.dirname(__FILE__), 'app', 'views')}/**/*.erb"].each do |file|
  puts "Working on: #{file} ..."
  `html2haml -rx #{file} #{file.gsub(/\.erb$/, '.haml')}`
end



