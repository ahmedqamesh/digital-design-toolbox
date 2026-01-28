import sys
import os
import time
from SerialServer import SerialServer
bistream_dir = "/run/media/dcs/data2/workspaces/mopshub_reconfig/mopshub_reconfig.runs/"
bitsream_file = [bistream_dir+"child_1_impl_2/mopshub_reconfig_bd_i_partition_greybox_partial.bit",# gray box dynamic
                 bistream_dir+"child_0_impl_2/mopshub_reconfig_bd_i_partition_shift_right_inst_0_partial.bit", # shift right  dynamic 
                 bistream_dir+"impl_2/mopshub_reconfig_bd_i_partition_shift_left_inst_0_partial.bit",
                 bistream_dir+"impl_2/mopshub_reconfig_bd_wrapper.bit"]
FILE1 = bistream_dir+"impl_2/mopshub_reconfig_bd_i_partition_shift_left_inst_0_partial.bit"
ser = SerialServer(port = "/dev/ttyUSB5")

def bitSwap(packet):
    # reverse the bits in each byte in bytearray, formats every byte to 8 bit binary string and reverses it
    # by using slicing. Slicing returns a string that must be converted to a binary integer
    return bytearray(int('{:08b}'.format(byte)[::-1], 2) for byte in packet)

def _write(bitsream_file =None):
    # open file, read binary
    print("writing %s to UART"%bitsream_file)
    with open(bitsream_file, "rb") as file:
        while file:
            # read maximum of 255 bytes at once
            packet = file.read(255)
            reversed_byte_array = bitSwap(packet)

            # check if file ende
            if packet:
                byte_list = bytearray(bytes.fromhex("7E") + # (Flag)convert this to a bytes object 
                                      bytes.fromhex("00") + # write address
                                      len(reversed_byte_array).to_bytes(1, 'big') + # DLC
                                      reversed_byte_array +  #Data
                                      bytes.fromhex("7E")) #(Flag)convert this to a bytes object
            
                ser.tx_data(data = byte_list)
            else:
                break

def _write_uart_test():
    # open file, read binary
    # read maximum of 255 bytes at once
    reversed_byte_array = [bytes.fromhex("DE"),bytes.fromhex("AD")]
    byte_list = bytearray(bytes.fromhex("7E") + # (Flag)convert this to a bytes object 
                          bytes.fromhex("00") + # write address
                          len(reversed_byte_array).to_bytes(1, 'big') + # DLC
                          bytes.fromhex("DE")+bytes.fromhex("be") +  #Data
                          bytes.fromhex("7E")) #(Flag)convert this to a bytes object
    #for i in byte_list:
    print(byte_list)
    ser.tx_data(data = byte_list)


def _read(port=None):
    byte_array = bytearray()
    # concatenate given address to full address string, slicing off 0x
    address = hex(int(str('00101000000000') + str(self.lineEditRegister.text()) + str('0000000000001'), 2))[2:]
    #print(self.lineEditRegister.text())

    print(address)
    bitstream = ["WR FFFFFFFF",
                 "WR AA995566",
                 "WR 20000000",
                 "WR " + address,
                 "WR 20000000",
                 #"RD 20000000",
                 "RD 01",
                # "RD FFFFFFFF",
                 #"RD 20000000", # dummy for checking
                 "WR 30008001",
                 "WR 0000000D",
                 "WR 20000000",
                 "WR 20000000"
                 ]

    for item in bitstream:
        rw, hex_value = item.split(maxsplit=1)
        if rw.casefold() == "wr":
            reversed_byte_array = bitSwap(bytearray.fromhex(hex_value))
            byte_list = bytearray(bytes.fromhex("7E") + bytes.fromhex("00") +
                                  len(reversed_byte_array).to_bytes(1, 'big') +
                                  reversed_byte_array + bytes.fromhex("7E"))
            
            self.tx_data(byte_list)
        elif rw.casefold() == "rd":
            reversed_byte_array = bytearray.fromhex(hex_value)
            byte_list = bytearray(bytes.fromhex("7E") + bytes.fromhex("01") +
                                  len(reversed_byte_array).to_bytes(1, 'big') +
                                  reversed_byte_array + bytes.fromhex("7E"))
            ser.tx_data(byte_list)
        else:
            continue


if __name__ == "__main__":
    import sys
    for file in bitsream_file[1:]:  
        _write(bitsream_file = file)
        print("======================================================================================")
        time.sleep(90)
    #_write_uart_test()
    #print(ports_return)
    
    
    
    
    