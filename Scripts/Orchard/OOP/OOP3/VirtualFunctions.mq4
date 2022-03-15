/*
 * VirtualFunctions.mq4
 * Copyright 2020, Orchard Forex
 * https://www.orchardforex.com
 *
 */

#property copyright "Copyright 2020, Orchard Forex"
#property link      "https://www.orchardforex.com"
#property version   "1.00"
#property strict

class CParent {

public:
	string            Function1()			{  return(__FUNCSIG__);  }
	virtual string    Function2()			{  return(__FUNCSIG__);  }

};

class CChild : public CParent {

public:
	string     Function1()			{  return(__FUNCSIG__);  }
	string     Function2()			{  return(__FUNCSIG__);  }

};

void OnStart() {

	CParent	*parent	=	new CParent();
	CChild	*child	=	new CChild();
	CParent	*parent2	=	new CChild();
	
	Print("parent.Function1()=" + parent.Function1());
	Print("child.Function1()=" + child.Function1());
	Print("parent2.Function1()=" + parent2.Function1());
	
	Print("parent.Function2()=" + parent.Function2());
	Print("child.Function2()=" + child.Function2());
	Print("parent2.Function2()=" + parent2.Function2());
	
	delete	child;
	delete	parent;
	delete	parent2;
	
}

