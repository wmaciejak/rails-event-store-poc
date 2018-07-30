class SidekiqAsyncDispatcher < RubyEventStore::AsyncDispatcher
  def initialize(proxy_strategy: RubyEventStore::AsyncProxyStrategy::Inline.new)
    super(proxy_strategy: proxy_strategy, scheduler: SidekiqScheduler.new)
  end
end
