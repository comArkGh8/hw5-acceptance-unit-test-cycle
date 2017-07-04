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
      expect(response).to redirect_to(movies_path)
    end
  end
  
  # note create is a post
  describe 'creates a movie' do
    it 'should create a movie' do
      expect {post :create, movie: FactoryGirl.attributes_for(:movie)
        }.to change { Movie.count }.by(1)
    end
    
    it 'redirects to main movie page' do
      post :create, movie: FactoryGirl.attributes_for(:movie)
      expect(response).to redirect_to(movies_path)
    end
  end
  
  # note: new is a get
  describe 'new just goes to new page' do
    it 'redirects to new movie page' do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  # note: update is a patch/put
  # takes two inputs: the id + the movie_params
  # we get movie_params from FactoryGirl
  describe 'updating a movie' do
    #first get a movie from factory
    let(:a_movie) { FactoryGirl.create(:movie) }
    before(:each) do
      put :update, id: a_movie.id, movie: FactoryGirl.attributes_for(:movie, rating: 'PG')
    end

    it 'updates a movie' do
      a_movie.reload
      expect(a_movie.rating).to eql('PG')
    end

    # then should go back to movie page
    it 'redirects to movie page' do
      expect(response).to redirect_to(movie_path(a_movie))
    end
  end
  
  # test for destroy
  # destroy is a delete operation
   describe 'destroy a movie' do
    #first get a movie from factory
    let(:a_movie) { FactoryGirl.create(:movie) }
    before(:each) do
      delete :destroy, id: a_movie.id
    end
    
    it 'destroys a movie' do
      expect(Movie.count).to eql(0)
      # could also use expect change to be -1 in analogy with above
      # create step
    end 
    
    # then should go back to main movie page
    it 'redirects to movie page' do
      expect(response).to redirect_to movies_path
    end  
   end



end



