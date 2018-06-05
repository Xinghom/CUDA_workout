// Adds the elements of 2 arrays with
// a million elements each.

#include <iostream>
#include <math.h>


//kernel
__global__ void add(int n, float *x, float *y) {
    int index = threadIdx.x;
    int stride = blockDim.x;

    for (int i = index; i < n; i += stride)
        y[i] = x[i] + y[i];
}

int main(void) {    
    int N = 1 << 20; // = 1M elements;
    
    
    /* --- CPU Version ----
    float *x = new float[N];
    float *y = new float[N];

    //init x and y arrays on the host
    for (int i = 0; i < N; i++) {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }
    
    // run add() on CPU (HOST)
    add(N, x, y);

    //Check for errors, == 3.0f?
    float maxError = 0.0f;
    for(int i = 0; i < N; i++) {
        maxError = fmax(maxError, fabs(y[i] - 3.0f));
    }
    std::cout << "MAX Error: " << maxError << std::endl;

    // free mem
    delete [] x;
    delete [] y;
    return 0;
    */
    
    // Allocate Unified Memory -- accessible from CPU or GPU
    float *x, *y;
    cudaMallocManaged(&x, N*sizeof(float));
    cudaMallocManaged(&y, N*sizeof(float));

    // init x and y on the host
    for (int i = 0; i < N; i++) {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    add<<<1,256>>>(N, x, y);

    //wait for GPU
    cudaDeviceSynchronize();

    // Check for errors (all values should be 3.0f)
    float maxError = 0.0f;
    for (int i = 0; i < N; i++) 
        maxError = fmax(maxError, fabs(y[i] - 3.0f));
    std::cout << "Max Error: " << maxError << std::endl;

    // free Mem
    cudaFree(x);
    cudaFree(y);
    return 0;




    // cudaMalloc((void **) &da, size);
    // cudaMalloc((void **) &db, size);
    // cudaMalloc((void **) &dc, size);

    // //setup input values
    // a = 2;
    // b = 7;

    // cudaMemcpy(da, &a, size, cudaMemcpyHostToDevice);
    // cudaMemcpy(db, &b, size, cudaMemcpyHostToDevice);

    // add<<<1, 1>>>(da, db, dc);

    // cudaMemcpy(&c, dc, size, cudaMemcpyDeviceToHost);

    // printf("Value of c: %d", c);
    // cudaFree(da);
    // cudaFree(db);
    // cudaFree(dc);
    // return 0;
}
