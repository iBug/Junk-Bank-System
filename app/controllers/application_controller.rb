class ApplicationController < ActionController::Base
  add_flash_types :success

  include ErrorsHelper
end
