module PriceHelper
    def price_to_sign(price)
      case price
        when 1
          "$"
        when 2
          "$$"
        when 3
          "$$$"
        when 4
          "$$$$"
        when 5
          "$$$$$"
        else
          "N/A"
      end
    end

  def rating_to_star(rating)
    case rating
      when 1..2
        "&#9733&frac12".html_safe
      when 2..2.5
        "&#9733&frac12".html_safe
      when 2.5..3
        "&#9733&frac34".html_safe
      when 3..3.5
        "&#9733&#9733&#9733&frac12".html_safe
      when 3.5..4
        "&#9733&#9733&#9733&frac34".html_safe
      when 4..4.5
        "&#9733&#9733&#9733&#9733&frac12".html_safe
      when 4..4.5
        "&#9733&#9733&#9733&#9733&frac34".html_safe
      when 4.5..5
        "&#9733&#9733&#9733&#9733&#9733".html_safe
      else
        "N/A"
    end

  end
end
