require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:messages) }
  it { should have_many(:conversations) }
end
