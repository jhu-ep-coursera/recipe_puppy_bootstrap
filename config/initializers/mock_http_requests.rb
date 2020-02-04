if Rails.configuration.use_mocks_please
    require 'webmock'
    include WebMock::API

    WebMock.enable!

    stub_request(:get, /chocolate/).
        to_return(body: File.new("#{Rails.root}/spec/mocks/chocolate.json"), status: 200)

    stub_request(:get, /amarula/).
        to_return(body: File.new("#{Rails.root}/spec/mocks/amarula.json"), status: 200)
    
    stub_request(:get, /bread/).
        to_return(body: File.new("#{Rails.root}/spec/mocks/bread.json"), status: 200)
end