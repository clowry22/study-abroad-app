class LanguageController < ApplicationController
  def index 
    @country = params.fetch("country").capitalize
    @matching_countries = Country.where({ :name => @country})
    @the_country = @matching_countries.at(0)

    cookies.store(:most_recent_country, @country)
    render({ :template => "translate_templates/index.html.erb"})
  end

  def add_phrase_form
    @country = params.fetch("country").capitalize
    @matching_countries = Country.where({ :name => @country})
    @the_country = @matching_countries.first
    @input_phrase = params.fetch("phrase")
    @input_original_language = params.fetch("old_language")


    # if @input_phrase != nil  
    #   if Phrase.where({ :original_phrase => @input_phrase}).present?
    #     matching_phrases = Phrase.where({ :original_phrase => @input_phrase})
    #     @the_phrase = matching_phrases.at(0)
    #   else 
    #     @the_phrase = Phrase.new
    #     @the_phrase.original_phrase = @input_phrase
    #     @the_phrase.original_language = @input_original_language
    #     @the_phrase.save 
    #   end 

      cookies.store(:most_recent_country, @country)
      @array_of_languages = @the_country.languages
    render({ :template => "translate_templates/add_phrase.html.erb"})
    # else
    #   next_url = "/home/" + @the_country.to_s + "/translate"
    #   redirect_to(next_url)
    # end
    
  end

  def add_phrase_results
    @input_phrase = params.fetch("origin_phrase")
    @new_language = params.fetch("new_lang")
    @original_language = params.fetch("old_language")
    @the_country = params.fetch("country")
    render({ :template => "translate_templates/add_phrase_results.html.erb"})
  end
end