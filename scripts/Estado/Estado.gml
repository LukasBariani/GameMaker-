//inicia maquina de estado 
function estado() constructor {
		//inicia
		static inicia = function() {};
		
		//rodando
		static roda = function() {};
		
		//finalizando
		static finaliza = function() {};
}


//funçoes pra controlar maq. de estado---------------------


function inicia_estado(_estado) {
	//save o estado numa var
	estado_atual = _estado;
	//inicia estado atual
	estado_atual.inicia();
}

function roda_estado() {
	//roda estado atual
	estado_atual.roda();
}


function troca_estado(_estado) {
	//finaliza o estado atual
	_estado.finaliza();
	//rodando proximo estado 
	estado_atual = _estado;
	//inicia proximo estado 
	estado_atual.inicia();
}
