from kafka import KafkaProducer

produtor = KafkaProducer(bootstrap_servers='localhost:9092')

def enviar_mensagem(topico, mensagem):
    produtor.send(topico, mensagem.encode())
    produtor.flush()
