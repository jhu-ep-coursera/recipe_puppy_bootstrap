class Recipe
    include HTTParty
        
    base_uri 'http://www.recipepuppy.com/api'
    default_params onlyImages: 1

    ## ENABLE THE FOLLOWING LINE ONCE recipepuppy.com fully working...
    # format :json

    def self.for ( keyword = 'chocolate' )
        # get('', query: { q: keyword })['results']
        ## Once recipepuppy.com fully working, you can
        ## uncomment the line above and comment out the line below
        temporary_work_around_to_account_for_error_in_httparty(keyword)
    end

    def self.temporary_work_around_to_account_for_error_in_httparty(keyword)
        response_text = get('', query: { q: keyword })
        response_text.sub!(/<!DOCTYPE.*/m, '')
        require 'json'
        JSON.parse(response_text)['results']
    end
end
