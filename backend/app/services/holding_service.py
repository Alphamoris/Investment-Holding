from sqlalchemy.orm import Session, joinedload
from app.models import Holding, Portfolio
from typing import Optional, List


class HoldingService:
    
    @staticmethod
    def get_holdings_by_portfolio(
        db: Session,
        portfolio_id: int,
        skip: int = 0,
        limit: int = 100
    ) -> List[Holding]:
        return db.query(Holding).filter(
            Holding.portfolio_id == portfolio_id
        ).offset(skip).limit(limit).all()
    
    @staticmethod
    def get_holdings_by_user(
        db: Session,
        user_id: int,
        skip: int = 0,
        limit: int = 100
    ) -> List[Holding]:
        return db.query(Holding).join(
            Portfolio, Holding.portfolio_id == Portfolio.id
        ).filter(
            Portfolio.user_id == user_id
        ).options(
            joinedload(Holding.portfolio)
        ).offset(skip).limit(limit).all()
    
    @staticmethod
    def get_all_holdings(
        db: Session,
        skip: int = 0,
        limit: int = 100
    ) -> List[Holding]:
        return db.query(Holding).options(
            joinedload(Holding.portfolio)
        ).offset(skip).limit(limit).all()
    
    @staticmethod
    def get_holding_by_id(db: Session, holding_id: int) -> Optional[Holding]:
        return db.query(Holding).filter(Holding.id == holding_id).first()
