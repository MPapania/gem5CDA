/*****************************************************************************

  Licensed to Accellera Systems Initiative Inc. (Accellera) under one or
  more contributor license agreements.  See the NOTICE file distributed
  with this work for additional information regarding copyright ownership.
  Accellera licenses this file to you under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with the
  License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
  implied.  See the License for the specific language governing
  permissions and limitations under the License.

 *****************************************************************************/

/*****************************************************************************

  tx.h -- 

  Original Author: Martin Janssen, Synopsys, Inc., 2002-02-15

 *****************************************************************************/

/*****************************************************************************

  MODIFICATION LOG - modifiers, enter your name, affiliation, date and
  changes you are making here.

      Name, Affiliation, Date:
  Description of Modification:

 *****************************************************************************/

/* Filename tx.h */
/* This is a SIO transmitter */

#include "systemc.h"

SC_MODULE( sio_tx )
{
  SC_HAS_PROCESS( sio_tx );

  sc_in_clk    clk;
  sc_in<bool>  two_stop_bits;
  sc_out<bool> tx;

  // Constructor 
  sio_tx( sc_module_name   NAME,
	  sc_clock&        CLK,
	  sc_signal<bool>& TWO_STOP_BITS,
	  sc_signal<bool>& TX )
    : two_stop_bits(TWO_STOP_BITS), tx(TX)
  {
    clk(CLK);
	SC_CTHREAD( entry, clk.pos() );
  }

  // Process functionality in member function below
  void entry();
  void byte (char byte);
  void mark(int cycles);
};
