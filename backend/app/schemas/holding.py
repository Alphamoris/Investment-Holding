from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional
from decimal import Decimal


class HoldingBase(BaseModel):
    symbol: str
    name: str
    quantity: Decimal
    purchase_price: Decimal
    current_price: Decimal
    asset_type: str
    purchase_date: datetime


class HoldingCreate(HoldingBase):
    portfolio_id: int


class HoldingResponse(HoldingBase):
    id: int
    portfolio_id: int
    created_at: datetime
    updated_at: Optional[datetime] = None
    
    class Config:
        from_attributes = True


class HoldingWithInsights(HoldingResponse):
    total_cost: Decimal
    current_value: Decimal
    gain_loss: Decimal
    gain_loss_percentage: Decimal


class PortfolioInsights(BaseModel):
    total_holdings: int
    total_cost: Decimal
    total_current_value: Decimal
    total_gain_loss: Decimal
    total_gain_loss_percentage: Decimal
    best_performer: Optional[str] = None
    worst_performer: Optional[str] = None
    asset_allocation: dict[str, Decimal]


class HoldingsListResponse(BaseModel):
    holdings: list[HoldingWithInsights]
    insights: PortfolioInsights
    
    class Config:
        from_attributes = True
