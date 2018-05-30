// Adds the elements of 2 arrays with
// a million elements each.

#include <iostream>
#include <math.h>

// __global__ 
void add(int n, float *x, float *y) {
    for (int i = 0; i < n; i++)
        y[i] = x[i] + y[i];
}

int main(void) {    
    int N = 1 << 20; // = 1M elements;
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
}