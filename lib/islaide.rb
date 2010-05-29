class Islaide < Sinatra::Application
    ALIGNMENTS = {'>'  => 'right',
                "&gt;"  => 'right',
                "&lt;"  => 'left',
                  '<'  => 'left',
                  '|'  => 'center' }


   def self.parse string
     html = Maruku.new(string.gsub("\n\n", '\n')).to_html 

     while html =~ %r{<(\w+)(.*)>([>\|<]|\&lt;|&gt;)\s+(.*)</\1>}im
       html = html.gsub(%r{<(\w+)(.*)>([>\|<]|\&lt;|&gt;)\s+(.*)</\1>}im,
                 "<#{$1}#{$2} class='#{ALIGNMENTS[$3]}'>#{$4}</#{$1}>")
     end


     puts html
     html
   end

   get "/play" do
      @presentation = []
      @title = "Welcome to Islaide!"
     erb :play
   end


end

