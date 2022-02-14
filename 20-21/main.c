#include <stdio.h>

#include "array.h"

int main(void) {
	long array[] = { 2, 5, 7, 10, 29, 30, 47, 49, 50, 54, 59, 65, 70, 79 };
	size_t length = sizeof(array) / sizeof(array[0]);
	printf("%d", contains(array, 70, 0, length));
	printf("%d", contains(array, 6, 0, length));
	printf("%d", contains(array, 54, 0, length));
	printf("%d", contains(array, 1, 0, length));
	printf("%d", contains(array, 79, 0, length));
	printf("%d", contains(array, 80, 0, length));
	printf("%d", contains(array, 10, 0, length));
	printf("%d", contains(array, 11, 0, length));
}
