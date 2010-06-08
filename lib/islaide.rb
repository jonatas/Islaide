# coding: utf-8

#Encoding.default_internal="utf-8"

require "rubygems"

    gem "sinatra"
    gem "mongo_record"
    gem "markdown"

require "markdown"
require "sinatra"
require "mongo_record"

NEW_PAGE = /^==$/

module Mime 
    class Type 
        def split(*args) 
            to_s.split(*args) 
        end 
    end 
end 

class Page  < MongoRecord::Subobject
    fields :content, :ref
    belongs_to :presentation

    def content_html
       Islaide.parse(content)
    end
end

class Presentation  < MongoRecord::Base
   collection_name :presentations

   fields :title, :author, :password
   belongs_to :author
   has_many :pages, :class_name => 'Page'
end
class Author < MongoRecord::Base
   collection_name :authors
   fields :email, :name
   has_many :presentations, :class_name => 'Presentation'
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
   enable :sessions

   set :views,  File.expand_path(File.dirname(__FILE__) + '/../views')
   set :public,  File.expand_path(File.dirname(__FILE__) + '/../public')


   before do
     headers['Content-Type'] = 'text/html; charset=utf-8'
   end

   get "/?" do
     erb :new
   end

   post "/create" do
    
      @author = Author.find_or_initialize_by_email_and_name(
             params[:presentation][:author][:email],
             params[:presentation][:author][:name])
      
      @author.save

      params[:presentation].delete('author')
                                 
      @presentation = Presentation.new params[:presentation]
      @first_page =  Page.new(:content => "#| #{@presentation.title}", 
                                  :ref => "slide#{Time.now.to_i}") 
                                 
       
      @presentation.pages << @first_page
      @presentation.author =  @author
      @presentation.save

      session[:current_presentation] = @presentation.id
      
      erb :edit
   end

   post '/add' do
      html = Islaide.parse params[:item] 
      @presentation = Presentation.find(session[:current_presentation])
      if params[:item] =~ NEW_PAGE 
          @presentation.pages << Page.new(:content => "", 
                           :ref => "slide#{Time.now.to_i}") 

         html = %{<div style="position: relative; top: 0px;" class="slide" data-transition="scrollUp">
              <div style="margin-top: 0px;" ref="#{@presentation.pages.last.ref}" class="content"></div>
            </div>}
      else
          page = params[:page] || @presentation.pages.size - 1
          page = page.to_i
         @presentation.pages[page].content << "\n#{params[:item]}"
      end
      @presentation.save
      html
   end

   get "/last" do
      @presentations = Presentation.all :limit => 10
      erb :list, :layout => :islaide
   end

   get "/play/:presentation_id" do
      @presentation = Presentation.find(params[:presentation_id])
     erb :play, :layout => :layout
   end
end

