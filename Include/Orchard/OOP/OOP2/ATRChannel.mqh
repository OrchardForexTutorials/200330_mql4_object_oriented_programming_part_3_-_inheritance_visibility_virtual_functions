/*
 *	CciATRChannel.mqh
 *	Copyright 2013-2020, Orchard Forex
 * https://orchardforex.com
 *
 */

#property copyright "Copyright 2013-2020, Orchard Forex"
#property link      "https://orchardforex.com"
#property version   "1.00"
#property strict

#include "ChannelBase.mqh"

class CciATRChannel : public CciChannelBase {

private:

	int						mAtrPeriods;
	double					mAtrMultiplier;
	int						mMaPeriods;
	ENUM_MA_METHOD			mMaMethod;
	ENUM_APPLIED_PRICE	mMaAppliedPrice;

	
protected:

	virtual void			UpdateValues(int bars, int limit);


public:

	CciATRChannel();
	CciATRChannel(string symbol, ENUM_TIMEFRAMES timeframe, int atrPeriods, double atrMultiplier, int maPeriods, ENUM_MA_METHOD maMethod, ENUM_APPLIED_PRICE maAppliedPrice);
	~CciATRChannel();
	
	void	Init(int atrPeriods, double atrMultiplier, int maPeriods, ENUM_MA_METHOD maMethod, ENUM_APPLIED_PRICE maAppliedPrice);

};

CciATRChannel::CciATRChannel() {

//	Default values
//	atrPeriods=14
//	multiplier = 1
//	ma periods = 14
//	ma method = sma
//	ma price = close

	Init(14, 1.0, 14, MODE_SMA, PRICE_CLOSE);

}

CciATRChannel::CciATRChannel(string symbol, ENUM_TIMEFRAMES timeframe, int atrPeriods, double atrMultiplier, int maPeriods, ENUM_MA_METHOD maMethod, ENUM_APPLIED_PRICE maAppliedPrice)
		:	CciChannelBase(symbol, timeframe) {

	Init(atrPeriods, atrMultiplier, maPeriods, maMethod, maAppliedPrice);
	
}

CciATRChannel::~CciATRChannel() {

}

void		CciATRChannel::Init(int atrPeriods, double atrMultiplier, int maPeriods, ENUM_MA_METHOD maMethod, ENUM_APPLIED_PRICE maAppliedPrice) {
	
	mAtrPeriods			=	atrPeriods;
	mAtrMultiplier		=	atrMultiplier;
	mMaPeriods			=	maPeriods;
	mMaMethod			=	maMethod;
	mMaAppliedPrice	=	maAppliedPrice;

	
	Update();
	
}




void		CciATRChannel::UpdateValues(int bars, int limit) {

	int	lim	=	0;
	for (int i = limit-1; i>=0; i--) {
		lim		=	(bars-i)>=mMaPeriods ? mMaPeriods : (bars-i);		//	To handle bars before the length of the channel
		mChannelMid[i]		=	iMA(mSymbol, mTimeframe, lim, 0, mMaMethod, mMaAppliedPrice, i);
		lim		=	(bars-i)>=mAtrPeriods ? mAtrPeriods : (bars-i);		//	To handle bars before the length of the channel
		double	atr		=	iATR(mSymbol, mTimeframe, lim, i);
		mChannelHigh[i]	=	mChannelMid[i]+(atr*mAtrMultiplier);
		mChannelLow[i]		=	mChannelMid[i]-(atr*mAtrMultiplier);
	}
	
	mPrevCalculated		=	bars;																		//	Reset our position in the array
	
}

