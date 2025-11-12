from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from typing import Optional
from app.database.connection import get_db
from app.services.holding_service import HoldingService
from app.services.insight_service import InsightService
from app.schemas.holding import HoldingsListResponse

router = APIRouter(prefix="/holdings", tags=["holdings"])


@router.get("/", response_model=HoldingsListResponse)
def get_holdings(
    portfolio_id: Optional[int] = Query(None, description="Filter by portfolio ID"),
    user_id: Optional[int] = Query(None, description="Filter by user ID"),
    skip: int = Query(0, ge=0, description="Number of records to skip"),
    limit: int = Query(100, ge=1, le=1000, description="Maximum number of records to return"),
    db: Session = Depends(get_db)
):
    if portfolio_id:
        holdings = HoldingService.get_holdings_by_portfolio(db, portfolio_id, skip, limit)
    elif user_id:
        holdings = HoldingService.get_holdings_by_user(db, user_id, skip, limit)
    else:
        holdings = HoldingService.get_all_holdings(db, skip, limit)
    
    enriched_holdings = [
        InsightService.enrich_holding_with_insights(holding)
        for holding in holdings
    ]
    
    insights = InsightService.calculate_portfolio_insights(holdings)
    
    return HoldingsListResponse(
        holdings=enriched_holdings,
        insights=insights
    )


@router.get("/{holding_id}")
def get_holding(
    holding_id: int,
    db: Session = Depends(get_db)
):
    holding = HoldingService.get_holding_by_id(db, holding_id)
    if not holding:
        raise HTTPException(status_code=404, detail="Holding not found")
    
    return InsightService.enrich_holding_with_insights(holding)
