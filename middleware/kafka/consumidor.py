from kafka import KafkaConsumer

consumidor = KafkaConsumer('topico_sensores', bootstrap_servers='localhost:9092')

for mensagem in consumidor:
    print(f"Mensagem recebida: {mensagem.value.decode()}")
