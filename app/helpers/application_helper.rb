module ApplicationHelper

  def logo
    image_tag("logo.png", :alt => "Application exemple", :class => "round")  
  end


  # retoune un titre base sur la page
  def titre
    base_titre = "Simple App du Tutoriel Ruby on Rails"
    if @titre.nil?
      base_titre
    else
      "#{base_titre} | #{@titre}"
    end
  end
end
