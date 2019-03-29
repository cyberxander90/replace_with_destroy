module ReplaceWithDestroy  
  ALL = false
end

module ActiveRecord
  module Associations
    class CollectionAssociation < Association
      private

      def replace_records(new_target, original_target)
        if ReplaceWithDestroy::ALL || self.options[:replace_with_destroy]
          destroy(target - new_target)
        else
          delete(target - new_target)
        end

        unless concat(new_target - target)
          @target = original_target
          raise RecordNotSaved, "Failed to replace #{reflection.name} because one or more of the " \
                                "new records could not be saved."
        end

        target
      end
    end
  end
end

ActiveRecord::Associations::Builder::Association::VALID_OPTIONS << :replace_with_destroy
