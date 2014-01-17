require "spec_helper"

describe Book do
  it "should require cover art" do
    p = {
      title: 'Foobar'
    }
    b = Book.new(p)

    expect(b.valid?).to eq(false)
  end

  it "really should require" do
    p = {
      title: 'Foobar',
      cover_attributes: {
        color: 'blue'
      }
    }
    b = Book.new(p)

    expect(b.valid?).to eq(true)
  end

  it "updating associated values" do
    p = {
      title: 'Foobar',
      cover_attributes: {
        color: 'blue'
      }
    }
    b = Book.create(p)

    expect(b.cover.color).to eq('blue')

    p = {
      cover_attributes: {
        color: 'red'
      }
    }
    b.update(p)

    expect(b.cover.color).to eq('red')
  end

  it "deleting association" do
    p = {
      title: 'Foobar',
      cover_attributes: {
        color: 'blue'
      }
    }
    b = Book.create(p)

    p = {
      cover_attributes: {
        id: b.cover.id,
        _destroy: 1
      }
    }
    b.update(p)

    expect(b.valid?).to eq(false)
  end
end