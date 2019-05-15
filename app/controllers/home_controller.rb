class HomeController < ApplicationController

    skip_before_action :login_require
    skip_before_action :authrized

    def index
    end
end
