schema "0001 initial" do

  entity "Podcast" do
    string :name
    integer32 :collection_id
    string :feed_url
    string :thumbnail_url
    string :thumbnail_url_small 
  end
  
end
