#!/bin/bash

# Check if names.txt exists
if [ ! -f names.txt ]; then
    echo "names.txt file not found."
    exit 1
fi

# Read names from names.txt into an array
IFS=$'\n' read -d '' -r -a names < names.txt

# Ask the user for the number of random names to write to a new file
echo "How many random names would you like to select?"
read num_random_names

# Validate the input
if ! [[ "$num_random_names" =~ ^[0-9]+$ ]] || [ "$num_random_names" -lt 1 ] || [ "$num_random_names" -gt ${#names[@]} ]; then
    echo "Invalid number. Please run the script again with a number between 1 and ${#names[@]}."
    exit 1
fi

# Shuffle the names array using shuf and select the top N names based on user input
shuffled_names=($(shuf -e "${names[@]}" | head -n "$num_random_names"))

# Write the specified number of random names to a new file, e.g., selected_names.txt
> winners.txt # Clear the file if it exists
for name in "${shuffled_names[@]}"; do
    echo "$name" >> winners.txt
done

echo "$num_random_names random names have been written to winners.txt."
