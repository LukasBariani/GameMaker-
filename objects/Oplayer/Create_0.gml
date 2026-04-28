//iniciando primeiro estado
estado_idle = new estado();

estado_walk = new estado();

#region estado idle
estado_idle.inicia = function(){
	var _sprite = SplayerFrontIdle;
	
	
	switch (dir)
	{
		case 0:  _sprite = SplayerSideIdle; break ;
		case 1:  _sprite = SplayerBackIdle; break ;
		case 2:  _sprite = SplayerSideIdle; break ;
		case 3:  _sprite = SplayerFrontIdle; break ;
	}
	
	sprite_index = _sprite;
	//animaçao começa primeiro frame
	image_index = 0;
}

estado_idle.roda = function(){
	//verificar se algo faz o estado mudar 
	if (up or down or left or right){
		troca_estado(estado_walk)
	}
}
#endregion


#region estado walk
estado_walk.inicia = function(){
	sprite_index = SplayerFrontWalk;
	
	image_index = 0;
}


estado_walk.roda = function(){
	// ajuste direçao 
	dir = (point_direction(0,0, velh, velv) div 90)
	show_debug_message(dir);
	
	velv = (down - up) * vel ;
	velh = (right - left) * vel ;
	
	if (velh == 0 and velv == 0){
		troca_estado(estado_idle)
	}
}

#endregion

#region iniciando vars
//controle direçao player olhando
dir = 0;
//controles iniciados sem valor
up = noone;
down = noone;
left = noone; 
right = noone;

// vars 
vel = 2;

velh = 0;
velv = 0;
#endregion
//iniciando maq de estados
inicia_estado(estado_idle);


