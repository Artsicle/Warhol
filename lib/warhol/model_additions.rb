module Warhol
  module ModelAdditions
    def what_changed(options = {})

      before_save :check_changed

      include InstanceMethods
    end
    
    module InstanceMethods
      def check_changed
        self.clear_warhol
    
        if self.changed?
          redis = Redis.new
          changes = self.changed.delete_if {|x| x == "updated_at"}
          redis.set  "#{self.class.to_s}_#{self.id}_0", changes.length
          redis.set "#{self.class.to_s}_#{self.id}", changes.to_json
        end
      end
    
      def what_changed
        redis = Redis.new
        a = []
        if was_changed?
          changes = JSON.parse(redis.get("#{self.class.to_s}_#{self.id}"))
          changes.each do |change|
            a << change
          end
        end
        return a
      end
    
      def was_changed?
        redis = Redis.new
        (redis.get "#{self.class.to_s}_#{self.id}_0").to_i > 0
      end  
    
      def clear_warhol
        redis = Redis.new
        redis.del "#{self.class.to_s}_#{self.id}_0"
        redis.del "#{self.class.to_s}_#{self.id}"
      end
    end
  end
end