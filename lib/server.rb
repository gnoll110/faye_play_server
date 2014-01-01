require 'faye'

server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)


EM.run {
  thin = Rack::Handler.get('thin')
  thin.run(server, :Port => 9292)

  server.bind(:subscribe) do |client_id, channel|
    puts "[  SUBSCRIBE] #{client_id} -> #{channel}"
  end

  server.bind(:unsubscribe) do |client_id, channel|
    puts "[UNSUBSCRIBE] #{client_id} -> #{channel}"
  end

  server.bind(:disconnect) do |client_id|
    puts "[ DISCONNECT] #{client_id}"
  end
}
