/*
To query the number of CUDA-capable GPUs
in a host and the capabilities of each GPU. 
Run it on the Hummingbird GPU node and 
report the results.
*/

#include<stdio.h>

int main() {
    int nDevices;
    cudaGetDeviceCount(&nDevices);
    for (int i = 0; i < nDevices; i++) {
        cudaDeviceProp prop;
        cudaGetDeviceProperties(&prop, i);
        printf("GPU Num: %d\n", i);
        printf("  - GPU Name: %s\n", prop.name);
        printf("  - Mem Speed: %d\n", prop.memoryClockRate);
        printf("  - Mem Bus Width (bits): %d\n", prop.memoryBusWidth);
        float MemPeakBandWidth = 2.0 * prop.memoryClockRate * (prop.memoryBusWidth/8) / 1.0e6;
        printf("  - Mem Peak Bandwidth(GB/s): %f\n", MemPeakBandWidth);
        printf("*** Compute Capability: %d\n", prop.major);
    }
    return 0;
}
