require 'rails_helper'

RSpec.describe Score do
  it 'should not save without score' do
    score = Score.new
    expect(score.save).to be false
  end
end
