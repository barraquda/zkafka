module Zkafka

  class Message

    attr_reader :topic, :message

    def initialize(topic, message)
      @topic = topic
      @message = message
    end

  end

end