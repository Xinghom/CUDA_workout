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
            printf("cur sum: %d\n", sum);
        }
	printf("col value is : %d\n", col);
	printf("sum value: %d\n", sum);
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
    int res[COL];

    int *ptr_m, *ptr_v, *ptr_res;
    ptr_m = m;
    ptr_v = v;
    ptr_res = res;
    TestMatrixGenerate(ptr_m, ROW, COL);
    TestVectorGenerate(ptr_v, ROW);
    
    int *d_m, *d_v;
    int *d_res;
    cudaMallocManaged(&d_m, ROW*COL*sizeof(int));
    cudaMallocManaged(&d_v, ROW*sizeof(int));
    cudaMallocManaged(&d_res, ROW*sizeof(int));
    // init d_m, d_v on the host
    //TestMatrixGenerate(d_m, ROW, COL);
    //TestVectorGenerate(d_v, ROW);
    int blockSize = 256;
    mat_vect<<<1, blockSize>>>(d_m, d_v, d_res, ROW, COL);
    
    cudaDeviceSynchronize();
    
    // result verify
    printf("the front 10 elements results: \n");
    for (int i = 0; i < 10; i++) {
    	printf("%d ", d_res[i]);
    }   
    
    cudaFree(d_m);
    cudaFree(d_v);
    cudaFree(d_res);
    return 0;
}
