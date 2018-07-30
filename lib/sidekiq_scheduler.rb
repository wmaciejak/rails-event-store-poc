class SidekiqScheduler
  def call(klass, serialized_event)
    klass.perform_async(serialized_event.to_h.transform_values { |event| YAML.load(event) })
  end

  def async_handler?(klass)
    true
  end
end
