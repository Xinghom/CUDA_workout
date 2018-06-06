#include<stdio.h>

#define ROW 1000
#define COL 1000

__global__ void mat_vect(int *a, int *b, int *c, int m, int n) {
    int row = blockIdx.y * blockDim.y + threadIdx.y; 
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    int sum = 0;
    if( col < n && row < m) 
    {
        for(int i = 0; i < n; i++) 
        {
            sum += a[row * n + i] * b[i];
        }
        c[col] = sum;
    }
}

void TestMatrixGenerate(int *matrix, int row, int col) {
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            matrix[i * col + j] = (j + 1) + i * col; 
            printf("%d ", matrix[i*col + j];)
        }
        printf("\n");
    }
}

int main() {
    int* matrix;
    TestMatrixGenerate((int*) matrix, ROW, COL);
    
    

    return 0;
}