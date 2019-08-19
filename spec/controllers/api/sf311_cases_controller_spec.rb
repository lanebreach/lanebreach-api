# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Sf311CasesController, type: :controller do
  describe '#create' do
    let(:data) do
      {
        "service_request_id": '1020002836',
        "status": 'open',
        "service_name": 'Blocked Driveway & Illegal Parking',
        "service_code": '5a6b5ac2d0521c1134854b01',
        "description": '[Bus] Kyle',
        "requested_datetime": '2019-06-19T20:18:06-07:00',
        "updated_datetime": '2019-06-19T20:18:06-07:00',
        "address": '471 Jessie St, San Francisco',
        "lat": 37.781892550575705,
        "long": -122.4084929351361,
        "media_url": 'http://mobile311-dev.sfgov.org/media/san_francisco/report/photos/5d0afadbe896c8645baae415/19EFB8CE-386D-4B14-8300-116558270332.png'
      }
    end

    it 'Creates a new Sf311Case' do
      # post :create, :params => { data }

      post :create, params: { sf311_case: data, format: :json }

      expect(response.content_type).to eq 'application/json'
      expect(Sf311Case.count).to eq 1
    end
  end
end
