class TextSearchService
  attr_accessor :data

  class << self
    def create(options={})
      self.new(options).create
    end
  end

  def initialize(options={})
    @data = options
  end

  def create
    @resp = CopyScapeService.post(@data.data)
  end
end
