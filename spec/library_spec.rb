require './lib/book'
require './lib/author'
require './lib/library'

RSpec.describe Library do
  before(:each) do
    @dpl = Library.new('Denver Public Library')
    @charlotte_bronte = Author.new({ first_name: 'Charlotte', last_name: 'Bronte' })
    @harper_lee = Author.new({ first_name: 'Harper', last_name: 'Lee' })
    @jane_eyre = @charlotte_bronte.write('Jane Eyre', 'October 16, 1847')
    @professor = @charlotte_bronte.write('The Professor', '1857')
    @villette = @charlotte_bronte.write('Villette', '1853')
    @mockingbird = @harper_lee.write('To Kill a Mockingbird', 'July 11, 1960')
  end
  describe 'Iteration 3' do
    it 'exists' do
      expect(@dpl).to be_a(Library)
    end

    it 'has a name' do
      expect(@dpl.name).to eq('Denver Public Library')
    end

    it 'has books' do
      expect(@dpl.books).to eq([])
    end

    it 'has authors' do
      expect(@dpl.authors).to eq([])
    end

    it 'can add authors' do
      @dpl.add_author(@charlotte_bronte)
      @dpl.add_author(@harper_lee)

      expect(@dpl.authors).to eq([@charlotte_bronte, @harper_lee])
      expect(@dpl.books).to eq([@jane_eyre, @professor, @villette, @mockingbird])
    end

    it 'can return publication time frame for authors' do
      @dpl.add_author(@charlotte_bronte)
      @dpl.add_author(@harper_lee)

      expect(@dpl.publication_time_frame_for(@charlotte_bronte)).to eq({ start: '1847', end: '1857' })
      expect(@dpl.publication_time_frame_for(@harper_lee)).to eq({ start: '1960', end: '1960' })
    end
  end

  describe 'Iteration 4' do
    it 'can checkout books' do
      @dpl.add_author(@charlotte_bronte)
      expect(@dpl.checkout(@jane_eyre)).to be(true)
      expect(@dpl.checkout(@jane_eyre)).to be(false)
      expect(@dpl.checkout(@mockingbird)).to be(false)
    end

    it 'knows what books have been checkout out' do
      @dpl.add_author(@charlotte_bronte)

      expect(@dpl.checked_out_books).to eq([])

      @dpl.checkout(@jane_eyre)

      expect(@dpl.checked_out_books).to eq([@jane_eyre])
    end

    it 'can return books' do
      @dpl.add_author(@charlotte_bronte)
      @dpl.checkout(@jane_eyre)

      expect(@dpl.checked_out_books).to eq([@jane_eyre])

      @dpl.return(@jane_eyre)

      expect(@dpl.checked_out_books).to eq([])
    end

    it 'knows what the most popular book is' do
      @dpl.add_author(@charlotte_bronte)
      @dpl.checkout(@jane_eyre)
      @dpl.return(@jane_eyre)
      @dpl.checkout(@jane_eyre)
      @dpl.checkout(@villette)

      expect(@dpl.most_popular_book).to eq(@jane_eyre)
    end
  end
end
