//iniciando primeiro estado
estado_idle = new estado();
estado_walk = new estado();

#region estado idle
estado_idle.inicia = function(){
    var _sprite = define_sprite(dir, SplayerSideIdle, SplayerBackIdle, SplayerFrontIdle);
    sprite_index = _sprite;
    image_index = 0;
    image_speed = 0.2; // velocidade da animação
}

estado_idle.roda = function(){
    // Atualiza inputs
    up = keyboard_check(vk_up);
    down = keyboard_check(vk_down);
    left = keyboard_check(vk_left);
    right = keyboard_check(vk_right);
    
    if (up or down or left or right){
        troca_estado(estado_walk);
    }
}
#endregion

#region estado walk
estado_walk.inicia = function(){
    var _sprite = define_sprite(dir, SplayerSideWalk, SplayerBackWalk, SplayerFrontWalk);
    sprite_index = _sprite;
    image_index = 0;
    image_speed = 0.3;
}

estado_walk.roda = function(){
    // Atualiza inputs
    up = keyboard_check(vk_up);
    down = keyboard_check(vk_down);
    left = keyboard_check(vk_left);
    right = keyboard_check(vk_right);
    
    // Calcula velocidade
    velv = (down - up) * vel;
    velh = (right - left) * vel;
    
    // Normaliza movimento diagonal (opcional, mas recomendado)
    if (velh != 0 and velv != 0) {
        velh *= 0.707;
        velv *= 0.707;
    }
    
    // Atualiza direção se houver movimento
    if (velh != 0 or velv != 0) {
        var _dir_angle = point_direction(0, 0, velh, velv);
        dir = floor(_dir_angle / 90);
    }
    
    // Movimento (ESCOLHA UM MÉTODO):
    
    // OPÇÃO 1: move_and_collide (recomendado para colisões)
    move_and_collide(velh, velv, all);
    
    // OPÇÃO 2: movimento simples (sem colisão)
    // x += velh;
    // y += velv;
    
    // Verifica se deve trocar para idle
    if (!up and !down and !left and !right){
        troca_estado(estado_idle);
    }
}
#endregion

#region iniciando vars
dir = 0;
up = false;
down = false;
left = false;
right = false;
vel = 2;
velh = 0;
velv = 0;
#endregion

//iniciando maq de estados
inicia_estado(estado_idle);