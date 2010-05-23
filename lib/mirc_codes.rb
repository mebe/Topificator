module MircCodes
  public
  
  def mirc_to_html
    string = self.clone
    ToHtml.parse(string)
  end
  
  def mirc_to_html!
    ToHtml.parse self
  end
  
  def strip_mirc
    string = self.clone
    Strip.parse string
  end
  
  def strip_mirc!
    Strip.parse self
  end
  
  private
  class Strip
    def self.parse(string)
      Raw.match_codes(string) { |asdfasdf|
        string[asdfasdf.position] = ''
      }
      string      
    end
  end
  
  class ToHtml
    private
    OpenStyles = Struct.new('OpenStyles', :color, :background_color, :bold, :underline, :open)
    class Helper
      include ActionView::Helpers::TextHelper
      include ActionView::Helpers::TagHelper
    end
    
    public
    def self.parse(string)
      styles = OpenStyles.new(false, false, false, false, false)
      helper = Helper.new
      
      string = helper.auto_link(CGI.escapeHTML(string), :all, :class => 'topic_link')
      
      Raw.match_codes(string) { |code|
        case
        when code.bold?
          styles.bold = !styles.bold
        when code.color?
          styles.color = false
          styles.color = false
          styles.background_color = false
          
          if code.color
            styles.color = '#' << code.color
            if code.background_color
              styles.background_color = '#' << code.background_color
            end
          end
        when code.underline?
          styles.underline = !styles.underline
        when code.reset?
          styles.color = false
          styles.bold = false
          styles.underline = false
        end
        
        string[code.position] = self.build_tags styles
      }
      
      if styles.open
        string << '</span>'
      end      
      string
    end
    
    private
    def self.build_tags(styles)
      tags = ''
      if styles.open
        tags << '</span>'
        styles.open = false
      end
      if self.styles_pending?(styles)
        tags << '<span style="' << self.build_css(styles).join('; ') << ';">'
        styles.open = true
      end
      tags
    end
    
    def self.build_css(styles)
      css = Array.new
      css << ('color: ' << styles.color) unless styles.color.kind_of? FalseClass
      css << ('background-color: ' << styles.background_color) unless styles.background_color.kind_of? FalseClass
      css << 'font-weight: bold' if styles.bold
      css << 'text-decoration: underline' if styles.underline
      css
    end 
    
    def self.styles_pending?(styles)
      styles.each { |style|
        return true unless style == false
      }
      return false
    end
  end
  
  class Raw
    #MIRC codes in ASCII
    CODE_BOLD      = 2
    CODE_COLOR     = 3
    CODE_RESET     = 15
    CODE_UNDERLINE = 41
    
    protected
    def self.match_codes(string)
      while string[/\002|\003(\d{1,2})?(,\d{1,2})?|\x0F|\x16|\x1F/]
        code = Code.new
        code.position = Range.new(string.index($~[0]), string.index($~[0]) + $~[0].length, true)
        
        code.type = $~[0][0]
        if code.type == CODE_COLOR
          if $1
            code.color = self.get_color($1)
            if $2
              code.background_color = self.get_color($2.tr(', ', ''))
            end
          end        
        end
        yield code
      end
    end
    
    private
    def self.get_color(color_code)
      case color_code.to_i
      when 0
      'FFFFFF'
      when 1
      '000000'
      when 2
      '0000FF'
      when 3
      '00FF00'
      when 4
      'FF0000'
      when 5
      '840009'
      when 6
      '8400FF'
      when 7
      '0000FF'
      when 8
      'FF8400'
      when 9
      'FFFF00'
      when 10
      '84FF00'
      when 11
      '00FF84'
      when 12
      '00FFFF'
      when 13
      '0084FF'
      when 14
      'FF00FF'
      when 15
      '848484'
      when 16
      'C6C6C6'
      else
        nil
      end 
    end
    
    Code = Struct.new('Code', :type, :position, :color, :background_color)    
    class Code
      def reset?
        self.type == CODE_RESET
      end
      
      def color?
        self.type == CODE_COLOR
      end
      
      def bold?
        self.type == CODE_BOLD
      end
      
      def underline?
        self.type == CODE_UNDERLINE
      end
    end
  end
end