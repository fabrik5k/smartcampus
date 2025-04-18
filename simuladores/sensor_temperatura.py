import socket
import time
import random

def sensor_temperatura():
    host = 'localhost'
    port = 5000
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((host, port))
        while True:
            temperatura = round(random.uniform(20.0, 30.0), 2)
            mensagem = f"TEMP:{temperatura}"
            s.sendall(mensagem.encode())
            time.sleep(5)

if __name__ == "__main__":
    sensor_temperatura()
