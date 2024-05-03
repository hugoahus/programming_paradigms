// @author Hugo Larsson Wilhelmsson and Erik Smit
// @date 2024-02-21
#include <iostream>
#include <vector>

using namespace std;

string get_multiplier(int mult);

// Structure for a zone on the dartboard and it's corresponding multiplier and points
struct Zone
{
    Zone(int points_, int mult_)
        : points(points_), mult(mult_), total(points_ * mult) {}

    int points;
    int mult;
    int total;
};

// This function returns a string, either "single", "double" or "triple"
string get_multiplier(int mult)
{
    switch (mult)
    {
    case 1:
        return "single";
        break;

    case 2:
        return "double";
        break;
    case 3:
        return "triple";
        break;

    default:
        return "error";
        break;
    }
}

int main()
{
    // Get input
    int target_score;
    cin >> target_score;

    // List of all the zones
    vector<Zone> zones;

    // Create all the zones on the dart board in the given problem
    for (int i = 1; i <= 20; i++)
    {
        zones.push_back(Zone(i, 1));
        zones.push_back(Zone(i, 2));
        zones.push_back(Zone(i, 3));
    }

    // Iterate over all the various combinations of dart throws (#3) until one is found
    for (int i = 0; i < zones.size(); i++)
    {

        for (int j = 0; j < zones.size(); j++)
        {

            for (int k = 0; k < zones.size(); k++)
            {
                // Check if possible with 1 throw
                if (zones[k].total == target_score)
                {
                    cout << get_multiplier(zones[k].mult) << " " << zones[k].points << endl;
                    return 0;
                }
                // Check if possible with 2 throws
                else if (zones[k].total + zones[j].total == target_score)
                {
                    cout << get_multiplier(zones[k].mult) << " " << zones[k].points << endl;
                    cout << get_multiplier(zones[j].mult) << " " << zones[j].points << endl;
                    return 0;
                }

                // Check if possible with 3 throws
                int combined_score = zones[i].total + zones[j].total + zones[k].total;
                // Check if the sum of these three throws equals the target score
                if (combined_score == target_score)
                {
                    // Output the combination
                    cout << get_multiplier(zones[k].mult) << " " << zones[k].points << endl;
                    cout << get_multiplier(zones[j].mult) << " " << zones[j].points << endl;
                    cout << get_multiplier(zones[i].mult) << " " << zones[i].points << endl;
                    return 0; // Exit the program after finding a valid combination
                }
            }
        }
    }

    // If no valid combination is found, output "impossible"
    cout << "impossible" << endl;

    return 0;
}