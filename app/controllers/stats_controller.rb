class StatsController < ApplicationController
  def home
    @cards = [Branch, Department, Staff, Client, Account, Loan].zip \
      %w[dollar-square department manager user credit-card debt]
  end

  def index
  end
end
