
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

    TAG_WITH_ALIGNMENTS = %r{<(\w+)(.*)>([>\|<\$]|\&lt;|&gt;)\s+(.*)</\1>}i

   def self.parse string
     html = Maruku.new(string).to_html 

     html = html.split("\n").collect do |line|
     if line=~ TAG_WITH_ALIGNMENTS
             element = $1
             element = "pre" if $3 == "$"
             line= line.gsub(TAG_WITH_ALIGNMENTS,
             "<#{element}#{$2} class='#{ALIGNMENTS[$3]}'>#{$4}</#{element}>")
      end
     line

     end.join

     html
   end

   get "/play" do
      @presentation = [
      Page.new("# title           

##< left    

###> right 

\| center"),
Page.new("#| sub titulo 

* primeiro ponto 
- segundo ponto 

$ puts 'hello'")
      ]
      puts @presentation

      @title = "Welcome to Islaide!"
     erb :play
   end
end

