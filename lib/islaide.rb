
class Page 
    attr_accessor :content, :ref
    def initialize(content, ref=nil)
       
        self.content = Islaide.parse(content)
        self.ref = ref || "slide#{Time.now.to_i}"
    end
end
class Islaide < Sinatra::Application
    ALIGNMENTS = {'>'  => 'right',
                "&gt;"  => 'right',
                "&lt;"  => 'left',
                  '<'  => 'left',
                  '$'  => 'code',
                  '|'  => 'center' }

    TAG_WITH_ALIGNMENTS = %r{<(\w+)(.*)>([>\|<\$]|\&lt;|&gt;)\s+(.*)</\1>}im

   def self.parse string
     html = Maruku.new(string.gsub("\n\n", '\n')).to_html 

     while html =~ TAG_WITH_ALIGNMENTS
       element = $1
       element = "pre" if $3 == "$"
       html = html.gsub(TAG_WITH_ALIGNMENTS,
                 "<#{element}#{$2} class='#{ALIGNMENTS[$3]}'>#{$4}</#{element}>")
     end

     puts html
     html
   end

   get "/play" do
      @presentation = [
      Page.new("# title           
## subtitle       
##< mini hello    
###> sub on right 
\| center
$ puts 'hello'"),
Page.new("# titulo principal
##\| sub titulo 
* primeiro ponto 
- segundo ponto 

$ puts 'hello'")
      ]
      puts @presentation

      @title = "Welcome to Islaide!"
     erb :play
   end
end

