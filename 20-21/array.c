#include "array.h"

bool contains(long* array, long elem, int left, int right) {
	if (right-left < 1) {
		return false;
	} else if (right-left == 1) {
		return array[left] == elem;
	} else {
		int mid = left + (right-left) / 2;
		return elem < array[mid] ?
			contains(array, elem, left, mid) :
			contains(array, elem, mid, right);
	}
}
