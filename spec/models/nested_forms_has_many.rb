require "spec_helper"

describe Manufacturer do
  it "needs vehicles" do
    p = {
      name: 'Mazda',
    }
    m = Manufacturer.create(p)

    expect(m.valid?).to eq(false)
  end

  it "needs 2 vehicles" do
    p = {
      name: 'Mazda',
      vehicles_attributes: {
        0 => { name: 'Mazda 1' }
      }
    }
    m = Manufacturer.create(p)

    expect(m.valid?).to eq(false)
  end

  it "has 2 vehicles" do
    p = {
      name: 'Mazda',
      vehicles_attributes: {
        0 => { name: 'Mazda 1' },
        1 => { name: 'Mazda 3' }
      }
    }
    m = Manufacturer.create(p)

    # expect(m.vehicles.count).to eq(2)
    expect(m.valid?).to eq(true)
  end

  it "exceeded 3 vehicles" do
    p = {
      name: 'Mazda',
      vehicles_attributes: {
        0 => { name: 'Mazda 1' },
        1 => { name: 'Mazda 3' },
        2 => { name: 'Mazda 2' },
        3 => { name: 'GT' }
      }
    }
    m = Manufacturer.create(p)

    expect(m.valid?).to eq(false)
  end

  it "destroy 1 but needs 2 vehicles" do
    p = {
      name: 'Mazda',
      vehicles_attributes: {
        0 => { name: 'Mazda 1' },
        1 => { name: 'Mazda 3' }
      }
    }
    m = Manufacturer.create(p)

    expect(m.valid?).to eq(true)

    # Updating part

    p = {
      name: 'Lancer',
      vehicles_attributes: {
        0 => { id: 1, name: 'GT' },
        1 => { id: 2, _destroy: 1 }
      }
    }
    m.update(p)

    expect(m.name).to eq('Lancer')
    expect(m.valid?).to eq(false)

    m.reload
    # It should still return 2 cause it didn't save
    expect(m.vehicles.count).to eq(2)
  end
end
