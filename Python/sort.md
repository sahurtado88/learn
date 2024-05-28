# Sorting Algorithms

A Sorting Algorithm is used to rearrange a given array or list of elements according to a comparison operator on the elements. The comparison operator is used to decide the new order of elements in the respective data structure.

## Sorting Terminology:
- In-place Sorting: An in-place sorting algorithm uses constant space for producing the output (modifies the given array only). It sorts the list only by modifying the order of the elements within the list. Examples: Selection Sort, Bubble Sort Insertion Sort and Heap Sort.
- Internal Sorting: Internal Sorting is when all the data is placed in the main memory or internal memory. In internal sorting, the problem cannot take input beyond its size. Example: heap sort, bubble sort, selection sort, quick sort, shell sort, insertion sort.
- External Sorting : External Sorting is when all the data that needs to be sorted cannot be placed in memory at a time, the sorting is called external sorting. External Sorting is used for the massive amount of data. Examples: Merge sort, Tag sort, Polyphase sort, Four tape sort, External radix sort, etc.
- Stable sorting: When two same data appear in the same order in sorted data without changing their position is called stable sort. Examples: Merge Sort, Insertion Sort, Bubble Sort.
- Unstable sorting: When two same data appear in the different order in sorted data it is called unstable sort. Examples: Quick Sort, Heap Sort, Shell Sort.

## Characteristics of Sorting Algorithms:
- Time Complexity: Time complexity, a measure of how long it takes to run an algorithm, is used to categorize sorting algorithms. The worst-case, average-case, and best-case performance of a sorting algorithm can be used to quantify the time complexity of the process.
- Space Complexity: Sorting algorithms also have space complexity, which is the amount of memory required to execute the algorithm.
- Stability: A sorting algorithm is said to be stable if the relative order of equal elements is preserved after sorting. This is important in certain applications where the original order of equal elements must be maintained.
- In-Place Sorting: An in-place sorting algorithm is one that does not require additional memory to sort the data. This is important when the available memory is limited or when the data cannot be moved.
- Adaptivity: An adaptive sorting algorithm is one that takes advantage of pre-existing order in the data to improve performance.

## Applications of Sorting Algorithms:
Searching Algorithms: Sorting is often a crucial step in search algorithms like binary search, Ternary Search, where the data needs to be sorted before searching for a specific element.
- Data management: Sorting data makes it easier to search, retrieve, and analyze.
- Database optimization: Sorting data in databases improves query performance.
- Machine learning: Sorting is used to prepare data for training machine learning models.
- Data Analysis: Sorting helps in identifying patterns, trends, and outliers in datasets. It plays a vital role in statistical analysis, financial modeling, and other data-driven fields.
- Operating Systems: Sorting algorithms are used in operating systems for tasks like task scheduling, memory management, and file system organization.

## Sorting Algorithms:

### Selection sort 

Is a simple and efficient sorting algorithm that works by repeatedly selecting the smallest (or largest) element from the unsorted portion of the list and moving it to the sorted portion of the list. 

The algorithm repeatedly selects the smallest (or largest) element from the unsorted portion of the list and swaps it with the first element of the unsorted part. This process is repeated for the remaining unsorted portion until the entire list is sorted. 

```
# Python program for implementation of Selection
# Sort
A = [64, 25, 12, 22, 11]

# Traverse through all array elements
for i in range(len(A)-1):
    
    # Find the minimum element in remaining 
    # unsorted array
    min_idx = i
    for j in range(i+1, len(A)):
        if A[min_idx] > A[j]:
            min_idx = j
            
    # Swap the found minimum element with 
    # the first element        
    A[i], A[min_idx] = A[min_idx], A[i]

# Driver code to test above
print ("Sorted array")
for i in range(len(A)):
    print(A[i],end=" ") 
```

#### Complexity Analysis of Selection Sort

- Time Complexity: The time complexity of Selection Sort is O(N2) as there are two nested loops:

- One loop to select an element of Array one by one = O(N)
- Another loop to compare that element with every other Array element = O(N)
- Therefore overall complexity = O(N) * O(N) = O(N*N) = O(N2)
- Auxiliary Space: O(1) as the only extra memory used is for temporary variables while swapping two values in Array. The selection sort never makes more than O(N) swaps and can be useful when memory writing is costly. 

#### Advantages of Selection Sort Algorithm
- Simple and easy to understand.
- Works well with small datasets.
#### Disadvantages of the Selection Sort Algorithm
- Selection sort has a time complexity of O(n^2) in the worst and average case.
- Does not work well on large datasets.
- Does not preserve the relative order of items with equal keys which means it is not stable.

### Bubble Sort 

Bubble Sort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements if they are in the wrong order. This algorithm is not suitable for large data sets as its average and worst-case time complexity is quite high.

In Bubble Sort algorithm, 

- traverse from left and compare adjacent elements and the higher one is placed at right side. 
- In this way, the largest element is moved to the rightmost end at first. 
- This process is then continued to find the second largest and place it and so on until the data is sorted.

```
# Optimized Python program for implementation of Bubble Sort


def bubbleSort(arr):
    n = len(arr)
    
    # Traverse through all array elements
    for i in range(n):
        swapped = False

        # Last i elements are already in place
        for j in range(0, n-i-1):

            # Traverse the array from 0 to n-i-1
            # Swap if the element found is greater
            # than the next element
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
                swapped = True
        if (swapped == False):
            break


# Driver code to test above
if __name__ == "__main__":
    arr = [64, 34, 25, 12, 22, 11, 90]

    bubbleSort(arr)

    print("Sorted array:")
    for i in range(len(arr)):
        print("%d" % arr[i], end=" ")
```

#### Complexity Analysis of Bubble Sort:
Time Complexity: O(N2)
Auxiliary Space: O(1)

#### Advantages of Bubble Sort:
- Bubble sort is easy to understand and implement.
- It does not require any additional memory space.
- It is a stable sorting algorithm, meaning that elements with the same key value maintain their relative order in the sorted output.
#### Disadvantages of Bubble Sort:
- Bubble sort has a time complexity of O(N2) which makes it very slow for large data sets.
- Bubble sort is a comparison-based sorting algorithm, which means that it requires a comparison operator to determine the relative order of elements in the input data set. It can limit the efficiency of the algorithm in certain cases.

### Insertion sort 
Is a simple sorting algorithm that works by iteratively inserting each element of an unsorted list into its correct position in a sorted portion of the list. It is a stable sorting algorithm, meaning that elements with equal values maintain their relative order in the sorted output.

Insertion sort is like sorting playing cards in your hands. You split the cards into two groups: the sorted cards and the unsorted cards. Then, you pick a card from the unsorted group and put it in the right place in the sorted group.

Insertion Sort Algorithm:
Insertion sort is a simple sorting algorithm that works by building a sorted array one element at a time. It is considered an “in-place” sorting algorithm, meaning it doesn’t require any additional memory space beyond the original array.

```
# Python program for implementation of Insertion Sort

# Function to do insertion sort
def insertionSort(arr):

    # Traverse through 1 to len(arr)
    for i in range(1, len(arr)):

        key = arr[i]

        # Move elements of arr[0..i-1], that are
        # greater than key, to one position ahead
        # of their current position
        j = i-1
        while j >= 0 and key < arr[j] :
                arr[j + 1] = arr[j]
                j -= 1
        arr[j + 1] = key


# Driver code to test above
arr = [12, 11, 13, 5, 6]
insertionSort(arr)
for i in range(len(arr)):
    print ("% d" % arr[i])
```

Time Complexity: O(N^2) 
Auxiliary Space: O(1)

#### Complexity Analysis of Insertion Sort:
- Time Complexity of Insertion Sort
- Best case: O(n), If the list is already sorted, where n is the number of elements in the list.
- Average case: O(n2), If the list is randomly ordered
- Worst case: O(n2), If the list is in reverse order

Space Complexity of Insertion Sort
- Auxiliary Space: O(1), Insertion sort requires O(1) additional space, making it a space-efficient sorting algorithm.
#### Advantages of Insertion Sort:
- Simple and easy to implement.
- Stable sorting algorithm.
- Efficient for small lists and nearly sorted lists.
- Space-efficient.
#### Disadvantages of Insertion Sort:
- Inefficient for large lists.
- Not as efficient as other sorting algorithms (e.g., merge sort, quick sort) for most cases.
- Applications of Insertion Sort:
Insertion sort is commonly used in situations where:

- The list is small or nearly sorted.
- Simplicity and stability are important.

https://www.geeksforgeeks.org/sorting-algorithms/?ref=ml_lbp