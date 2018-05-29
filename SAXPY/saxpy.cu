#include<stdio.h>

#define N 2048

//kernel
__global__ void saxpy(float a, float *x, float *y) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < N) {
    	y[i] += a*x[i];
    }
}

__global__ void add(int *a, int *b, int *c) {
    *c = *a + *b;
}
int main(void) {    
    int a, b, c; //host copies
    int *da, *db, *dc;
    int size = sizeof(int);



    cudaMalloc((void **) &da, size);
    cudaMalloc((void **) &db, size);
    cudaMalloc((void **) &dc, size);

    //setup input values
    a = 2;
    b = 7;

    cudaMemcpy(da, &a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(db, &b, size, cudaMemcpyHostToDevice);

    add<<<1, 1>>>(da, db, dc);

    cudaMemcpy(&c, dc, size, cudaMemcpyDeviceToHost);

    printf("Value of c: %d", c);
    cudaFree(da);
    cudaFree(db);
    cudaFree(dc);
    return 0;
}
