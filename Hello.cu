#include <stdio.h>

__global__ void mykernel(void) {

}

int main(void) {
	mykernel<<<1,1>>>();
	printf("Hey, CUDA world!\n" );
	return 0;
}
