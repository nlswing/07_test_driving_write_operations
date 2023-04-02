require 'user_repository'

RSpec.describe do

  def reset_users_table
  seed_sql = File.read('spec/user_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
  connection.exec(seed_sql)
  end

  describe UserRepository do
  before(:each) do 
    reset_users_table
  end
  end

  it "returns all users" do
    repo = UserRepository.new
    
    users = repo.all

    users.length # =>  2

    expect(users[0].id).to eq 1
    expect(users[0].name).to eq 'John Lennon'
    expect(users[0].email).to eq 'jl@beatles.com'
    
  end
end