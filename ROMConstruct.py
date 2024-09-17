import itertools
import csv

if __name__ == '__main__':
    # Create a 512 list (9 bits) mapping to 9 bits of control data output.
    words = [0] * 512 

    csv_file = 'R5ISA_ttAB.csv'

    with open(csv_file, mode='r') as file:
        csv_reader = csv.DictReader(itertools.islice(file, 1, None))

        for row in csv_reader:

            words[int(row["ibin"],2)] = int(row["obin"],2)

    print("v3.0 hex words plain")

    with open('control.rom', mode='w') as rom_file:
        # Write the header
        rom_file.write("v3.0 hex words plain\n")

        # Write each word as 16 hexadecimal values per line
        for i in range(int(512 / 16)):  # Dividing by 16 to get the right number of lines
            line = ""
            for j in range(16):
                # Format each word as 2-digit hexadecimal
                line += f"{words[(i * 16) + j]:0>5x} "
            
            # Remove the trailing space and write the line to the file
            line = line.strip()
            rom_file.write(line + "\n")

    print("ROM file generated: control.rom")

