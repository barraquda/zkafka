require "zkafka/version"
require "zkafka/client"
require "zkafka/message"

module Zkafka

  def self.new(conn)
    Client.new(conn)
  end

end
