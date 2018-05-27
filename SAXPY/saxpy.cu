#include<stdio.h>

#define N 20480

//kernel
__global__ void saxpy(float a, float *x, float *y) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < N) {
    	y[i] += a*x[i];
    }
}

int main(void) {
    float *x, *y, a, *dx, *dy;
    size_t size = N * sizeof(float);
}
