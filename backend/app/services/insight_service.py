from decimal import Decimal
from typing import List, Dict
from app.models import Holding
from app.schemas.holding import HoldingWithInsights, PortfolioInsights


class InsightService:
    
    @staticmethod
    def calculate_holding_insights(holding: Holding) -> dict:
        total_cost = holding.quantity * holding.purchase_price
        current_value = holding.quantity * holding.current_price
        gain_loss = current_value - total_cost
        gain_loss_percentage = (gain_loss / total_cost * 100) if total_cost > 0 else Decimal(0)
        
        return {
            "total_cost": total_cost,
            "current_value": current_value,
            "gain_loss": gain_loss,
            "gain_loss_percentage": gain_loss_percentage
        }
    
    @staticmethod
    def enrich_holding_with_insights(holding: Holding) -> HoldingWithInsights:
        insights = InsightService.calculate_holding_insights(holding)
        
        return HoldingWithInsights(
            id=holding.id,
            portfolio_id=holding.portfolio_id,
            symbol=holding.symbol,
            name=holding.name,
            quantity=holding.quantity,
            purchase_price=holding.purchase_price,
            current_price=holding.current_price,
            asset_type=holding.asset_type,
            purchase_date=holding.purchase_date,
            created_at=holding.created_at,
            updated_at=holding.updated_at,
            total_cost=insights["total_cost"],
            current_value=insights["current_value"],
            gain_loss=insights["gain_loss"],
            gain_loss_percentage=insights["gain_loss_percentage"]
        )
    
    @staticmethod
    def calculate_portfolio_insights(holdings: List[Holding]) -> PortfolioInsights:
        if not holdings:
            return PortfolioInsights(
                total_holdings=0,
                total_cost=Decimal(0),
                total_current_value=Decimal(0),
                total_gain_loss=Decimal(0),
                total_gain_loss_percentage=Decimal(0),
                asset_allocation={}
            )
        
        total_cost = Decimal(0)
        total_current_value = Decimal(0)
        asset_allocation: Dict[str, Decimal] = {}
        
        best_performer = None
        worst_performer = None
        best_gain_pct = Decimal('-inf')
        worst_gain_pct = Decimal('inf')
        
        for holding in holdings:
            insights = InsightService.calculate_holding_insights(holding)
            
            total_cost += insights["total_cost"]
            total_current_value += insights["current_value"]
            
            if holding.asset_type not in asset_allocation:
                asset_allocation[holding.asset_type] = Decimal(0)
            asset_allocation[holding.asset_type] += insights["current_value"]
            
            if insights["gain_loss_percentage"] > best_gain_pct:
                best_gain_pct = insights["gain_loss_percentage"]
                best_performer = holding.symbol
            
            if insights["gain_loss_percentage"] < worst_gain_pct:
                worst_gain_pct = insights["gain_loss_percentage"]
                worst_performer = holding.symbol
        
        total_gain_loss = total_current_value - total_cost
        total_gain_loss_percentage = (
            (total_gain_loss / total_cost * 100) if total_cost > 0 else Decimal(0)
        )
        
        return PortfolioInsights(
            total_holdings=len(holdings),
            total_cost=total_cost,
            total_current_value=total_current_value,
            total_gain_loss=total_gain_loss,
            total_gain_loss_percentage=total_gain_loss_percentage,
            best_performer=best_performer,
            worst_performer=worst_performer,
            asset_allocation=asset_allocation
        )
