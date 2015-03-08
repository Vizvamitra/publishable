require 'spec_helper'

RSpec.describe Publishable::Scopes::Mongoid do

  before :each do
    [:published, :planned, :expired, :draft].each do |status|
      create_list(:post, 5, status)
    end
  end

  let(:published){ Post.published }
  let(:not_published){ Post.not_published }
  let(:planned){ Post.planned }
  let(:drafts){ Post.drafts }
  let(:expired){ Post.expired }

  it 'published' do
    expect( published.count ).to eq 5
    published.each do |record|
      expect( record ).to be_published
    end
  end

  it 'not_published' do
    expect( not_published.count ).to eq 15
    not_published.each do |record|
      expect( record ).not_to be_published
    end
  end

  it 'planned' do
    expect( planned.count ).to eq 5
    planned.each do |record|
      expect( record ).to be_planned
    end
  end

  it 'drafts' do
    expect( drafts.count ).to eq 5
    drafts.each do |record|
      expect( record ).to be_draft
    end
  end

  it 'expired' do
    expect( expired.count ).to eq 5
    expired.each do |record|
      expect( record ).to be_expired
    end
  end

  describe '::for?' do
    it 'returns true if model has Mongoid::Document in it\'s ancestors' do
      expect(described_class).to be_for(Post)
    end

    it 'returns false otherwise' do
      expect(described_class).not_to be_for(News)
    end
  end

end