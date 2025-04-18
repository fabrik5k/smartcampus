from concurrent import futures
import grpc
import controle_pb2
import controle_pb2_grpc

class ControleService(controle_pb2_grpc.ControleServiceServicer):
    def EnviarComando(self, request, context):
        print(f"Comando recebido: {request.dispositivo} -> {request.acao}")
        return controle_pb2.ComandoResponse(status="Comando executado com sucesso")

def servir():
    servidor = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    controle_pb2_grpc.add_ControleServiceServicer_to_server(ControleService(), servidor)
    servidor.add_insecure_port('[::]:50051')
    servidor.start()
    servidor.wait_for_termination()

if __name__ == '__main__':
    servir()
