module StatsHelper
  HOME_MODELS = [Branch, Department, Staff, Client, Account, Loan]
  HOME_SVGS = %w[dollar-square department manager user credit-card debt]

  private_constant :HOME_MODELS, :HOME_SVGS

  def home_cards
    HOME_MODELS.zip HOME_SVGS
  end
end
