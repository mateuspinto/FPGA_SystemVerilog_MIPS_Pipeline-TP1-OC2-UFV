nomes = "pcBranch_exMem_input, pcJump_signal_ifId_input, instruction_ifId_input, pc_ifId_input, instruction_ifId_output, pc_ifId_output, writeData_writeBack_output, immediateExtended_data_idEx_input, rs_data_idEx_input, rt_data_idEx_input, immediateExtended_data_idEx_output, rs_data_idEx_output, rt_data_idEx_output, aluResult_exMem_input, memWrite_data_exMem_input, aluResult_exMem_output, dataMemory_memWb_input, memWrite_data_exMem_output, aluResult_memWb_input, dataMemory_memWb_output, aluResult_memWb_output, pcIncremented_idEx_input, pcIncremented_idEx_output"
nomes = nomes.split(", ")

vetor = []
for i in nomes:
    vetor.append(i.replace("ifId", "0").replace("idEx", "1").replace("exMem","2").replace("memWb","3"))

vetor.sort()

string = ""
for i in range(len(vetor)):
    vetor[i] = (vetor[i].replace("0", "ifId").replace("1", "idEx").replace("2","exMem").replace("3","memWb"))
    string += vetor[i] + ", "

print(string)