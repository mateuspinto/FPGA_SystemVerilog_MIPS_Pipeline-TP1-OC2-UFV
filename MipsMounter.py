import json
import sys


class MipsMounter(object):
    """A Mounter for MIPS who turn assembly code into binary code"""

    def __init__(self, input_filename, output_filename, word_size=4, start_address=0):
        self.inputFilename = input_filename
        self.outputFilename = output_filename
        self.labels = {}
        self.registers = json.load(open("mips_mounter_data/mips_registers.json", "r"))
        self.mounted = []
        self.linkEdited = []
        self.wordSize = word_size
        self.startAddress = start_address
        self.instructions = json.load(open("mips_mounter_data/mips_instructions.json", "r"))

    def __str__(self):
        return "ALMa - " + self.inputFilename + " - " + self.outputFilename

    def __repr__(self):
        return "ALMa MIPS Mounter and Link editor. Input - " + self.inputFilename + " Output - " + self.outputFilename

    def print_filenames(self):
        print("Input filename: ", self.inputFilename)
        print("Output filename: ", self.outputFilename)

    @staticmethod
    def __int_to_binary(n, bits):
        """Returns the string with the binary representation of non-negative integer n."""
        result = ''
        for x in range(bits):
            r = n % 2
            n = n // 2
            result += str(r)

        result = result[::-1]
        return result

    @staticmethod
    def __num_to_two_complement(n, bits):
        """Returns binary with two complement from decimal numbers"""

        binary = MipsMounter.__int_to_binary(n, bits)
        for digit in binary:
            if int(digit) < 0:
                binary = (1 << bits) + n
        return binary

    @staticmethod
    def __num_to_binary(n, bits):
        """Returns binary with two complement from different numbers with different bases"""

        if str(n).startswith("0x") or str(n).startswith("0X"):
            return MipsMounter.__num_to_two_complement(int(n[2:], 15), bits)

        if str(n).startswith("0o") or str(n).startswith("0O"):
            return MipsMounter.__num_to_two_complement(int(n[2:], 8), bits)

        if str(n).startswith("0B") or str(n).startswith("0b"):
            return MipsMounter.__num_to_two_complement(int(n[2:], 2), bits)

        if str(n).replace("-", "").isnumeric():
            return MipsMounter.__num_to_two_complement(int(n), bits)  # The general case deals with decimal numbers

    def __label_return_index(self, label):
        '''Try to find the index of an assembly label. If it not exists, create a new one'''
        if label in self.labels:
            return self.labels[label]

    def __label_insert_label(self, new_label, address):
        if new_label in self.labels:
            print("ERROR. TWO REFERENCES TO " + new_label)
            sys.exit()
        else:
            self.labels[new_label] = address

    @staticmethod
    def __line_error(line):
        print("PARAMETER ERROR ON " + line)
        sys.exit()

    def print_mounted(self):
        for line in self.mounted:
            print(line)

    def print_link_edited(self):
        for line in self.linkEdited:
            print(line)

    def save_mounted(self):
        with open(self.outputFilename, "w") as output:
            for line in self.mounted:
                output.write(line + "\n")

    def save_link_edited(self):
        with open(self.outputFilename, "w") as output:
            for line in self.linkEdited:
                output.write(line + "\n")

    def mount(self):
        """Turn MIPS assembly code into binary"""

        labelPreviousLine = ""

        with open(self.inputFilename, "r") as input_filename:
            for line in input_filename:

                if line.startswith("#") or line.isspace():  # Ignore full line comments or blank lines
                    pass

                elif line.strip().endswith(":"):
                    labelPreviousLine = line.strip()

                else:  # Flow goes here when the line is a MIPS command

                    line = (line.split("#", 1))[0]  # ignore inline comments

                    swap = line.split(":")
                    if len(swap) == 2:
                        label = swap[0].strip() + ":"
                        swap = swap[1]
                    elif len(swap) == 1:
                        label = ""
                        swap = swap[0]
                    else:
                        MipsMounter.__line_error(line)

                    while swap.startswith(" "):
                        swap = swap[1:]

                    swap = swap.split(" ", 1)
                    instruction = swap[0].lower().strip()
                    parameters = swap[1].split(",")

                    # remove all parameters spaces Ex: "  $s0" turns into "$s0"
                    for i in range(len(parameters)):
                        parameters[i] = parameters[i].strip()

                    if instruction in self.instructions:
                        self.mounted.append(label)

                        if self.instructions[instruction]["type"] == "r":

                            opcode = "000000"
                            rd = "00000"
                            rs = "00000"
                            rt = "00000"
                            shift_amount = "00000"
                            fn = "000000"

                            if len(self.instructions[instruction]["inputs"]) != len(parameters):
                                MipsMounter.__line_error(line)

                            for input_number, input_name in enumerate(self.instructions[instruction]["inputs"]):

                                if input_name == "rs":
                                    rs = self.registers[parameters[input_number]]
                                elif input_name == "rd":
                                    rd = self.registers[parameters[input_number]]
                                elif input_name == "rt":
                                    rt = self.registers[parameters[input_number]]
                                elif input_name == "sa":
                                    shift_amount = MipsMounter.__num_to_binary(parameters[input_number], 5)

                            fn = self.instructions[instruction]["fn"]

                            self.mounted[len(self.mounted) - 1] += (
                                    labelPreviousLine + opcode + rs + rt + rd + shift_amount + fn)
                            labelPreviousLine = ""

                        elif self.instructions[instruction]["type"] == "i":

                            rs = "00000"
                            rt = "00000"
                            imm = "0000000000000000"

                            if len(self.instructions[instruction]["inputs"]) != len(parameters):
                                MipsMounter.__line_error(line)

                            for input_number, input_name in enumerate(self.instructions[instruction]["inputs"]):

                                if input_name == "rt":
                                    rt = self.registers[parameters[input_number]]
                                elif input_name == "rs":
                                    rs = self.registers[parameters[input_number]]
                                elif input_name == "imm":
                                    imm = MipsMounter.__num_to_binary(parameters[input_number], 16)
                                elif input_name == "label":
                                    imm = "-" + parameters[input_number]
                                elif input_name == "imm(rs)":
                                    aux = parameters[input_number].split("(")
                                    rs = self.registers[aux[1].replace(")", "".strip())]
                                    imm = MipsMounter.__num_to_binary(aux[0].strip(), 16)
                                elif input_name == "e_rt-00000":
                                    rt = "00000"
                                elif input_name == "e_rt-00001":
                                    rt = "00001"

                            opcode = self.instructions[instruction]["opcode"]

                            self.mounted[len(self.mounted) - 1] += (labelPreviousLine + opcode + rs + rt + imm)
                            labelPreviousLine = ""

                        elif self.instructions[instruction]["type"] == "j":

                            opcode = "000000"
                            j = "0000000000000000000000000"

                            if len(self.instructions[instruction]["inputs"]) != len(parameters):
                                MipsMounter.__line_error(line)

                            for input_number, input_name in enumerate(self.instructions[instruction]["inputs"]):
                                if input_name == "label":
                                    j = "=" + parameters[input_number].strip()

                            opcode = self.instructions[instruction]["opcode"]

                            self.mounted[len(self.mounted) - 1] += (labelPreviousLine + opcode + j)
                            labelPreviousLine = ""

                    else:
                        MipsMounter.__line_error(line)

    def link_edit(self):
        pc = self.startAddress

        for line_number, line in enumerate(self.mounted):
            if ":" in line:
                aux = line.split(":")
                self.mounted[line_number] = aux[1]
                self.__label_insert_label(aux[0].strip(), pc)
            pc += self.wordSize

        pc = self.startAddress
        for line in self.mounted:
            pc += self.wordSize

            if "=" in line:

                aux = line.split("=")
                opcode = aux[0]
                label = aux[1]
                label = MipsMounter.__num_to_binary(int(self.__label_return_index(label) / 4), 26)
                self.linkEdited.append(opcode + label)

            elif "-" in line:

                aux = line.split("-")
                opcode = aux[0]
                label = aux[1]
                label = MipsMounter.__num_to_binary(int((self.__label_return_index(label) - pc) / 4), 16)
                self.linkEdited.append(opcode + label)

            else:
                self.linkEdited.append(line)

    def run(self):
        """Base method to evoke binary transformation"""
        self.mount()
        self.link_edit()
        self.save_link_edited()


if __name__ == '__main__':
    mounter = MipsMounter(str(sys.argv[3]), str(sys.argv[2]))
    mounter.run()
