#include <iostream>
#include <sstream>
#include <vector>

using namespace std;

int compare_numbers(const void *a, const void *b)
{
    return (*(int *)a - *(int *)b);
}

int main()
{
    string N, buses;

    // Handle the two-line input
    getline(cin, N);
    getline(cin, buses);

    istringstream iss(buses);
    vector<int> bus_numbers;
    int num;

    while (iss >> num)
    {
        bus_numbers.push_back(num);
    }

    // Sort the list of numbers
    qsort(bus_numbers.data(), stoi(N), sizeof(int), compare_numbers);

    for (int n = 0; n < stoi(N); n++)
    {
        int start = bus_numbers[n];
        int end = start;

        // Check for consecutive numbers
        while (n + 1 < stoi(N) && bus_numbers[n + 1] == bus_numbers[n] + 1)
        {
            end = bus_numbers[n + 1];
            n++;
        }

        if (start == end)
        {
            cout << start << " ";
        }
        else if (start == end - 1)
        {
            cout << start << " "
                 << end << " ";
        }
        else
        {
            cout << start << "-" << end << " ";
        }
    }
    cout << endl;
    return 0;
}