require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('https://internet.org/'))

#check javascript
script_counter = 0
doc.css('script').each do |link|
  puts link["src"]
  script_counter += 1
end

#find specfic included js files
doc.css('script').each do |link|
	#puts link
	if link["src"] =~ /\.js$/
		puts link
	end
end

if script_counter > 0
	puts "You have #{script_counter} Script tags. Please remove."
end

#bravo on noscript
doc.css('noscript').each do |link|
  puts link
  puts "Good job you have noscript tag for handling no JS."
end

#other tags: Multimedia and SVG and Frames
doc.css('svg', 'iframe', 'video', 'audio', 'source', 'frame', 'track', 'object').each do |link|
  puts link
end

#canvas is heavy for browser.
doc.css('canvas').each do |link|
	puts link
end

#flash
doc.css('object[type="application/x-shockwave-flash"]').each do |link|
	puts link
end

#find specfic included js files
doc.css('param').each do |link|
	#puts link
	if link["src"] =~ /\.swf$/
		puts link
	end
end



#check for large images: image file size
#check for video size

#java applets
#applet tag, embed with code ends with .class or  type="application/x-java-applet;version=1.6"