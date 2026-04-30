lifetime--;
if (lifetime <= 0) {
    instance_destroy();
    exit;
}


// checa colisão com inimigos
var _hit = instance_place(x, y, Oslime);
if (_hit != noone) {
    var _dir = point_direction(_hit.x, _hit.y, owner.x, owner.y);
    // direção inversa: empurra o slime pra longe do player
    _dir = point_direction(owner.x, owner.y, _hit.x, _hit.y);
    
    _hit.take_damage(damage, _dir);
    instance_destroy(); // hitbox some após acertar
}