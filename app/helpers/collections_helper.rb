module CollectionsHelper
  def available_collections
    return @collections if @collections
    # @collections = Collection.available.collect{|collection| [collection.title, collection.id]}
    @collections = Collection.all.collect{|collection| [collection.title, collection.id]}
  end


end
