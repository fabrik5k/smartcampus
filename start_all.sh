#!/bin/bash

echo "==== INICIANDO PROJETO SMARTCAMPUS (LINUX - EC2) ===="

# 1. Subir Kafka e Zookeeper via Docker
echo "==== Iniciando Docker Compose (Kafka e Zookeeper) ===="
cd ~/smartcampus/middleware/kafka
docker-compose up -d

# 2. Aguarda Kafka iniciar completamente
echo "==== Aguardando Kafka iniciar (tempo de segurança: 15 segundos) ===="
sleep 15

# 3. Volta para a pasta do projeto
cd ~/smartcampus

# 4. Criar ambiente virtual se ainda não existir
if [ ! -d "venv" ]; then
    echo "==== Criando ambiente virtual ===="
    python3 -m venv venv
fi

# 5. Ativar o ambiente virtual
source venv/bin/activate

# 6. Instalar as dependências
echo "==== Instalando dependências Python ===="
pip install --upgrade pip > /dev/null
pip install kafka-python flask flask-cors > /dev/null

# 7. Iniciar o Gateway em background
echo "==== Iniciando o Gateway ===="
nohup python3 gateway/gateway.py > logs/gateway.log 2>&1 &

# 8. Aguardar Gateway escutar as conexões
echo "==== Aguardando Gateway ficar pronto (5 segundos) ===="
sleep 5

# 9. Iniciar os Sensores em background
echo "==== Iniciando Sensores ===="
nohup python3 simuladores/sensor_temperatura.py > logs/temperatura.log 2>&1 &
nohup python3 simuladores/sensor_luminosidade.py > logs/luminosidade.log 2>&1 &
nohup python3 simuladores/sensor_presenca.py > logs/presenca.log 2>&1 &

# 10. Iniciar o consumidor Kafka em background
echo "==== Iniciando Consumidor Kafka ===="
nohup python3 middleware/kafka/consumidor.py > logs/consumidor.log 2>&1 &

# 11. (Opcional) Iniciar o Painel Flask
# nohup python3 painel/app.py > logs/painel.log 2>&1 &

echo "==== TODOS OS COMPONENTES FORAM INICIADOS COM SUCESSO ===="
