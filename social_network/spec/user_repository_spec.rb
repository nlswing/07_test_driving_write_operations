require 'user_repository'

RSpec.describe UserRepository do

  def reset_users_table
    seed_sql = File.read('spec/user_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end


  before(:each) do 
    reset_users_table
  end
 

  it "returns all users" do
    repo = UserRepository.new
    
    users = repo.all

    expect(users.length).to eq 2
    expect(users[0].id).to eq 1
    expect(users[0].name).to eq 'John Lennon'
    expect(users[0].email).to eq 'jl@beatles.com'
  end

  it 'returns a user details' do
    repo = UserRepository.new

    user = repo.find(2)

    expect(user.id).to eq 2
    expect(user.name).to eq 'Paul McCartney'
    expect(user.email).to eq 'pm@beatles.com'
    
  end

  it 'returs a new user' do
    repo = UserRepository.new
    new_user = User.new
    new_user.name = 'Billy Joel'
    new_user.email = 'bj@beatles.com'

    repo.create(new_user)

    users = repo.all
    last_user = users.last 

    expect(last_user.name).to eq 'Billy Joel'
    expect(last_user.email).to eq 'bj@beatles.com'
  end 

  it 'deletes a user' do
  repo = UserRepository.new

  user_to_delete = 1
  
  repo.delete(user_to_delete)
  
  all_users = repo.all
  expect(all_users.length).to eq 1
  expect(all_users.first.id).to eq 2

  end


  
end

    
