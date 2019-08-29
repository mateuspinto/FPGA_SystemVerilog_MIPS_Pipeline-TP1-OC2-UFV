import sys

class mipsMounter(object):
    '''A Mounter for MIPS who turn assembly code into binary code'''

    def __init__(self, inputFilename, outputFilename, wordSize = 4, startAdress=0):
        self.inputFilename = inputFilename
        self.outputFilename = outputFilename
        self.labels = {}
        self.registers = {"$zero":"00000",
                            "$s0":"10000",
                            "$s1":"10001",
                            "$s2":"10010",
                            "$s3":"10011",
                            "$s4":"10100",
                            "$s5":"10101",
                            "$s6":"10110",
                            "$s7":"10111",
                            "$t0":"01000",
                            "$t1":"01001",
                            "$t2":"01010",
                            "$t3":"01011",
                            "$t4":"01100",
                            "$t5":"01101",
                            "$t6":"01110",
                            "$t7":"01111",
                            "$t8":"11000",
                            "$t9":"11001",
                            "$v0":"00010",
                            "$v1":"00011",
                            "$a0":"00100",
                            "$a1":"00101",
                            "$a2":"00110",
                            "$a3":"00111",
                            "$at":"00001",
                            "$k0":"11010",
                            "$k1":"11011",
                            "$gp":"11100",
                            "$sp":"11101",
                            "$fp":"11110",
                            "$ra":"11111"}
        self.mounted = []
        self.linkEdited = []
        self.wordSize = wordSize
        self.startAdress = startAdress
        self.instructions = {"add":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"100000"
        },

        "move":{
            "type":"r",
            "inputs":["rs", "rd"],
            "fn":"100000"
        },
        
        "addu":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"100001"
        },

        "and":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"100100"
        },

        "break":{
            "type":["r"],
            "inputs":[],
            "fn":"001101"
        },

        "div":{
            "type":"r",
            "inputs":["rs","rt"],
            "fn":"011010"
        },

        
        "divu":{
            "type":"r",
            "inputs":["rs","rt"],
            "fn":"011011"
        },

        "mfhi":{
            "type":"r",
            "inputs":["rd"],
            "fn":"010000"
        },

        "mflo":{
            "type":"r",
            "inputs":["rd"],
            "fn":"010010"
        },

        "mthi":{
            "type":"r",
            "inputs":["rs"],
            "fn":"010001"
        },

        "mtlo":{
            "type":"r",
            "inputs":["rs"],
            "fn":"010011"
        },

        "mult":{
            "type":"r",
            "inputs":["rs","rt"],
            "fn":"011000"
        },

        "multu":{
            "type":"r",
            "inputs":["rs","rt"],
            "fn":"011001"
        },

        "nor":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"100111"
        },

        "or":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"100101"
        },

        "sll":{
            "type":"r",
            "inputs":["rd", "rt","sa"],
            "fn":"000000"
        },

        "sllv":{
            "type":"r",
            "inputs":["rd", "rt", "rs"],
            "fn":"000100"
        },

        "slt":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"101010"
        },

        "sltu":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"101011"
        },

        "sra":{
            "type":"r",
            "inputs":["rd", "rt", "sa"],
            "fn":"000011"
        },

        "srav":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"000111"
        },

        "srl":{
            "type":"r",
            "inputs":["rd","rt","sa"],
            "fn":"000010"
        },

        "srlv":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"000110"
        },

        "sub":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"100010"
        },

        "subu":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"100011"
        },

        "syscall":{
            "type":"r",
            "inputs":[],
            "fn":"001100"
        },

        "xor":{
            "type":"r",
            "inputs":["rd", "rs", "rt"],
            "fn":"100110"
        },

        "addi":{
            "type":"i",
            "inputs":["rt", "rs", "imm"],
            "opcode":"001000"
        },

        "addiu":{
            "type":"i",
            "inputs":["rt", "rs", "imm"],
            "opcode":"001001"
        },

        "andi":{
            "type":"i",
            "inputs":["rt", "rs", "imm"],
            "opcode":"001100"
        },

        "beq":{
            "type":"i",
            "inputs":["rs", "rt", "label"],
            "opcode":"000100"
        },

        "bgez":{
            "type":"i",
            "inputs":["e_rt-00001", "rs", "imm"],
            "opcode":"000001"
        },

        "bgtz":{
            "type":"i",
            "inputs":["e_rt-00000", "rs", "imm"],
            "opcode":"000111"
        },

        "blez":{
            "type":"i",
            "inputs":["e_rt-00000", "rs", "imm"],
            "opcode":"000110"
        },

        "bltz":{
            "type":"i",
            "inputs":["e_rt-00000", "rs", "imm"],
            "opcode":"000001"
        },

        "bne":{
            "type":"i",
            "inputs":["rs", "rt", "label"],
            "opcode":"000101"
        },

        "lb":{
            "type":"i",
            "inputs":["rt", "imm(rs)"],
            "opcode":"100000"
        },

        "lbu":{
            "type":"i",
            "inputs":["rt", "imm(rs)"],
            "opcode":"100100"
        },

        "lh":{
            "type":"i",
            "inputs":["rt", "imm(rs)"],
            "opcode":"100001"
        },

        "lhu":{
            "type":"i",
            "inputs":["rt", "imm(rs)"],
            "opcode":"100101"
        },

        "lui":{
            "type":"i",
            "inputs":["rt", "imm"],
            "opcode":"001111"
        },

        "lw":{
            "type":"i",
            "inputs":["rt", "imm(rs)"],
            "opcode":"100011"
        },

        "lwc1":{
            "type":"i",
            "inputs":["rt", "imm(rs)"],
            "opcode":"110001"
        },

        "ori":{
            "type":"i",
            "inputs":["rt", "rs", "imm"],
            "opcode":"001101"
        },

        "sb":{
            "type":"i",
            "inputs":["rt", "imm(rs)"],
            "opcode":"101000"
        },

        "slti":{
            "type":"i",
            "inputs":["rt", "rs", "imm"],
            "opcode":"001010"
        },

        "sltiu":{
            "type":"i",
            "inputs":["rt", "rs", "imm"],
            "opcode":"001011"
        },

        "sh":{
            "type":"i",
            "inputs":["rt", "imm(rs)"],
            "opcode":"101001"
        },

        "sw":{
            "type":"i",
            "inputs":["rt", "imm(rs)"],
            "opcode":"101011"
        },

        "swc1":{
            "type":"i",
            "inputs":["rt", "imm(rs)"],
            "opcode":"111001"
        },

        "xori":{
            "type":"i",
            "inputs":["rt", "rs", "imm"],
            "opcode":"001110"
        },

        "j":{
            "type":"j",
            "inputs":["label"],
            "opcode":"000010"
        },

        "jal":{
            "type":"j",
            "inputs":["label"],
            "opcode":"000011"
        }
        }

    def printFilenames(self):
        print("Input filename: ", self.inputFilename)
        print("Output filename: ", self.outputFilename)

    @staticmethod
    def __intToBinary(n, bits):
        '''Returns the string with the binary representation of non-negative integer n.'''
        result = ''  
        for x in range(bits):
            r = n % 2 
            n = n // 2
            result += str(r)

        result = result[::-1]
        return result

    @staticmethod
    def __NumToTc(n, bits):
        '''Returns binary with two complement from decimal numbers'''
        
        binary = mipsMounter.__intToBinary(n, bits)
        for digit in binary:
            if int(digit) < 0:
                binary = (1 << bits) + n
        return binary

    @staticmethod
    def __numToBinary(n, bits):
        '''Returns binary with two complement from different numbers with different bases'''

        if str(n).startswith("0x") or str(n).startswith("0X"):
            return mipsMounter.__NumToTc(int(n[2:], 15), bits)

        if str(n).startswith("0o") or str(n).startswith("0O"):
            return mipsMounter.__NumToTc(int(n[2:], 8), bits)

        if str(n).startswith("0B") or str(n).startswith("0b"):
            return mipsMounter.__NumToTc(int(n[2:], 2), bits)

        if str(n).replace("-", "").isnumeric():
            return mipsMounter.__NumToTc(int(n), bits) #The general case deals with decimal numbers

    def __labelReturnIndex(self, label):
        '''Try to find the index of an assembly label. If it not exists, create a new one'''
        if label in self.labels:
            return self.labels[label]

    def __labelInsertLabel(self, newLabel, adress):
        if newLabel in self.labels:
            print("ERROR. TWO REFFERENCES TO " + newLabel)
            sys.exit()
        else:
            self.labels[newLabel] = adress

    @staticmethod
    def __lineError(line):
        print("PARAMETER ERROR ON " + line)
        sys.exit()

    def printMounted(self):
        for line in self.mounted:
            print(line)

    def printLinkEdited(self):
        for line in self.linkEdited:
            print(line)

    def saveMounted(self):
        with open(self.outputFilename, "w") as output:
            for line in self.mounted:
                output.write(line + "\n")

    def saveLinkEdited(self):
        with open(self.outputFilename, "w") as output:
            for line in self.linkEdited:
                output.write(line + "\n")

    def mount(self):
        '''Turn MIPS assembly code into binary'''

        labelPreviousLine=""

        with open(self.inputFilename, "r") as input:
            for line in input:

                if (line.startswith("#") or line.isspace()): #Ignore fullline comments or blank lines
                    pass

                elif (line.strip().endswith(":")):
                    labelPreviousLine = line.strip()

                else: # Flow goes here when the line is a MIPS command

                    line = (line.split("#",1))[0] #ignore inline comments

                    swap = line.split(":")
                    if len(swap) == 2:
                        label = swap[0].strip() + ":"
                        swap = swap[1]
                    elif len(swap) == 1:
                        label = ""
                        swap = swap[0]
                    else:
                        self._mipsMounter__lineError

                    while swap.startswith(" "):
                        swap = swap[1:] 

                    swap = swap.split(" ",1)
                    instruction = swap[0].lower().strip()
                    parameters = swap[1].split(",")

                    # remove all parameters spaces Ex: "  $s0" turns into "$s0"
                    for i in range(len(parameters)):
                        parameters[i] = parameters[i].strip()
                    
                    if(instruction in self.instructions):
                        self.mounted.append(label)

                        if(self.instructions[instruction]["type"] == "r"):

                            opcode = "000000"
                            rd = "00000"
                            rs = "00000"
                            rt = "00000"
                            shamt = "00000"
                            fn = "000000"

                            if(len(self.instructions[instruction]["inputs"]) != len(parameters)):
                                self._mipsMounter__lineError(line)
                                
                            for input_number, input_name in enumerate(self.instructions[instruction]["inputs"]):

                                if input_name == "rs":
                                    rs = self.registers[parameters[input_number]]
                                elif input_name == "rd":
                                    rd = self.registers[parameters[input_number]]
                                elif input_name == "rt":
                                    rt = self.registers[parameters[input_number]]
                                elif input_name == "sa":
                                    shamt = mipsMounter.__numToBinary(parameters[input_number], 5)

                            fn = self.instructions[instruction]["fn"]

                            self.mounted[len(self.mounted)-1] += (labelPreviousLine + opcode + rs + rt + rd + shamt + fn)
                            labelPreviousLine=""

                        elif(self.instructions[instruction]["type"] == "i"):
                            
                            opcode = "000000"
                            rs = "00000"
                            rt = "00000"
                            imm = "0000000000000000"

                            if(len(self.instructions[instruction]["inputs"]) != len(parameters)):
                                self._mipsMounter__lineError(line)

                            for input_number, input_name in enumerate(self.instructions[instruction]["inputs"]):

                                if input_name == "rt":
                                    rt = self.registers[parameters[input_number]]
                                elif input_name == "rs":
                                    rs = self.registers[parameters[input_number]]
                                elif input_name == "imm":
                                    imm = mipsMounter.__numToBinary(parameters[input_number], 16)
                                elif input_name == "label":
                                    imm = "-" + parameters[input_number]
                                elif input_name == "imm(rs)":
                                    aux = parameters[input_number].split("(")
                                    rs = self.registers[aux[1].replace(")","".strip())]
                                    imm = mipsMounter.__numToBinary(aux[0].strip(), 16)
                                elif input_name == "e_rt-00000":
                                    rt = "00000"
                                elif input_name == "e_rt-00001":
                                    rt = "00001"

                            opcode = self.instructions[instruction]["opcode"]

                            self.mounted[len(self.mounted)-1] += (labelPreviousLine + opcode + rs + rt + imm)
                            labelPreviousLine=""
                            

                        elif(self.instructions[instruction]["type"] == "j"):

                            opcode = "000000"
                            j = "0000000000000000000000000"

                            if(len(self.instructions[instruction]["inputs"]) != len(parameters)):
                                self._mipsMounter__lineError(line)

                            for input_number, input_name in enumerate(self.instructions[instruction]["inputs"]):
                                if input_name == "label":
                                    j = "=" + parameters[input_number].strip()

                            opcode = self.instructions[instruction]["opcode"]

                            self.mounted[len(self.mounted)-1] += (labelPreviousLine + opcode + j)
                            labelPreviousLine=""
                    
                    else:
                        self._mipsMounter__lineError(line)
    def linkEdit(self):
        pc = self.startAdress

        for line_number, line in enumerate(self.mounted):
            if ":" in line:
                aux = line.split(":")
                self.mounted[line_number] = aux[1]
                self.__labelInsertLabel(aux[0].strip(), pc)
            pc += self.wordSize

        pc = self.startAdress
        for line in self.mounted:
            pc += self.wordSize

            if "=" in line:

                aux = line.split("=")
                opcode = aux[0]
                label = aux[1]
                label = mipsMounter.__numToBinary(int(self._mipsMounter__labelReturnIndex(label)/4), 26)
                self.linkEdited.append(opcode + label)

            elif "-" in line:

                aux = line.split("-")
                opcode = aux[0]
                label = aux[1]
                label = mipsMounter.__numToBinary(int((self._mipsMounter__labelReturnIndex(label) - pc)/4), 16)
                self.linkEdited.append(opcode + label)

            else:
                self.linkEdited.append(line)

if __name__ == '__main__':
    mounter = mipsMounter(str(sys.argv[3]), str(sys.argv[2]))
    mounter.mount()
    mounter.linkEdit()
    mounter.saveLinkEdited()