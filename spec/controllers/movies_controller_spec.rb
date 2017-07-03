require 'rails_helper'

describe MoviesController do
  
  
  describe 'Find movies by the same director' do
    # just see if .same_director is activated
    it 'should call Movie.same_director' do
      expect(Movie).to receive(:same_director).with('Star Wars')
      get :find, { title: 'Star Wars' }
    end

    # now enter info to get movies list according to .same_director
    # it supposes that when apocalypse now is fed into same_director,
    # the list including lost is given
    # check to see if results of find are the movies
    it 'should assign similar movies if director exists' do
      movies = ['apocalypse now', 'lost']
      Movie.stub(:same_director).with('apocalypse now').and_return(movies)
      get :find, { title: 'apocalypse now' }
      expect(assigns(:movies_with_director)).to eql(movies)
    end
    
    # enter strange name to get movies list according to .same_director
    # we suppose nil is returned
    it 'should redirect to home page if we do not know director (sad path)' do
      Movie.stub(:same_director).with('absent title').and_return(nil)
      # now enter a find control command
      get :find, { title: 'absent title' }
      expect(response).to redirect_to(root_url)
    end


  end

end



