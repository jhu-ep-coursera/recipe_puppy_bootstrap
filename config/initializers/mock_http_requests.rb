if Rails.configuration.use_mocks_please
    require 'webmock'
    include WebMock::API

    WebMock.enable!

    stub_request(:get, /recipepuppy\.com\/api\//).
        to_return { |request|
            matched_result = request.uri.query.match(/q=(.*)/)
            { body: File.new("#{Rails.root}/spec/mocks/#{matched_result[1]}.json"), status: 200 }
        }             
end