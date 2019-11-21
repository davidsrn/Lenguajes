/*
 * BasicSum.cu
 *
 *  Created on: 9/23/2019
 *      Author: Benjamin Valdes
 *		ID: A0082900
*/

/*
Simple example of addition using C++ CUDA
*/

#include "cuda_runtime.h"
#include <stdio.h>

__global__ void sum(int *a, int *b, int *c){
	*c = *a + *b;
}

int main(){
	int a, b, c;
	int *d_a, *d_b, *d_c;
	int size = sizeof(int);
	//allocating memory
	cudaMalloc((void**)&d_a, size);
	cudaMalloc((void**)&d_b, size);
	cudaMalloc((void**)&d_c, size);
	//get values from user
	printf("please give me 2 values\n");
	scanf("%i %i", &a, &b);
	//copy values from cpu(RAM) to the graphics card memmory
	cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);
	//run kernel
	sum << <1, 1 >> >(d_a, d_b, d_c);
	//get values from memory card
	cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);
	printf("the result is %d\n", c);

	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);

	return 0;

}
