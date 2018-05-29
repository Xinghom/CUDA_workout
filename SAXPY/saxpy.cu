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
    
    cudaMalloc((void **) &dx, size);
    cudaMalloc((void **) &dy, size);

    cudaMemcpy(dx, x, size, cudaMemcpyHostToDevice);
    cudaMemcpy(dy, y, size, cudaMemcpyHostToDevice);

    saxpy<<<N/256, 256>>>(a, dx, dy);

    cudaMemcpy(y, dy, size, cudaMemcpyDeviceToHost);
    printf("value of y: %d", y);
    cudaFree(dx);
    cudaFree(dy);
}
