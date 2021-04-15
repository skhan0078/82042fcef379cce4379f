# frozen_string_literal: true

require '../bot_saves_princess'

describe BotSavesPrincess do
  let(:grid_size) { }
  let(:grid_matrix) { }
  
  describe 'display_pathto_princess' do
    subject { described_class.new.displayPathtoPrincess(grid_size, grid_matrix) }

    before do
      allow(get_princess_xy).to receive(:grid_matrix).and_return(true)
      allow(get_mario_xy).to receive(:grid_matrix).and_return(true)
    end

    it { is_expected.to be true }
  end
end
