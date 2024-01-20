// C++ Implementation of the Quick Sort Algorithm.
//Taken from: https://www.geeksforgeeks.org/cpp-program-for-quicksort/
#include <iostream>
using std::swap;

//C++ mangles the function names without adding extern "C"
extern "C" void quickSort(double* arr, int size);
int partition(double arr[], int start, int end)
{
 
    double pivot = arr[start];
 
    int count = 0;
    for (int i = start + 1; i <= end; i++) {
        if (arr[i] <= pivot)
            count++;
    }
 
    // Giving pivot element its correct position
    int pivotIndex = start + count;
    swap(arr[pivotIndex], arr[start]);
 
    // Sorting left and right parts of the pivot element
    int i = start, j = end;
 
    while (i < pivotIndex && j > pivotIndex) {
 
        while (arr[i] <= pivot) {
            i++;
        }
 
        while (arr[j] > pivot) {
            j--;
        }
 
        if (i < pivotIndex && j > pivotIndex) {
            swap(arr[i++], arr[j--]);
        }
    }
 
    return pivotIndex;
}
 
void quickSort(double arr[], int start, int end)
{
 
    // base case
    if (start >= end)
        return;
 
    // partitioning the array
    int p = partition(arr, start, end);
 
    // Sorting the left part
    quickSort(arr, start, p - 1);
 
    // Sorting the right part
    quickSort(arr, p + 1, end);
}

//Wrapper starting sort at the beginning of the array and stopping at the last index (size - 1)
void quickSort(double arr[], int size) {
    quickSort(arr, 0, size - 1);
}