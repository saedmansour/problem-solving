# "deep copy": http://thingsaaronmade.com/blog/ruby-shallow-copy-surprise.html

copied_array = Marshal.load(Marshal.dump(complex_array))