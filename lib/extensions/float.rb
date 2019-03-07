module Extensions
  module Float
    include ActionView::Helpers::NumberHelper

    def display_as(display_type)
      raise ArgumentError, 'You must explicity pass a type to display_as' unless display_type.present?

      send("display_as_#{display_type}")
    end

    def display_as_average
      number_with_precision(self, precision: 3).to_s.sub!(/^0+/, '')
    end

    def display_as_count
      to_i.to_s
    end

    def display_as_ratio
      number_with_precision(self, precision: 2).to_s.sub!(/^0+/, '')
    end

    def display_as_short_ratio
      number_with_precision(self, precision: 2).to_s.sub!(/^0+/, '')
    end

    def display_as_percentage
      number_with_precision(self, precision: 1).to_s.sub(/^0+/, '') + '%'
    end
  end
end
