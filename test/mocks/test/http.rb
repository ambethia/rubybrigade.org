require 'net/http'

module Net
  class HTTP
    def get(path, *args)
      return File.open("#{RAILS_ROOT}/test/mocks/test/#{File.basename(path)}")
    end
  end
end

class File
  alias_method :body, :read
end