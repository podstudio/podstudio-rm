class SearchCell < UITableViewCell 

  def rmq_build
    rmq(self).apply_style :search_cell

    rmq(self.contentView).tap do |q|
      # Add your subviews, init stuff here
      # @foo = q.append(UILabel, :foo).get
      #
      # Or use the built-in table cell controls, if you don't use 
      # these, they won't exist at runtime
      # q.build(self.imageView, :cell_image)
      @name = q.build(self.textLabel, :cell_label).get
    end
  end

  def update(data)
    @name.text = data['collectionName']
  end

end
