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
end

    
