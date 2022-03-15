/*
 * Inheritance V1.mq4
 * Copyright 2020, Orchard Forex
 * https://www.orchardforex.com
 *
 */

#property copyright "Copyright 2020, Orchard Forex"
#property link      "https://www.orchardforex.com"
#property version   "1.00"
#property strict

//
//	Just here to make this compile when everything else is commented out,
//		Remove or comment out this section to try the examples
//
void OnStart() {}

/*
//	Step 1
//	Visibility of private and protected to the consuming application
class CParent {

private:
	string     ParentPrivate()			{  return(__FUNCSIG__);  }
protected:
	string     ParentProtected()		{  return(__FUNCSIG__);  }
public:
	string     ParentPublic()			{  return(__FUNCSIG__);  }

};

class CChild : public CParent {

public:
	string     ChildPublic()			{  return(__FUNCSIG__);  }

};

void OnStart() {

	CParent		*parent	=	new CParent();
	CChild		*child	=	new CChild();
	
	Print(parent.ParentPrivate());		//	Error
	Print(parent.ParentProtected());		//	Error
	Print(parent.ParentPublic());

}
//*/





/*
//	Step 2
//	Visibility of parent functions via a child class
class CParent {

private:
	string     ParentPrivate()			{  return(__FUNCSIG__);  }
protected:
	string     ParentProtected()		{  return(__FUNCSIG__);  }
public:
	string     ParentPublic()			{  return(__FUNCSIG__);  }

};

class CChild : public CParent {

public:
	string     ChildPublic()			{  return(__FUNCSIG__);  }

};

void OnStart() {

	CParent		*parent	=	new CParent();
	CChild		*child	=	new CChild();
	
	Print(parent.ParentPublic());			//	All of these work
	Print(child.ChildPublic());			//
	Print(child.ParentPublic());			//

}
//*/




/*
//	Step 3
//	Visibility of inherited parent functions inside a child class
class CParent {

private:
	string     ParentPrivate()			{  return(__FUNCSIG__);  }
protected:
	string     ParentProtected()		{  return(__FUNCSIG__);  }
public:
	string     ParentPublic()			{  return(__FUNCSIG__);  }

};

class CChild : public CParent {

public:
	string     ChildPublic()			{  return(__FUNCSIG__);  }
	void			Test() {
		ParentPrivate();					//	Error
		ParentProtected();
		ParentPublic();
	}

};

void OnStart() {

	CParent		*parent	=	new CParent();
	CChild		*child	=	new CChild();
	
	Print(parent.ParentPublic());			//	All work
	Print(child.ChildPublic());			//
	Print(child.ParentPublic());			//

}
//*/




/*
//	Step 4
//	Visibility of parent functions inside a child class containing the parent
class CParent {

private:
	string     ParentPrivate()			{  return(__FUNCSIG__);  }
protected:
	string     ParentProtected()		{  return(__FUNCSIG__);  }
public:
	string     ParentPublic()			{  return(__FUNCSIG__);  }

};

class CChild : public CParent {

public:
	string     ChildPublic()			{  return(__FUNCSIG__);  }
	void			Test() {
		ParentProtected();
		ParentPublic();
		CParent	*parent	=	new CParent();
		parent.ParentPrivate();					//	Error
		parent.ParentProtected();				//	Error
		parent.ParentPublic();
		
	}

};

void OnStart() {

	CParent		*parent	=	new CParent();
	CChild		*child	=	new CChild();
	
	Print(parent.ParentPublic());			//	All work
	Print(child.ChildPublic());			//
	Print(child.ParentPublic());			//

}
//*/




/*
//	Step 5
//	Visibility of parent inherited functions through a sub class
class CParent {

private:
	string     ParentPrivate()			{  return(__FUNCSIG__);  }
protected:
	string     ParentProtected()		{  return(__FUNCSIG__);  }
public:
	string     ParentPublic()			{  return(__FUNCSIG__);  }

};

class CChild : protected CParent {

public:
	string     ChildPublic()			{  return(__FUNCSIG__);  }
	void			Test() {
		ParentProtected();
		ParentPublic();
	}

};

class CSub : public CChild {

public:
	string     SubPublic()			{  return(__FUNCSIG__);  }
	void			Test() {
		ParentProtected();
		ParentPublic();
		ChildPublic();
	}

};

void OnStart() {

	CParent		*parent	=	new CParent();
	CChild		*child	=	new CChild();
	CSub			*sub		=	new CSub();
	
	Print(parent.ParentPublic());			// Success
	Print(child.ChildPublic());			
	Print(child.ParentPublic());			//	Error
	Print(sub.SubPublic());
	Print(sub.ChildPublic());
	Print(sub.ParentPublic());				//	Error

}
//*/




/*
//	Step 6
//	Visibility of parent private inherited functions through a sub class
class CParent {

private:
	string     ParentPrivate()			{  return(__FUNCSIG__);  }
protected:
	string     ParentProtected()		{  return(__FUNCSIG__);  }
public:
	string     ParentPublic()			{  return(__FUNCSIG__);  }

};

class CChild : CParent {

public:
	string     ChildPublic()			{  return(__FUNCSIG__);  }
	void			Test() {
		ParentProtected();
		ParentPublic();
	}

};

class CSub : public CChild {

public:
	string     SubPublic()			{  return(__FUNCSIG__);  }
	void			Test() {
		ParentProtected();					//	Error
		ParentPublic();						//	Error
		ChildPublic();
	}

};

void OnStart() {

	CParent		*parent	=	new CParent();
	CChild		*child	=	new CChild();
	CSub			*sub		=	new CSub();
	
	Print(parent.ParentPublic());			// Success
	Print(child.ChildPublic());			
	Print(child.ParentPublic());			//	Error
	Print(sub.SubPublic());
	Print(sub.ChildPublic());
	Print(sub.ParentPublic());				//	Error

}
//*/

