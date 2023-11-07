#!/usr/bin/env python3

# ../genram.py| split -d -l256 -a1 --additional-suffix=.hex - ram

# Fill video ram with CP437 characters

# First byte = character code
# Second byte = attributes (set to 0)

COLUMNS = 32
LINES = 8
TOTAL_BYTES = 256*16

attr_map = [0x20, 0x28, 0x01, 0x09, 0xA0, 0xA8, 0x81, 0x89]

bytes_written = 0

for line in range(LINES):
    attr_value = attr_map[line % 8]
    # Loop for each column
    for col in range(COLUMNS):
        # Calculate the character value for this position
        char_value = line * COLUMNS + col
        # Print the character value followed by 00
        hex_value = f"{char_value:02X}{attr_value:02X}"
        print(hex_value)
        bytes_written += 2

    # Pad the rest of the line with 0000
    for _ in range(COLUMNS, 80):
        print("0000")
        bytes_written += 2

# Pad the rest of the file with 0000
while bytes_written < TOTAL_BYTES:
    print("0000")
    bytes_written += 2
