# Zkafka

Zkafka is a just wrapper for Apache Kafka with Zookeeper.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zkafka'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zkafka

## Usage

You can setup the Zkafka client with a simple line.

```
zkafka = Zkafka.new '#{Zookeeper IP}:#{Zookeeper Port}'
```

For producing a message and put it into Kafka, write the following line.

```
zkafka.produce Zkafka::Message.new('topic', 'message')
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

