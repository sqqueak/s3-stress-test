#!/bin/bash

# Check if two positional arguments are provided
if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <num_files> <file_size>"
        exit 1
fi

# Get the number of files and file size from positional arguments
num_files="$1"
file_size="$2"
min=1
s_max=100
m_max=10
l_max=1

# Check if the number of files is a positive integer
if ! [[ "$num_files" =~ ^[1-9][0-9]*$ ]]; then
        echo "Number of files must be a positive integer."
        exit 1
fi

mkdir files
# Generate a random file based on the specified size
for i in `eval echo {1..$1}`; do
        case "$file_size" in
                "small")
                        dd bs=1K count=$(($RANDOM%$s_max + $min)) if=/dev/urandom of=./files/s$i
                        ;;
                "medium")
                        dd bs=1M count=$(($RANDOM%$m_max + $min)) if=/dev/urandom of=./files/m$i
                        ;;
                "large")
                        dd bs=1G count=$(($RANDOM%$l_max + $min)) if=/dev/urandom of=./files/l$i
                        ;;
                *)
                        echo "Invalid file size. Please specify 'small', 'medium', or 'large'."
                        exit 1
                        ;;
        esac
done
