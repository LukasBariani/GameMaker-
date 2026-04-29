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
	estado_atual.finaliza();
	//rodando proximo estado 
	estado_atual = _estado;
	//inicia proximo estado 
	estado_atual.inicia();
}



//define Sprite 
function define_sprite(_dir = 0, sprite_side, sprite_back, sprite_front){
    var _sprite;
    
    switch (_dir)
    {
        case 0:  _sprite = sprite_side; break;  // direita
        case 1:  _sprite = sprite_back; break;  // cima
        case 2:  _sprite = sprite_side; break;  // esquerda (usa mesmo sprite lado)
        case 3:  _sprite = sprite_front; break; // baixo
    }
    return _sprite;
}