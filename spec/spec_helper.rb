$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'zkafka'

def enable_zkafka
  instance_eval do
    around(:each) do |example|
      @zkafka = Zkafka.new ENV['ZK']

      @messages = []
      thread = Thread.new do
        consumer = @zkafka.get_consumer(group_id: 'zkafka-rspec-consumer')
        consumer.subscribe('zkafka-rspec')
        consumer.each_message {|message| @messages << message }
      end

      example.run
      @zkafka.close
      thread.kill
    end
  end
end