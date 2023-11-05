#!/usr/bin/env python3

# Fill video ram with CP437 characters

# First byte = character code
# Second byte = attributes (set to 0)

COLUMNS = 32
LINES = 8
TOTAL_BYTES = 256*16

bytes_written = 0

for line in range(LINES):
    # Loop for each column
    for col in range(COLUMNS):
        # Calculate the character value for this position
        if col == 0:
            char_value = 0xDB
        else:
            char_value = line * COLUMNS + col
        # Print the character value followed by 00
        hex_value = f"{char_value:02X}00"
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
