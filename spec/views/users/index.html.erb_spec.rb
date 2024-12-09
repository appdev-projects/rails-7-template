require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  it 'displays all the users' do
    users = [
      User.create(email: 'john@example.com', password: 'password', first_name: 'John', last_name: 'Doe'),
      User.create(email: 'jane@example.com', password: 'password', first_name: 'Jane', last_name: 'Smith')
    ]

    paginated_users = Kaminari.paginate_array(users).page(1).per(10)

    assign(:users, paginated_users)
    assign(:q, User.ransack({}))

    render

    expect(rendered).to match /John Doe/
    expect(rendered).to match /Jane Smith/
  end
end
