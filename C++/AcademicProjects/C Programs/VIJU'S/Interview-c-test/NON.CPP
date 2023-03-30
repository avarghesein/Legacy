#include <iostream.h>

class fig2d
{
	int dim1;
	int dim2;

public:
	fig2d() { dim1=5; dim2=6;}

	virtual void operator<<(ostream & rhs);
};

void fig2d::operator<<(ostream &rhs)
{
	rhs <<this->dim1<<" "<<this->dim2<<" ";
}

/*class fig3d : public fig2d
{
	int dim3;
public:
	fig3d() { dim3=7;}
	virtual void operator<<(ostream &rhs);
};
void fig3d::operator<<(ostream &rhs)
{
	fig2d::operator <<(rhs);
	rhs<<this->dim3;
}
*/

void main()
{
	fig2d obj1;
//	fig3d obj2;

	obj1 << cout;
//	obj2 << cout;
}
/*
