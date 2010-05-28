require "rubygems"
gem "bluecloth"
require "bluecloth"

class Islaide

    ALIGNMENTS = {'>'  => 'right',
                "&gt;"  => 'right',
                "&lt;"  => 'left',
                  '<'  => 'left',
                  '|'  => 'center' }


   def self.parse string
     html = BlueCloth.new(string).to_html 
     while html =~ %r{<(\w+)>([>\|<]|&lt;)\s?(.*)</\1>}im
        html = "<#{$1} class='#{ALIGNMENTS[$2]||$2}'>#{$3}</#{$1}>"
     end

     html
   end
end
