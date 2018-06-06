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

void TestMatrixGenerate(int* matrix, int row, int col) {
    //printf("Row: %d", row);
    //printf("Col: %d", col);
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            matrix[i * col + j] = (j + 1) + i * col; 
      	    //printf("%d ", matrix[i*col + j]);
        }
        //printf("\n");
    }
}

void TestVectorGenerate(int* vector, int row) {
    for(int i = 0; i < row; i++) {
	vector[i] = i * 2;
 	//printf("%d ", vector[i]);
    }
}

int main() {
    int m[ROW*COL];
    int v[COL];

    int *ptr_m, *ptr_v;
    ptr_m = m;
    ptr_v = v;
    TestMatrixGenerate(ptr_m, ROW, COL);
    TestVectorGenerate(ptr_v, ROW);
    

    return 0;
}
