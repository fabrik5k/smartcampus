import socket
import threading

def lidar_com_conexao(conexao, endereco):
    print(f"Conexão estabelecida com {endereco}")
    while True:
        dados = conexao.recv(1024)
        if not dados:
            break
        mensagem = dados.decode()
        print(f"Recebido de {endereco}: {mensagem}")
    conexao.close()

def iniciar_servidor(porta):
    host = '0.0.0.0'
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as servidor:
        servidor.bind((host, porta))
        servidor.listen()
        print(f"Gateway escutando na porta {porta}")
        while True:
            conexao, endereco = servidor.accept()
            threading.Thread(target=lidar_com_conexao, args=(conexao, endereco)).start()

if __name__ == "__main__":
    portas = [5000, 5001, 5002]
    for porta in portas:
        threading.Thread(target=iniciar_servidor, args=(porta,)).start()
