

RSpec.describe Hashes::PasswordHash do
  it 'hashed password is changed' do
    unhashed_password = "password123"
    hashed_password = Hashes::PasswordHash.hash(unhashed_password)
    expect(hashed_password).not_to eq nil
    expect(unhashed_password).not_to eq hashed_password
  end
end
