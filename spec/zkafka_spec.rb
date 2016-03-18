require 'spec_helper'

describe 'Environment' do

  it 'has ZK environment variable' do
    zk = ENV['ZK']
    expect(zk).not_to eq nil
  end

  it 'is formatted $HOST:$PORT' do
    zk = ENV['ZK']
    regex = /(([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]).){3}([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]):[1-9][0-9]*/
    expect(zk).to match regex
  end

end

describe Zkafka do

  enable_zkafka

  it 'works' do

    @zkafka.produce Zkafka::Message.new('zkafka-rspec', 'hello world')

    while @messages.length < 1; end

    expect(@messages.length).to eq(1)
    expect(@message[0]).to eq 'hello world'
  end

end
