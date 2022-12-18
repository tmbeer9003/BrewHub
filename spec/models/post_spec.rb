# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, "Postモデルに関するテスト", type: :model do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:post)).to be_valid
  end
end