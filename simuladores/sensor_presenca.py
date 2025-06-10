import socket
import time
import random

def sensor_presenca():
    # host = 'localhost'
    host = 'gateway'
    port = 5002
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((host, port))
        while True:
            presenca = random.choice([0, 1])
            mensagem = f"PRES:{presenca}"
            s.sendall(mensagem.encode())
            time.sleep(5)

if __name__ == "__main__":
    sensor_presenca()
