#!/bin/sh
. ./.env

# Store the current directory
current_dir=$(pwd)

# Change directory to the tests folder
cd "./tests" || { echo "Error: tests folder not found"; exit 1; }

# Loop through all .sh files in the tests folder
for test_file in *.sh; do
    # Run the script
    echo "Running $test_file..."
    sh "$test_file" $PROXY_DOMAIN
    
    # Check the exit status of the script
    if [ $? -ne 0 ]; then
        echo -e "\e[1;31mError: $test_file returned a non-zero exit code."
        cd "$current_dir"  # Change back to the original directory
        exit 1
    fi
done

echo "All tests passed successfully."
cd "$current_dir"  # Change back to the original directory
