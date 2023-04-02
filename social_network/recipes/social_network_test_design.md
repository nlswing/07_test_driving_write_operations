# {{Social Network}} Model and Repository Classes Design Recipe


## 1. Design and create the Table

```
Table: users

Columns:
id | name | email

Table: posts

Columns:
id | title | content | views | user_id
```

## 2. Create Test SQL seeds



```sql

TRUNCATE TABLE users RESTART IDENTITY; 


INSERT INTO users (name, email) VALUES ('John Lennon', 'jl@beatles.com');
INSERT INTO users (name, email) VALUES ('Paul McCartney', 'pm@beatles.com');

TRUNCATE TABLE posts RESTART IDENTITY; 


INSERT INTO posts (title, content, views, user_id) VALUES ('Imagine', 'Imagine all the people', 23, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Maxwell', 'Bang Bang', 25, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby

# Table name: users

# Model class
# (in lib/user.rb)
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end

class Post
end

class PostRepository
end


```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE

class User

  attr_accessor :id, :name, :email
end

class Post

  attr_accessor :id, :title, :content, :views, :user_id
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: users

# Repository class
# (in lib/user_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, email FROM users;

    # Returns an array of User objects.
  end

  # Gets a single user by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, email FROM posts WHERE id = $1;

    # Returns a single User object.
  end

  def create(new_user)
    # Executes the SQL query:
    # INSERT INTO users (name, email) VALUES ($1, $2);
  end

  def delete(user_to_delete)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1;
  end
end

# EXAMPLE
# Table name: users

# Repository class
# (in lib/user_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, views, user_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single post by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, contents, views, user_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  def create(new_post)
    # Executes the SQL query:
    # INSERT INTO posts (title, contents, views, user_id) VALUES ($1, $2, $3, $4);
  end

  def delete(post_to_delete)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1;
  end
end
```

## 6. Write Test Examples


```ruby
# EXAMPLES

# 1
# Get allusers

repo = UserRepository.new

users = repo.all

users.length # =>  2

users[0].id # =>  1
users[0].name # =>  'John Lennon'
users[0].email # =>  'jl@beatles.com'

# 2
# Get a single user

repo = UserRepository.new

id_to_find = repo.find(2)

user.id # =>  2
user.name # =>  'Paul McCartney'
user.cohort_name # =>  'pm@beatles.com'

# 3
# Create a new user

repo = UserRepository.new
new_user = User.new
new_user.name = 'Billy Joel'
new_user.email = 'bj@beatles.com'

repo.create(newuser) # => nil

users = repo.all

last_user = users.last 
last_user.name # => 'Billy Joel'
last_email.email # => 'bj@beatles.com'

# 4
# Deletes a user

repo = UserRepository.new

user_to_delete = 1

repo.delete(user_to_delete)

all_users = repo.all
all_users.length # => 1
all_users.first.id # => 1

# 5
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # =>  1
posts[0].title # =>  'Imagine'
posts[0].content # =>  'Imagine all the people'
posts[0].views # =>  23
posts[0].user_id # => 1

# 6
# Get a single post

repo = UserRepository.new

id_to_find = repo.find(2)

user.id # =>  2
user.title # =>  'Maxwell'
user.content # =>  'Bang bang'
user.views # =>  25
posts.user_id 

# 7
# Create a new user

repo = UserRepository.new
new_user = User.new
new_user.name = 'Billy Joel'
new_user.email = 'bj@beatles.com'

repo.create(new_user) # => nil

users = repo.all

last_user = users.last 
last_user.name # => 'Billy Joel'
last_email.email # => 'bj@beatles.com'

# 8
# Deletes a user

repo = UserRepository.new

user_to_delete = 1

repo.delete(user_to_delete)

all_users = repo.all
all_users.length # => 1
all_users.first.id # => 2


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->