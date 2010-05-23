# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def help_link(action)
    link_to image_tag('question.png', :size => '18x18'), {:controller => 'help', :action => action}, :class => 'lbOn'
    #link_to image_tag('question.png', :size => '18x18'),
    #        {:controller => 'help', :action => action}, :popup => ['topificator_help', 'height=500,width=500']
  end
end
