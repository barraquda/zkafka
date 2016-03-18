require 'zk'
require 'kafka'
require 'json'

require 'zkafka/path'

module Zkafka

  class Client

    attr_reader :kafka_brokers

    def initialize(conn)
      @zk = ZK.new conn
      watch_brokers
      create_kafka!
    end

    def produce(messages, opts = {})
      messages = Array(messages)
      messages.each do |message|
        opts[:topic] = message.topic
        @producer.produce(message.message, opts)
      end
      @producer.deliver_messages
    end

    def get_consumer(opts = {})
      @kafka.consumer(opts)
    end

    def close
      @producer.shutdown
      @zk.close
    end

    private

    def create_kafka!
      read_brokers!
      @kafka = Kafka.new(seed_brokers: @kafka_brokers.map {|b| b['conn'] })
      @producer = @kafka.producer
    end

    def watch_brokers
      @zk.register(Path::BROKER_IDS) do |event|
        if event.node_child?
          create_kafka!
        end
        @zk.children(Path::BROKER_IDS, watch: true)
      end
      @zk.children(Path::BROKER_IDS, watch: true)
    end

    def read_brokers!
      # @kafka = Kafka.new(seed_brokers: broker_ips)
      ids = @zk.children(Path::BROKER_IDS)
      @kafka_brokers = ids.map! do |id|
        broker_json, _ = @zk.get("#{Path::BROKER_IDS}/#{id}")
        broker = JSON::parse broker_json
        broker['conn'] = "#{broker['host']}:#{broker['port']}"
        broker
      end
    end
  end

end