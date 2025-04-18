#!/bin/bash

echo "==== ENCERRANDO PROJETO SMARTCAMPUS ===="

# 1. Parar containers Kafka e Zookeeper
echo "==> Parando Kafka e Zookeeper (Docker Compose)"
cd ~/smartcampus/middleware/kafka
docker-compose down

# 2. Voltar para o diretório principal do projeto
cd ~/smartcampus

# 3. Parar processos Python relacionados (sensores, gateway, consumidor, painel)
echo "==> Encerrando processos Python relacionados ao projeto"

# Mata processos pelas pastas
for proc in gateway/gateway.py simuladores/sensor_temperatura.py simuladores/sensor_luminosidade.py simuladores/sensor_presenca.py middleware/kafka/consumidor.py painel/app.py
do
    pkill -f $proc
done

echo "✅ TODOS OS COMPONENTES FORAM ENCERRADOS."
