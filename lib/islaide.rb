# coding: utf-8

class Presentation 
    attr_accessor :author, :title, :email, :pages 
    def initialize attrs
        self.author = attrs[:author]
        self.title = attrs[:title]
        self.email= attrs[:email]
        self.pages = [Page.new("#| #{self.title}")]
    end
end
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

   before do
     headers['Content-Type'] = 'text/html; charset=utf-8'
   end

   get "/?" do
     erb :new
   end
   post "/create" do
      @presentation = Presentation.new params[:presentation]

      erb :edit
   end

   post '/add' do
      Islaide.parse params[:item]
   end

   get "/play" do
      @title = @presentation.title
     erb :play
   end
end

