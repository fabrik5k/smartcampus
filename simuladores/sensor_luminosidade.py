import socket
import time
import random

def sensor_luminosidade():
    host = 'localhost'
    port = 5001
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((host, port))
        while True:
            luminosidade = round(random.uniform(300.0, 800.0), 2)
            mensagem = f"LUM:{luminosidade}"
            s.sendall(mensagem.encode())
            time.sleep(5)

if __name__ == "__main__":
    sensor_luminosidade()
