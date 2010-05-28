class Islaide
    FORMATTERS = {
        '#'   => {name:'title',      html: 'h1'},
        '##'  => {name:'subtitle',   html: 'h2'},
        '###' => {name:'subsubtitle',html: 'h3'},
        '*'   => {name:'bullet',     html: 'li'},
        '$'   => {name:'code',       html: 'pre'}
    }

    SOME_FORMATTER = %r[^(\#{1,3}|\*|\$)]

    ALIGNMENTS = {'>'  => 'right',
                  '|'  => 'center',
                  '<'  => 'left'}

   def self.alignment(string)
      ALIGNMENTS[string[0]]
   end

   def self.formatter(string)
      if string =~ SOME_FORMATTER
         FORMATTERS[$1][:name]
      end
   end

   def self.html_tag string
      if string =~ SOME_FORMATTER
         FORMATTERS[$1][:html]
      end
   end

   def self.parse string
      snippet, content = string.split(" ")
     if tag = html_tag(snippet) 
        snippet.gsub!(SOME_FORMATTER, '')
     else
        tag = "p"
     end
     tag ||= "p"
     
     if css_class = alignment(snippet)
        css_class = " class='#{css_class}'"
     end
     "<#{tag}#{css_class}>#{content}</#{tag}>"
   end
end
