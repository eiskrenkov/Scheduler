module CachingSupport
  extend ActiveSupport::Concern

  class_methods do
    def cache_by_key(key, options = {}, &block)
      cache_key = [key, class_cache_key, options[:suffix]].compact.join('_')

      define_singleton_method("cached_#{key}") do
        cache.fetch(cache_key, &block)
      end

      define_singleton_method("clear_cached_#{key}") do
        cache.delete(cache_key)
      end

      define_singleton_method("recalculate_#{key}_cache") do
        cache.write(cache_key, yield)
      end
    end

    def class_cache_key
      name.pluralize.underscore
    end

    def cache
      Rails.cache
    end
  end
end
