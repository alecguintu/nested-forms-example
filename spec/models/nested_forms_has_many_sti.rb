require "spec_helper"

describe Campaign do
  it "needs at least an attachment" do
    p = {
      name: 'Campaign',
    }
    c = Campaign.new(p)

    expect(c.valid?).to eq(false)
  end

  # Video
  it "should have one video attachment" do
    p = {
      name: 'Campaign video',
      video_attributes: {
        name: 'Video 1'
      }
    }
    c = Campaign.create(p)

    expect(c.valid?).to eq(true)
  end

  # Deleting a video
  it "invalidate when video is marked for destruction" do
    p = {
      name: 'Campaign video',
      video_attributes: {
        name: 'Video 1'
      }
    }
    c = Campaign.create(p)

    expect(c.valid?).to eq(true)

    p = {
      video_attributes: {
        id: 1,
        _destroy: 1
      }
    }
    c.update(p)

    expect(c.valid?).to eq(false)
  end

  # Audios
  it "can have one or many audio attachments" do
    p = {
      name: 'Campaign video',
      audios_attributes: {
        0 => { name: 'Audio 1' }
      }
    }
    c = Campaign.new(p)

    expect(c.valid?).to eq(true)

    p = {
      name: 'Campaign video',
      audios_attributes: {
        0 => { name: 'Audio 1' },
        1 => { name: 'Audio 2' }
      }
    }
    c = Campaign.new(p)

    expect(c.valid?).to eq(true)
  end

  # Multiple audios
  it "can have one or many audio attachments" do
    p = {
      name: 'Campaign audio',
      audios_attributes: {
        0 => { name: 'Audio 1' }
      }
    }
    c = Campaign.new(p)

    expect(c.valid?).to eq(true)

    p = {
      name: 'Campaign audio',
      audios_attributes: {
        0 => { name: 'Audio 1' },
        1 => { name: 'Audio 2' }
      }
    }
    c = Campaign.new(p)

    expect(c.valid?).to eq(true)
  end

  # Deleting audios
  it "can have one audio attachment but denied when about to be destroyed" do
    p = {
      name: 'Campaign audio',
      audios_attributes: {
        0 => { name: 'Audio 1' }
      }
    }
    c = Campaign.create(p)

    expect(c.valid?).to eq(true)

    p = {
      audios_attributes: {
        0 => { id: 1, _destroy: 1 },
      }
    }
    c.update(p)

    expect(c.valid?).to eq(false)
  end

  it "can have one audio attachment but denied when about to be destroyed" do
    p = {
      name: 'Campaign audio',
      audios_attributes: {
        0 => { name: 'Audio 1' }
      }
    }
    c = Campaign.create(p)

    expect(c.valid?).to eq(true)

    p = {
      audios_attributes: {
        0 => { id: 1, _destroy: 1 },
      }
    }
    c.update(p)

    expect(c.valid?).to eq(false)
  end

  it "can have multi audio attachments even when one is about to be deleted" do
    p = {
      name: 'Campaign audio',
      audios_attributes: {
        0 => { name: 'Audio 1' },
        1 => { name: 'Audio 2' },
      }
    }
    c = Campaign.create(p)

    expect(c.valid?).to eq(true)

    p = {
      audios_attributes: {
        0 => { id: 1, name: 'Audio 3' },
        1 => { id: 2, _destroy: 1 },
      }
    }
    c.update(p)

    expect(c.audios.first.name).to eq('Audio 3')
    expect(c.valid?).to eq(true)

    c.reload
    expect(c.audios.count).to eq(1)
  end

  it "can have multi audio attachments but denied when all about to be destroyed" do
    p = {
      name: 'Campaign audio',
      audios_attributes: {
        0 => { name: 'Audio 1' },
        1 => { name: 'Audio 2' },
      }
    }
    c = Campaign.create(p)

    expect(c.valid?).to eq(true)

    p = {
      audios_attributes: {
        0 => { id: 1, _destroy: 1 },
        1 => { id: 2, _destroy: 1 },
      }
    }
    c.update(p)

    expect(c.valid?).to eq(false)

    c.reload
    expect(c.audios.count).to eq(2)
  end

  # Shifting types of media
  it "Should delete video when changing to audios" do
    p = {
      name: 'Campaign video',
      video_attributes: {
        name: 'Video 1'
      }
    }
    c = Campaign.create(p)

    expect(c.valid?).to eq(true)

    p = {
      video_attributes: {
        id: 1,
        _destroy: 1
      },
      audios_attributes: {
        0 => { name: 'New audio 1' },
        1 => { name: 'New audio 2' }
      }
    }
    c.update(p)

    expect(c.valid?).to eq(true)

    c.reload
    expect(c.audios.count).to eq(2)
    expect(c.audios.first.name).to eq('New audio 1')

    expect(c.video).to eq(nil)
    expect(c.attachments.count).to eq(2)
  end

  it "Should delete audios when changing to video" do
    p = {
      name: 'Campaign video',
      audios_attributes: {
        0 => { name: 'Audio 1' },
        1 => { name: 'Audio 2' },
        2 => { name: 'Audio 3' }
      }
    }
    c = Campaign.create(p)

    expect(c.valid?).to eq(true)

    p = {
      audios_attributes: {
        0 => { id: 1, _destroy: 1 },
        1 => { id: 2, _destroy: 1 },
        2 => { id: 3, _destroy: 1 }
      },
      video_attributes: {
        name: 'New video 1'
      }
    }
    c.update(p)

    expect(c.valid?).to eq(true)

    c.reload
    expect(c.video.nil?).to eq(false)
    expect(c.video.name).to eq('New video 1')

    expect(c.audios.count).to eq(0)
    expect(c.attachments.count).to eq(1)
  end
end
