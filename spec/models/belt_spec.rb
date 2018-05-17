require 'rails_helper'

RSpec.describe Belt, type: :model do
  describe 'define_max_xp' do
    let(:user) { create(:user) }
    let(:course) { create(:course) }

    it 'level 1' do
      belt = create(:belt, course: course, user: user, level: 1)
      expect(belt.max_xp).to eql(10)
    end

    it 'level 2' do
      belt = create(:belt, course: course, user: user, level: 2)
      expect(belt.max_xp).to eql(20)
    end

    it 'level 3' do
      belt = create(:belt, course: course, user: user, level: 3)
      expect(belt.max_xp).to eql(30)
    end

    it 'level 4' do
      belt = create(:belt, course: course, user: user, level: 4)
      expect(belt.max_xp).to eql(40)
    end

    it 'level 5' do
      belt = create(:belt, course: course, user: user, level: 5)
      expect(belt.max_xp).to eql(45)
    end

    it 'level 6' do
      belt = create(:belt, course: course, user: user, level: 6)
      expect(belt.max_xp).to eql(60)
    end

    it 'level 7' do
      belt = create(:belt, course: course, user: user, level: 7)
      expect(belt.max_xp).to eql(70)
    end

    it 'level 8' do
      belt = create(:belt, course: course, user: user, level: 8)
      expect(belt.max_xp).to eql(70)
    end

    it 'level 9' do
      belt = create(:belt, course: course, user: user, level: 9)
      expect(belt.max_xp).to eql(70)
    end

    it 'level 10' do
      belt = create(:belt, course: course, user: user, level: 10)
      expect(belt.max_xp).to eql(70)
    end

    it 'level 11' do
      belt = create(:belt, course: course, user: user, level: 11)
      expect(belt.max_xp).to eql(70)
    end

    it 'level 12' do
      belt = create(:belt, course: course, user: user, level: 12)
      expect(belt.max_xp).to eql(90)
    end

    it 'level 13' do
      belt = create(:belt, course: course, user: user, level: 13)
      expect(belt.max_xp).to eql(90)
    end

    it 'level 14' do
      belt = create(:belt, course: course, user: user, level: 14)
      expect(belt.max_xp).to eql(95)
    end

    it 'level 15' do
      belt = create(:belt, course: course, user: user, level: 15)
      expect(belt.max_xp).to eql(110)
    end

    it 'level 16' do
      belt = create(:belt, course: course, user: user, level: 16)
      expect(belt.max_xp).to eql(110)
    end

    it 'level 17' do
      belt = create(:belt, course: course, user: user, level: 17)
      expect(belt.max_xp).to eql(150)
    end
  end
end
