module Request
  class TextSearch
    attr_accessor :data, :errors
    def initialize(data)
      @data   = data
      @errors = {}
    end

    def valid?
      text
      resp_format
      errors.empty?
    end
  private
    def text
      if @data[:data].blank?
        errors[:data] = 'Text attribute can not be blank.'
      end
    end

    def resp_format
      if @data.has_key?(:format) && !%w{ xml html }.include?(@data[:format])
        errors[:format] = 'Invalid format'
      end
    end
  end
end
