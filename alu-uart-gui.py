import tkinter as tk
from tkinter import ttk
from tkinter import messagebox
import serial
import threading
import time

main_window = tk.Tk()
main_window.geometry('235x200') # resolution de la window
main_window.title("ALU UART GUI")
main_window.config(background="lightgoldenrod")
main_window.resizable(False, False)

class Flags: # objeto flags para usar como flags valga la redundancia
    connected:bool # para saber si conectado el puerto serie
    hex_dec:bool # para saber si mostrar los datos en formato hexadecimal o decimal (False = hex)
    not_gud:bool

flags = Flags()
flags.connected=False
flags.hex_dec=False
flags.not_gud=False

class thread(threading.Thread):
    def __init__(self, thread_name, thread_ID):
        threading.Thread.__init__(self)
        self.thread_name = thread_name
        self.thread_ID = thread_ID

    def run(self):
        while True:
            if ser.inWaiting():
                if (not flags.not_gud):
                    flags.not_gud = True
                else:
                    received = int.from_bytes(ser.readline(), byteorder='big') & 0xFF
                    # receivedHex = f'0x{received:08X}'
                    result_frame.config(text=received)

def connect(): # se llama al apretar el boton conectar
    if flags.connected:
        messagebox.showinfo("Aviso", "Ya se encuentra conectado")
        return
    try:
        global ser
        ser = serial.Serial(port_entry.get(), 38400, 8, timeout=1)
    except serial.SerialException:
        messagebox.showinfo("Error de conexion", "Hay un problema con el puerto serie")
        return
    else:
        messagebox.showinfo("Aviso", "Conexión establecida exitosamente.")
        flags.connected = True
        global serial_thread
        serial_thread = thread("SERIAL_THREAD", "666")
        serial_thread.start()
        while(not flags.not_gud):
            ser.write('b'.encode())
            time.sleep(0.2)

def send():
    if not flags.connected:
        messagebox.showinfo("Error de conexion", 'Primero hay que conectarse al puerto serie')
    try:
        dato_a = int(datoA_entry.get())
        dato_b = int(datoB_entry.get())

        if not (0 <= dato_a <= 255) or not (0 <= dato_b <= 255):
            messagebox.showinfo("Problema con los inputs", "Los inputs no pueden ser mayores que 255")
            return
        
        # dato_a_chr = chr(dato_a)
        # dato_b_chr = chr(dato_b)
        
        dA = dato_a.to_bytes(1,"big")
        dB = dato_b.to_bytes(1,"big")
        

        dO = get_opcode(opcode_list.get())
        
        print("DATO A: " + str(dA))
        print("DATO B: " + str(dB))
        print("OPCODE: " + str(dO))
        if (dO == 'b'):
            dFull = dA + dB + dO
        else:
            dFull = dB + dA + dO
        
        # ser.write(dO)

        ser.write(dFull)
        ser.write(dFull)
        
    except serial.SerialException:
        messagebox.showinfo("Error de conexion", "Hubo un problema con el puerto serie")
        return    

def get_opcode(opcode_string):
    if (opcode_string == "ADD"):   return b'\x61' # 01100001
    elif (opcode_string == "SUB"): return b'\x62' # 01100010
    elif (opcode_string == "AND"): return b'\x63' # 01100011
    elif (opcode_string == "OR"):  return b'\x64' # 01100100
    elif (opcode_string == "XOR"): return b'\x65' # 01100101
    elif (opcode_string == "NOR"): return b'\x66' # 01100110
    elif (opcode_string == "SRL"): return b'\x67' # 01100111
    else:                          return b'\x68' # 01101000

port_label = tk.Label(main_window,text="Puerto:",background="lightgoldenrod")
port_label.place(x=20, y=15)
port_entry = tk.Entry(main_window,width=10)
port_entry.place(x=80,y=15)
port_entry.insert(tk.END,"COM6")

connect_button = tk.Button(main_window, text="Conectar", command=lambda: connect())
connect_button.place(x=160,y=12)

datoA_label = tk.Label(main_window,text="Dato A",background="lightgoldenrod")
datoA_label.place(x=20, y=60)
datoA_entry = tk.Entry(main_window,width=10)
datoA_entry.place(x=12,y=86)

datoB_label = tk.Label(main_window,text="Dato B",background="lightgoldenrod")
datoB_label.place(x=102, y=60)
datoB_entry = tk.Entry(main_window,width=10)
datoB_entry.place(x=92,y=86)

opcode_label = tk.Label(main_window,text="Opcode",background="lightgoldenrod")
opcode_label.place(x=175, y=60)

opcode_list = ttk.Combobox(
    state="readonly",
    values=["ADD", "SUB", "AND", "OR", "XOR", "NOR", "SRL", "SRA"],
    width=4
)
opcode_list.place(x=175,y=85)

send_button = tk.Button(main_window, text="GO!", command=lambda: send(),width=10,height=2,background="yellowgreen")
send_button.place(x=20,y=130)

result_label = tk.Label(main_window,text="Resultado", background="lightgoldenrod")
result_label.place(x=130,y=120)
result_frame = tk.Label(main_window,bg="white",relief=tk.SUNKEN,bd=2,width=10,height=1)
result_frame.place(x=130,y=145)

main_window.mainloop()