# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  prefered_city   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_inclusion_of(:prefered_city).in_array(City::NAMES).allow_nil }
  end

  describe 'callbacks' do
    describe 'before_save' do
      it 'should sanitize prefered_city if present' do
        user = create(:user, prefered_city: 'New-York')
        expect(user.prefered_city).to eq('new-york')
      end

      it 'should downcase email' do
        user = create(:user, email: 'TEST@EXAMPLE.COM')
        expect(user.email).to eq('test@example.com')
      end
    end
  end
end
