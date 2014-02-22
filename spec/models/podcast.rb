describe 'Podcast' do

  before do
    include CDQ
    cdq.setup
  end

  after do
    cdq.reset!
  end

  it 'should be a Podcast entity'
    Podcast.entity_description.name.should == 'Podcast'
  end
end
