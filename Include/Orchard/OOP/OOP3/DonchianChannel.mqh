/*
 *	CciDonchianChannel.mqh
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

class CciDonchianChannel : public CciChannelBase
{

private:
   int mDonchianPeriods;

protected:
   virtual void UpdateValues( int bars, int limit );

public:
   CciDonchianChannel();
   CciDonchianChannel( string symbol, ENUM_TIMEFRAMES timeframe, int donchianPeriods );
   ~CciDonchianChannel();

   void Init( int donchianPeriods );
};

CciDonchianChannel::CciDonchianChannel() {

   //	Default values
   //	donchianPeriods=20

   Init( 20 );
}

CciDonchianChannel::CciDonchianChannel( string symbol, ENUM_TIMEFRAMES timeframe, int donchianPeriods )
   : CciChannelBase( symbol, timeframe ) {

   Init( donchianPeriods );
}

CciDonchianChannel::~CciDonchianChannel() {
}

void CciDonchianChannel::Init( int donchianPeriods ) {

   mDonchianPeriods = donchianPeriods;

   Update();
}

void CciDonchianChannel::UpdateValues( int bars, int limit ) {

   int lim = 0;
   for ( int i = limit - 1; i >= 0; i-- ) {
      lim             = ( bars - i ) >= mDonchianPeriods ? mDonchianPeriods : ( bars - i ); //	To handle bars before the length of the channel
      mChannelHigh[i] = iHigh( mSymbol, mTimeframe, iHighest( mSymbol, mTimeframe, MODE_HIGH, lim, i ) );
      mChannelLow[i]  = iLow( mSymbol, mTimeframe, iLowest( mSymbol, mTimeframe, MODE_LOW, lim, i ) );
      mChannelMid[i]  = ( mChannelHigh[i] + mChannelLow[i] ) / 2;
   }

   mPrevCalculated = bars; //	Reset our position in the array
}
