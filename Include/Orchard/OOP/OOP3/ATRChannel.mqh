/*
 *	CciATRChannel.mqh
 *	Copyright 2013-2020, Orchard Forex
 * https://orchardforex.com
 *
 */

/**=
 *
 * Disclaimer and Licence
 *
 * This file is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * All trading involves risk. You should have received the risk warnings
 * and terms of use in the README.MD file distributed with this software.
 * See the README.MD file for more information and before using this software.
 *
 **/
#property copyright "Copyright 2013-2020, Orchard Forex"
#property link "https://orchardforex.com"
#property version "1.00"
#property strict

#include "ChannelBase.mqh"

class CciATRChannel : public CciChannelBase
{

private:
   int                mAtrPeriods;
   double             mAtrMultiplier;
   int                mMaPeriods;
   ENUM_MA_METHOD     mMaMethod;
   ENUM_APPLIED_PRICE mMaAppliedPrice;

protected:
   virtual void UpdateValues( int bars, int limit );

public:
   CciATRChannel();
   CciATRChannel( string symbol, ENUM_TIMEFRAMES timeframe, int atrPeriods, double atrMultiplier, int maPeriods, ENUM_MA_METHOD maMethod, ENUM_APPLIED_PRICE maAppliedPrice );
   ~CciATRChannel();

   void Init( int atrPeriods, double atrMultiplier, int maPeriods, ENUM_MA_METHOD maMethod, ENUM_APPLIED_PRICE maAppliedPrice );
};

CciATRChannel::CciATRChannel() {

   //	Default values
   //	atrPeriods=14
   //	multiplier = 1
   //	ma periods = 14
   //	ma method = sma
   //	ma price = close

   Init( 14, 1.0, 14, MODE_SMA, PRICE_CLOSE );
}

CciATRChannel::CciATRChannel( string symbol, ENUM_TIMEFRAMES timeframe, int atrPeriods, double atrMultiplier, int maPeriods, ENUM_MA_METHOD maMethod, ENUM_APPLIED_PRICE maAppliedPrice )
   : CciChannelBase( symbol, timeframe ) {

   Init( atrPeriods, atrMultiplier, maPeriods, maMethod, maAppliedPrice );
}

CciATRChannel::~CciATRChannel() {
}

void CciATRChannel::Init( int atrPeriods, double atrMultiplier, int maPeriods, ENUM_MA_METHOD maMethod, ENUM_APPLIED_PRICE maAppliedPrice ) {

   mAtrPeriods     = atrPeriods;
   mAtrMultiplier  = atrMultiplier;
   mMaPeriods      = maPeriods;
   mMaMethod       = maMethod;
   mMaAppliedPrice = maAppliedPrice;

   Update();
}

void CciATRChannel::UpdateValues( int bars, int limit ) {

   int lim = 0;
   for ( int i = limit - 1; i >= 0; i-- ) {
      lim             = ( bars - i ) >= mMaPeriods ? mMaPeriods : ( bars - i ); //	To handle bars before the length of the channel
      mChannelMid[i]  = iMA( mSymbol, mTimeframe, lim, 0, mMaMethod, mMaAppliedPrice, i );
      lim             = ( bars - i ) >= mAtrPeriods ? mAtrPeriods : ( bars - i ); //	To handle bars before the length of the channel
      double atr      = iATR( mSymbol, mTimeframe, lim, i );
      mChannelHigh[i] = mChannelMid[i] + ( atr * mAtrMultiplier );
      mChannelLow[i]  = mChannelMid[i] - ( atr * mAtrMultiplier );
   }

   mPrevCalculated = bars; //	Reset our position in the array
}
