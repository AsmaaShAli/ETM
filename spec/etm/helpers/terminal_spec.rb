# frozen_string_literal: true

describe Etm::Helpers::Terminal do
  let(:terminal) { Etm::Helpers::Terminal.new(nil) }
  let(:json_headers) { { 'content-type' => 'application/json' } }

  context '#get' do
    let(:buffer) { "PK\x03\x04\n\x00\x00\x00\x00\x00\\~\x83O\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\t\x00\x10\x00sniffers/UX\f\x00cv\xE6]Pv\xE6]\xF6\x01\x14\x00PK\x03\x04\x14\x00\b\x00\b\x00\xB4rzO\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x10\x00sniffers/node_times.csvUX\f\x00Hv\xE6]\xE4&\xDD]\xF6\x01\x14\x00U\x8CA\x0E\xC30\b\x04\xEF}E\xC59\a\xBB\xED\x7F\x10\r(B\xB2qd\xE3\xFF\xA7\\*\xE7\xC4\xEE\x8C\x16\xB0\xC6\x82\xAEUP\x19\xB6'\f\xA7\xEE\x184\x9A\x18\xFF3\xCFN\xAE\xCDP\r\xAB\x96\xA2C\xF6f<\xE0\x019|\xA1\xFAe\x8A\xE44\xE3\xE4\x94\xD2O\xBE\x16t\x0E]\xCC{A\xAD\xCAA\x8B\xFB\xDC_\xDE\x86\x17PK\a\b\xAA\xB5\xCA\xC0b\x00\x00\x00\xB5\x00\x00\x00PK\x03\x04\x14\x00\b\x00\b\x00Y~\x83O\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\x10\x00sniffers/sequences.jsonUX\f\x00Jv\xE6]Jv\xE6]\xF6\x01\x14\x00\x8B\xE6RP\xA8\x06b\x05\x05\xA5\xA2\xFC\xD2\x92\xD4\xF8\xCC\x14%+\x05C\x1D\x88P^~Jj|If.L\x18(Z\xABC\x8A\x0E#\x92u\x18\xE3\xD6a\x84]\x87\t\xC9:\xF0\xD8a\x8C]\x87%H\aW,\x17\x00PK\a\b\x16\b\xDC\x16C\x00\x00\x00/\x01\x00\x00PK\x03\x04\x14\x00\b\x00\b\x00\xB4rzO\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x10\x00sniffers/routes.csvUX\f\x00$v\xE6]\xE4&\xDD]\xF6\x01\x14\x00S*\xCA/-I\x8D\xCFLQ\xD2QP*\xC9\xCCM\x85\xD1\xF1U\xF9y\xA9J\\J\x86 \x01#\x03c\x03]C#]c\xC3\x10Cc+\x03\x03+\x033\x90ph\x88\xF3\xA1\x8D \x9E\x01P\xA1\x11v\x85\xE6\x18\n\x8D\xB1+4@W\b\x00PK\a\b\xB0\x96\xAA\aK\x00\x00\x00\x9B\x00\x00\x00PK\x01\x02\x15\x03\n\x00\x00\x00\x00\x00\\~\x83O\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\t\x00\f\x00\x00\x00\x00\x00\x00\x00\x00@\xEDA\x00\x00\x00\x00sniffers/UX\b\x00cv\xE6]Pv\xE6]PK\x01\x02\x15\x03\x14\x00\b\x00\b\x00\xB4rzO\xAA\xB5\xCA\xC0b\x00\x00\x00\xB5\x00\x00\x00\x17\x00\f\x00\x00\x00\x00\x00\x00\x00\x00@\xA4\x817\x00\x00\x00sniffers/node_times.csvUX\b\x00Hv\xE6]\xE4&\xDD]PK\x01\x02\x15\x03\x14\x00\b\x00\b\x00Y~\x83O\x16\b\xDC\x16C\x00\x00\x00/\x01\x00\x00\x17\x00\f\x00\x00\x00\x00\x00\x00\x00\x00@\xA4\x81\xEE\x00\x00\x00sniffers/sequences.jsonUX\b\x00Jv\xE6]Jv\xE6]PK\x01\x02\x15\x03\x14\x00\b\x00\b\x00\xB4rzO\xB0\x96\xAA\aK\x00\x00\x00\x9B\x00\x00\x00\x13\x00\f\x00\x00\x00\x00\x00\x00\x00\x00@\xA4\x81\x86\x01\x00\x00sniffers/routes.csvUX\b\x00$v\xE6]\xE4&\xDD]PK\x05\x06\x00\x00\x00\x00\x04\x00\x04\x002\x01\x00\x00\"\x02\x00\x00\x00\x00" }
    let(:zip_headers) { { 'content-type' => 'application/zip' } }
    let(:html_headers) { { 'content-type' => 'application/html' } }

    it 'response with json' do
      allow_any_instance_of(Faraday::Response).to receive(:body) { { 'id' => 1 }.to_json }
      allow_any_instance_of(Faraday::Response).to receive(:headers) { json_headers }
      allow_any_instance_of(Faraday::Response).to receive(:success?) { true }
      allow_any_instance_of(Faraday::Connection).to receive(:get) { Faraday::Response.new }
      response = terminal.get(path: nil, params: {})
      expect(response['id']).to eq 1
    end

    it 'response with zip' do
      allow_any_instance_of(Faraday::Response).to receive(:body) { buffer }
      allow_any_instance_of(Faraday::Response).to receive(:headers) { zip_headers }
      allow_any_instance_of(Faraday::Response).to receive(:success?) { true }
      allow_any_instance_of(Faraday::Connection).to receive(:get) { Faraday::Response.new }
      terminal.get(path: nil, params: {})
      expect(File.exist?('sniffers/routes.csv')).to be_truthy
      expect(File.exist?('sniffers/node_times.csv')).to be_truthy
      expect(File.exist?('sniffers/sequences.json')).to be_truthy
      FileUtils.rm_rf('sniffers')
    end

    it 'response with html' do
      allow_any_instance_of(Faraday::Response).to receive(:body) { 'html' }
      allow_any_instance_of(Faraday::Response).to receive(:headers) { html_headers }
      allow_any_instance_of(Faraday::Response).to receive(:success?) { true }
      allow_any_instance_of(Faraday::Connection).to receive(:get) { Faraday::Response.new }
      response = terminal.get(path: nil, params: {})
      expect(response).to eq 'html'
    end
  end

  context '#post' do
    it '#success?' do
      allow_any_instance_of(Faraday::Response).to receive(:body) { {}.to_json }
      allow_any_instance_of(Faraday::Response).to receive(:headers) { json_headers }
      allow_any_instance_of(Faraday::Response).to receive(:success?) { true }
      allow_any_instance_of(Faraday::Connection).to receive(:post) { Faraday::Response.new }
      expect(terminal.post(path: nil, params: {})).to be_truthy
    end

    it '!#success?' do
      allow_any_instance_of(Faraday::Response).to receive(:body) { {}.to_json }
      allow_any_instance_of(Faraday::Response).to receive(:headers) { json_headers }
      allow_any_instance_of(Faraday::Response).to receive(:success?) { false }
      allow_any_instance_of(Faraday::Connection).to receive(:post) { Faraday::Response.new }
      expect { terminal.post(path: nil, params: {}) }.to(
        raise_error(Etm::UnexpectedError)
      )
    end
  end
end
