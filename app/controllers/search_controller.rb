class SearchController < UITableViewController

  SEARCH_CELL_ID = "SearchCell"

  def viewDidLoad
    super

    @data = []

    rmq.stylesheet = SearchControllerStylesheet

    view.tap do |table|
      table.delegate = self
      table.dataSource = self
      rmq(table).apply_style :table
    end

    @searchBar = UISearchBar.alloc.initWithFrame(CGRectMake(0, 0, self.tableView.frame.size.width, 0))
    @searchBar.delegate = self
    @searchBar.sizeToFit
    self.tableView.tableHeaderView = @searchBar
  end

  def tableView(table_view, numberOfRowsInSection: section)
    @data.length
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    rmq.stylesheet.search_cell_height
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    data_row = @data[index_path.row]

    cell = table_view.dequeueReusableCellWithIdentifier(SEARCH_CELL_ID) || begin
      rmq.create(SearchCell).get
    end

    cell.update(data_row)
    cell
  end

  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    data_row = @data[index_path.row]
    ap "User Selected #{data_row["collectionName"]}"
  end

  def searchBarSearchButtonClicked(searchBar)
    AFMotion::JSON.get("https://itunes.apple.com/search", {term: @searchBar.text, media: "podcast"}) do |response|
      @data = response.object[:results]
      self.tableView.reloadData
      @searchBar.resignFirstResponder
    end
  end

  # Remove if you are only supporting portrait
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end

  # Remove if you are only supporting portrait
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end
end
