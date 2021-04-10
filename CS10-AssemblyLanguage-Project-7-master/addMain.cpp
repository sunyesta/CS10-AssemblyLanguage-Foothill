/**
 * c++ code
 * Tells program
 * @author - Marian Zlateva
 */
#include <iostream>

using namespace std;

extern "C"
int CountLongestIncreasingList(long array[], unsigned arrayLength);

int main() {
	long values[10] = {-5,10,20,14,17,26,42,22,19,-5};
	int total = CountLongestIncreasingList(values, 10);
	cout << "Length of Longest Increasing List for ";

	for (int i = 0; i < sizeof(values) / sizeof(values[0]); i++) {
		cout << values[i] << ", ";
	}
	cout << " is " << total << endl;
	return 0;
}

/*

Length of Longest Increasing List for -5, 10, 20, 14, 17, 26, 42, 22, 19, -5,  is 4

*/