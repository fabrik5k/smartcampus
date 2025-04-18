// Função para simular dados dos sensores
function atualizarSensores() {
    // Simular temperatura entre 20 e 30 °C
    const temperatura = (Math.random() * 10 + 20).toFixed(2);
    document.getElementById('temperatura').textContent = `${temperatura} °C`;

    // Simular luminosidade entre 300 e 800 lx
    const luminosidade = Math.floor(Math.random() * 500 + 300);
    document.getElementById('luminosidade').textContent = `${luminosidade} lx`;

    // Simular presença: "Sim" ou "Não"
    const presenca = Math.random() > 0.5 ? 'Sim' : 'Não';
    document.getElementById('presenca').textContent = presenca;
}

// Atualizar os dados a cada 5 segundos
setInterval(atualizarSensores, 5000);

// Atualizar imediatamente ao carregar a página
atualizarSensores();
