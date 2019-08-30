import os
from mipsMounter import mipsMounter

def showMenu():
    print("###################################################################################################")
    print("#                                       Welcome to MIPS                                           #")
    print("###################################################################################################")
    print("# 1- Create the library to perform the simulation                                                 #")
    print("# 2- Perform the simulation                                                                       #")
    print("# 3- Show results                                                                                 #")
    print("# 4- Show fpga project in Quartus Prime                                                           #")
    print("# 7- Turn MIPS Assembly into binary")
    print("# 8- Clean results and library                                                                    #")
    print("# 9- Exit                                                                                         #")
    print("# Note: If you dont know what are you doing, simple input the numbers in order one by one         #")
    print("###################################################################################################")

librarier = "vlib work"
syntetizer = "vlog"
simulator = "vsim"

testbench = "testbench"
files = testbench + ".sv auxModules.sv libMips.sv forward.sv hazard.sv pipelineRegisters/if_id/if_id.sv pipelineRegisters/id_ex/id_ex.sv pipelineRegisters/ex_mem/ex_mem.sv pipelineRegisters/mem_wb/mem_wb.sv stages/instructionFetch/adderProgramCounter.sv stages/instructionFetch/instructionFetch.sv stages/instructionFetch/instructionMemory.sv stages/instructionFetch/programCounter.sv stages/instructionDecode/branchControl.sv stages/instructionDecode/controller.sv stages/instructionDecode/instructionDecode.sv stages/instructionDecode/registerDatabase.sv stages/instructionDecode/zeroTest.sv stages/executing/alu.sv stages/executing/aritimeticalControl.sv stages/executing/executing.sv stages/memory/memoryDatabase.sv stages/memory/memory.sv stages/writeBack/writeBack.sv"
exit = 0

showMenu()
selection = int(input("Type an option: "))

while exit == 0:
    if selection == 0:
        showMenu()
        selection = int(input("Type another option or type 0 to show the menu again: "))

    elif selection == 1:

        print("Creating library...")
        os.system(librarier)

        selection = int(input("Type another option or type 0 to show the menu again: "))

    elif selection == 2:

        print("Syntetizing simulation...")
        os.system(syntetizer + " " + files)
        
        selection = int(input("Type another option or type 0 to show the menu again: "))

    elif selection == 3:

        print("Showing simulation...")
        os.system(simulator + " " + testbench)

        selection = int(input("Type another option or type 0 to show the menu again: "))

    elif selection == 4:
        print("Opening Quartus Prime...")
        os.system("simpleMips.qpf")

        selection = int(input("Type another option or type 0 to show the menu again: "))

    elif selection == 7:
        mounter = mipsMounter("instruction.asm", "stages/instructionFetch/instruction.txt")
        mounter.mount()
        mounter.linkEdit()
        mounter.saveLinkEdited()

        mounter = None

        selection = int(input("Type another option or type 0 to show the menu again: "))

    elif selection == 8:

        print("Cleaning...")
        # Please dont uncomment this until the work is finished +_+
        os.system("git clean -ffxd :/")

        selection = int(input("Type another option or type 0 to show the menu again: "))

    elif selection == 9:
        exit=1

    else:
        selection = int(input("Type another option or type 0 to show the menu again: "))

print("Thank ya")