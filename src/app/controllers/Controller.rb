require_relative "../models/market/Catalogue.rb"
require_relative "../views/display/Market.rb"
require_relative "../views/display/Briefing.rb"
require_relative "../views/display/Portfolio.rb"
require_relative "../views/display/TradeLog.rb"
require_relative "../views/display/Help.rb"
require_relative "../views/Trading.rb"

module Controllers
    module Controller
        include Views
        
        # show briefing
        def briefing
            Display::Briefing.show
        end
        
        # show live market feed - market view yields to model through block to fetch new prices
        def show_market
            Display::Market.show {::Market::Catalogue.price_list}
        end
        
        # show portfolio - portfolio view yields to model through block to fetch new prices
        def show_portfolio(user)
            Display::Portfolio.show(user) {::Market::Catalogue.price_list}
        end

        # trading platform - trades yielded to block to be saved in portfolio file
        def trading_platform(user,quick)
            Trading.get_trade(user, quick) {|trade| user.execute_trade(trade)}
        end

        # show trade log - all trades ever executed in the portfolio
        def show_log(user)
            Display::TradeLog.show(user)
        end

        # show application help
        def show_help
            Display::Help.show
        end
    end
end