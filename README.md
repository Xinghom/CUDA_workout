# CUDA Workout

## Catalogue
1. GPU Properties query
2. Matrix multiply Vector
3. Dot product acceleration

-----------------

### GPU Query
On Hummingbird GPU Node

Results:
    

    GPU Num: 0
    - GPU Name: Tesla P100-PCIE-16GB
    - Mem Speed: 715000
    - Mem Bus Width (bits): 4096
    - Mem Peak Bandwidth(GB/s): 732.159973
    *** Compute Capability: 6
    GPU Num: 1
    - GPU Name: Tesla P100-PCIE-16GB
    - Mem Speed: 715000
    - Mem Bus Width (bits): 4096
    - Mem Peak Bandwidth(GB/s): 732.159973
    *** Compute Capability: 6
    GPU Num: 2
    - GPU Name: Tesla P100-PCIE-16GB
    - Mem Speed: 715000
    - Mem Bus Width (bits): 4096
    - Mem Peak Bandwidth(GB/s): 732.159973
    *** Compute Capability: 6
--------------
### Matrix-Vector Multiplication

---------------
### Dot product acceleration

Array X Dot product Array Y. \
The length is 2^20 for each array.

> Results from 187.41ms to  3.96ms
- 1 thread

 ```   
==36812== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:  100.00%  187.41ms         1  187.41ms  187.41ms  187.41ms  add(int, float*, float*)
      API calls:   79.68%  742.85ms         2  371.42ms  121.79us  742.73ms  cudaMallocManaged
                   20.10%  187.42ms         1  187.42ms  187.42ms  187.42ms  cudaDeviceSynchronize
                    0.07%  676.19us         2  338.09us  320.94us  355.24us  cudaFree
                    0.07%  658.87us        94  7.0090us     203ns  272.93us  cuDeviceGetAttribute
                    0.05%  431.22us         1  431.22us  431.22us  431.22us  cuDeviceTotalMem
                    0.02%  170.65us         1  170.65us  170.65us  170.65us  cudaLaunch
                    0.01%  100.92us         1  100.92us  100.92us  100.92us  cuDeviceGetName
                    0.00%  16.491us         3  5.4970us     398ns  15.063us  cudaSetupArgument
                    0.00%  4.1550us         3  1.3850us     233ns  2.8080us  cuDeviceGetCount
                    0.00%  4.1220us         2  2.0610us     655ns  3.4670us  cuDeviceGet
                    0.00%  3.4490us         1  3.4490us  3.4490us  3.4490us  cudaConfigureCall

==36812== Unified Memory profiling result:
Device "Tesla P100-PCIE-16GB (0)"
   Count  Avg Size  Min Size  Max Size  Total Size  Total Time  Name
      48  170.67KB  4.0000KB  0.9961MB  8.000000MB  763.2000us  Host To Device
      24  170.67KB  4.0000KB  0.9961MB  4.000000MB  345.0560us  Device To Host
      12         -         -         -           -  4.953280ms  Gpu page fault groups
Total CPU Page faults: 36
```

- Accelerated

```
==219585== Profiling application: ./saxpy
==219585== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:  100.00%  3.9622ms         1  3.9622ms  3.9622ms  3.9622ms  add(int, float*, float*)
      API calls:   99.19%  698.74ms         2  349.37ms  118.12us  698.62ms  cudaMallocManaged
                    0.56%  3.9677ms         1  3.9677ms  3.9677ms  3.9677ms  cudaDeviceSynchronize
                    0.09%  658.84us        94  7.0080us     200ns  267.35us  cuDeviceGetAttribute
                    0.09%  637.94us         2  318.97us  267.14us  370.81us  cudaFree
                    0.04%  310.30us         1  310.30us  310.30us  310.30us  cuDeviceTotalMem
                    0.01%  71.692us         1  71.692us  71.692us  71.692us  cudaLaunch
                    0.01%  57.491us         1  57.491us  57.491us  57.491us  cuDeviceGetName
                    0.00%  13.424us         3  4.4740us     156ns  12.645us  cudaSetupArgument
                    0.00%  2.9780us         3     992ns     220ns  2.1550us  cuDeviceGetCount
                    0.00%  2.5620us         2  1.2810us     256ns  2.3060us  cuDeviceGet
                    0.00%  2.2720us         1  2.2720us  2.2720us  2.2720us  cudaConfigureCall

==219585== Unified Memory profiling result:
Device "Tesla P100-PCIE-16GB (0)"
   Count  Avg Size  Min Size  Max Size  Total Size  Total Time  Name
      48  170.67KB  4.0000KB  0.9961MB  8.000000MB  756.1920us  Host To Device
      24  170.67KB  4.0000KB  0.9961MB  4.000000MB  342.4960us  Device To Host
      13         -         -         -           -  2.940096ms  Gpu page fault groups
Total CPU Page faults: 36
```

    
    