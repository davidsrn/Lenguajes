// David Ramirez A01206423
#include <stdio.h>
#include <stdlib.h>
#include "cuda_runtime.h"

#define RECTS 1e9
#define BLOCKS 1000
#define THREADS 512

// long num_rects = 100000, i;
// double mid, height, width, area;
// sum = 0.0;
// width = 1.0 / (double) num_rects;
// for (i = 0; i < num_rects; i++){
//   mid = (i + 0.5) * width;
//   height = 4.0 / (1.0 + mid * mid);
//   sum += height;
// }
// area = width * sum;


//This function is for the GPU:
__global__ void piCalc(double *area, double width, int rects) {
	double mid, height;
	// Get our index
	int index = threadIdx.x + (blockIdx.x * blockDim.x);
	// Pos in array
	int id = index;
	// do while we are inside our array
	while(index<rects){
		//Original pi algo
		mid = (index + 0.5) * width;
    height = 4.0 / (1.0 + mid * mid);
		area[id] += height;
		// Move our index
		index += (blockDim.x*gridDim.x);
	}
}

int main(){
	// Normal Array
	double *pi;
	// GPU Array
	double *d_pi;
	// Dimention of our threads
	int size=(BLOCKS*THREADS);
	// Result var
	double area=0;
	// with var initialization
	double width=1.0/(double) RECTS;

	pi = (double*) malloc(size*sizeof(double));

	cudaMalloc((void **)&d_pi, size * sizeof(double));//Device memory (GPU)
	// Send vars to GPU
  cudaMemcpy(d_pi, pi, size * sizeof(double), cudaMemcpyHostToDevice);
	// Do the operation in the GPU
	piCalc<<<BLOCKS, THREADS>>>(d_pi, width, RECTS); // Launch GPU with its corresponding inputs
	// Retrieve the results
	cudaMemcpy(pi, d_pi, size * sizeof(double), cudaMemcpyDeviceToHost); // Copy output array from GPU back to CPU (Device to host)
	// Sum all of our values
	for(int i = 0; i<size; ++i){
    area += pi[i];
  }
	// Calc the area
	area=width*area;

	printf("Pi = %lf\n", area);
	// Free our CPUs and GPUs
	free(pi);
	cudaFree(d_pi);

	return 0;
}
