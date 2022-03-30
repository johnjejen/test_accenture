class IndexController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :authenticate_user!

    def index
    end
end
