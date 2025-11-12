from datetime import datetime, timedelta
from decimal import Decimal
import random
from app.database.connection import SessionLocal
from app.models import User, Portfolio, Holding


def seed_data():
    db = SessionLocal()
    
    try:
        existing_users = db.query(User).first()
        if existing_users:
            print("Database already seeded. Skipping...")
            return
        
        users_data = [
            {"email": "john.doe@example.com", "name": "John Doe"},
            {"email": "jane.smith@example.com", "name": "Jane Smith"},
            {"email": "mike.johnson@example.com", "name": "Mike Johnson"},
        ]
        
        users = []
        for user_data in users_data:
            user = User(**user_data)
            db.add(user)
            users.append(user)
        
        db.commit()
        
        portfolios_data = [
            {"user_id": users[0].id, "name": "Growth Portfolio", "description": "Long-term growth focused investments"},
            {"user_id": users[0].id, "name": "Dividend Portfolio", "description": "Income generating investments"},
            {"user_id": users[1].id, "name": "Tech Portfolio", "description": "Technology sector investments"},
            {"user_id": users[2].id, "name": "Diversified Portfolio", "description": "Balanced investment portfolio"},
        ]
        
        portfolios = []
        for portfolio_data in portfolios_data:
            portfolio = Portfolio(**portfolio_data)
            db.add(portfolio)
            portfolios.append(portfolio)
        
        db.commit()
        
        stocks_data = [
            {"symbol": "AAPL", "name": "Apple Inc.", "asset_type": "Stock"},
            {"symbol": "MSFT", "name": "Microsoft Corporation", "asset_type": "Stock"},
            {"symbol": "GOOGL", "name": "Alphabet Inc.", "asset_type": "Stock"},
            {"symbol": "AMZN", "name": "Amazon.com Inc.", "asset_type": "Stock"},
            {"symbol": "TSLA", "name": "Tesla Inc.", "asset_type": "Stock"},
            {"symbol": "NVDA", "name": "NVIDIA Corporation", "asset_type": "Stock"},
            {"symbol": "META", "name": "Meta Platforms Inc.", "asset_type": "Stock"},
            {"symbol": "BRK.B", "name": "Berkshire Hathaway Inc.", "asset_type": "Stock"},
            {"symbol": "JNJ", "name": "Johnson & Johnson", "asset_type": "Stock"},
            {"symbol": "V", "name": "Visa Inc.", "asset_type": "Stock"},
        ]
        
        etf_data = [
            {"symbol": "SPY", "name": "SPDR S&P 500 ETF Trust", "asset_type": "ETF"},
            {"symbol": "QQQ", "name": "Invesco QQQ Trust", "asset_type": "ETF"},
            {"symbol": "VTI", "name": "Vanguard Total Stock Market ETF", "asset_type": "ETF"},
        ]
        
        crypto_data = [
            {"symbol": "BTC", "name": "Bitcoin", "asset_type": "Cryptocurrency"},
            {"symbol": "ETH", "name": "Ethereum", "asset_type": "Cryptocurrency"},
        ]
        
        all_assets = stocks_data + etf_data + crypto_data
        
        holdings = []
        for portfolio in portfolios:
            num_holdings = random.randint(3, 8)
            selected_assets = random.sample(all_assets, num_holdings)
            
            for asset in selected_assets:
                purchase_price = Decimal(str(round(random.uniform(50, 500), 2)))
                price_change_pct = random.uniform(-0.3, 0.5)
                current_price = purchase_price * Decimal(str(1 + price_change_pct))
                current_price = current_price.quantize(Decimal('0.01'))
                
                quantity = Decimal(str(round(random.uniform(1, 100), 4)))
                if asset["asset_type"] == "Cryptocurrency":
                    quantity = Decimal(str(round(random.uniform(0.1, 5), 8)))
                
                purchase_date = datetime.now() - timedelta(days=random.randint(30, 730))
                
                holding = Holding(
                    portfolio_id=portfolio.id,
                    symbol=asset["symbol"],
                    name=asset["name"],
                    quantity=quantity,
                    purchase_price=purchase_price,
                    current_price=current_price,
                    asset_type=asset["asset_type"],
                    purchase_date=purchase_date
                )
                holdings.append(holding)
                db.add(holding)
        
        db.commit()
        
        print(f"Successfully seeded database with:")
        print(f"  - {len(users)} users")
        print(f"  - {len(portfolios)} portfolios")
        print(f"  - {len(holdings)} holdings")
        
    except Exception as e:
        print(f"Error seeding database: {e}")
        db.rollback()
    finally:
        db.close()


if __name__ == "__main__":
    seed_data()
