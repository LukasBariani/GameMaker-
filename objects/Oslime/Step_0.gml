switch (state) {
    
    case SlimeState.IDLE:
        state_idle();
    break;
    
    case SlimeState.CHASE:
        state_chase();
    break;
    
    case SlimeState.ATTACK:
        state_attack();
    break;
    
    case SlimeState.HURT:
        state_hurt();
    break;
    
    case SlimeState.DEAD:
        state_dead();
    break;
}