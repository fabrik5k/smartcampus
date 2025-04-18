# Projeto SmartCampus - Plataforma Distribuída de Monitoramento

Este projeto simula uma plataforma de **monitoramento e controle inteligente de ambientes**, utilizando uma arquitetura distribuída com comunicação via **Sockets**, **Apache Kafka** e microsserviços em **Python** e com deploy feito na **AWS**

## 📦 Estrutura do Projeto

```
smartcampus/
├── gateway/                  # Servidor que recebe dados dos sensores via socket e envia ao Kafka
├── simuladores/             # Simuladores de sensores (temperatura, luminosidade e presença)
├── middleware/kafka/        # Produtor, consumidor e Docker Compose do Kafka
├── painel/                  # Painel web Flask para visualização dos dados em tempo real
├── start_all.sh             # Script que inicia todos os componentes em ordem
├── stop_all.sh              # Script que encerra todos os serviços
├── requirements.txt         # Dependências do projeto
└── README.md                # Este documento
```

## 🚀 Tecnologias Utilizadas

- Python 3.11+
- Flask + Flask-CORS
- Apache Kafka + Zookeeper (via Docker Compose)
- Sockets TCP
- Docker / Docker Compose
- EC2 (AWS)

## 🔧 Como Executar

### 1. Subir Kafka e ambiente com Docker

```bash
cd middleware/kafka
docker-compose up -d
```

### 2. Ativar ambiente virtual

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 3. Executar todos os serviços

```bash
./start_all.sh
```

### 4. Acessar o painel

No navegador, abra: `http://<IP-DA-EC2>:5000`

## 📡 Comunicação Entre Componentes

- Sensores → Gateway (TCP Socket)
- Gateway → Kafka (Produtor)
- Kafka → Consumidor (dados em tempo real)
- Consumidor → Variável Global → Painel Flask (HTTP GET /dados)

## 📁 Logs

Todos os serviços geram arquivos de log na pasta `logs/` para facilitar o monitoramento.

## 🧪 Observação

Este sistema é uma **simulação acadêmica** e pode ser adaptado para cenários reais com:
- Autenticação/autorização
- Banco de dados persistente
- HTTPS
- Balanceamento de carga

---

Estudante: João Renan S. Lopes
Professor: Fábio Araújo
Disciplina: Programação Paralela e Distribuída
Instituição: Centro Universitário do Pará
