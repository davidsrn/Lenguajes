// David Ramirez A01206423
#include <stdio.h>
#include <stdlib.h>
#include "cuda_runtime.h"

#define N 10
#define M 10
#define WIDTH 2

// Device mat mult
__global__ void MatrixMul(float *darray_1, float *darray_2 , float *dres_arr, int n){
  // cols and rows definition
  int col = threadIdx.x + blockIdx.x * blockDim.x;
  int row = threadIdx.y + blockIdx.y * blockDim.y;
  // Mat mult operation
  for(int i = 0; i<n; i++){
    dres_arr[row*n+col]+= darray_1[row*n+i]*darray_2[col+i*n];
    // printf("row %i * height %i col %i index %i res %f\n", row, n, col, i, dres_arr[row*n+col]);
  }
}

int main(){
  float ThreadsPerBlock = 16;
  float NumBlocks = (ThreadsPerBlock + (N*M-1))/ThreadsPerBlock;
  float array_1[WIDTH][WIDTH] ,array_2[WIDTH][WIDTH], res_arr_m[WIDTH][WIDTH];
  float *darray_1 , *darray_2 ,*dres_arr;
  //Fill arrays
  // for(int i = 0; i<WIDTH ; i++){
  //    for(int j = 0; j<WIDTH ; j++){
  //       array_1[i][j] = 2;
  //       array_2[i][j] = 2;
  //    }
  // }
  printf("original mats\n");

  array_1[0][0] = 1;
  array_1[0][1] = 2;
  array_1[1][0] = 3;
  array_1[1][1] = 4;

  array_2[0][0] = 4;
  array_2[0][1] = 5;
  array_2[1][0] = 6;
  array_2[1][1] = 7;
// print array values
  for(int i = 0; i<WIDTH; i++){
    for(int j = 0; j < WIDTH; j++){
      printf("%f ", array_1[i][j]);
    }
    printf("\n");
  }
  printf("\n");
  for(int i = 0; i<WIDTH; i++){
    for(int j = 0; j < WIDTH; j++){
      printf("%f ", array_2[i][j]);
    }
    printf("\n");
  }
  printf("\n");

// Create device arrays
  cudaMalloc((void**) &darray_1, WIDTH*WIDTH*sizeof(int));
  cudaMalloc((void**) &darray_2, WIDTH*WIDTH*sizeof(int));

// Send arrays to device
  cudaMemcpy(darray_1, array_1, WIDTH*WIDTH*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(darray_2, array_2, WIDTH*WIDTH*sizeof(int), cudaMemcpyHostToDevice);

// Save device space for res array
  cudaMalloc((void**) &dres_arr, WIDTH*WIDTH*sizeof(int));

// Call kernel
  dim3 Blocks(NumBlocks,NumBlocks);
  dim3 Threads(ThreadsPerBlock,ThreadsPerBlock);

  MatrixMul<<<Blocks,Threads>>>(darray_1, darray_2, dres_arr, WIDTH);

// Save result to host
  cudaMemcpy(res_arr_m , dres_arr, WIDTH*WIDTH*sizeof(int), cudaMemcpyDeviceToHost);

// Print res
  printf("result\n");
  for(int i = 0; i<WIDTH; i++){
    for(int j = 0; j < WIDTH; j++){
      printf("%f ", res_arr_m[i][j]);
    }
    printf("\n");
  }
}
