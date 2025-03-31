extends CharacterBody2D

#دریافت جاذبه از گیم انجین
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#این متغیر برای ضرب در مقادیر دیگر به منظور کوچک کردن مقادیر اصلی است
const power :float = 50.0
#مقادیر کنترل‌کننده‌ی بازیکن
@export var check_player_mode :bool = true
@export var player_move_speed :float = 100.0
@export var player_jump_power :float = 400.0

#ساخت آبجکت از نود AnimationSprite2D برای پخش انیمیشن‌ها
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	#چک کردن حالت‌های بازیکن
	if check_player_mode == true :
		#اعمال جاذبه به بازیکن
		velocity.y += gravity * delta 
		
		#حرکت دادن بازیکن به سمت چپ و راست
		if Input.is_action_pressed("a_player_move_left") : 
			velocity.x = -player_move_speed * power * delta
			animated_sprite.flip_h = true
			animated_sprite.play("a&d_move")
		elif Input.is_action_just_released("a_player_move_left") : 
			velocity.x = 0
			animated_sprite.play("a&d_idel")

		if Input.is_action_pressed("d_player_move_right") : 
			velocity.x = player_move_speed * power * delta
			animated_sprite.flip_h = false
			animated_sprite.play("a&d_move")
		elif Input.is_action_just_released("d_player_move_right") : 
			velocity.x = 0
			animated_sprite.play("a&d_idel")
			
		#اضافه کردن پرش به بازیکن
		if is_on_floor() and Input.is_action_just_pressed("k_player_jump") : velocity.y += -player_jump_power * power *delta
		
	#چک کردن حالت‌های بازیکن
	if check_player_mode == false :
		#حرکت بازیکن در حالت تاپ‌داون به چهار جهت
		if Input.is_action_pressed("a_player_move_left") : 
			velocity.x = -player_move_speed * power * delta
			animated_sprite.flip_h = true
			animated_sprite.play("a&d_move")
		elif Input.is_action_just_released("a_player_move_left") : 
			velocity.x = 0
			animated_sprite.play("a&d_idel")
		
		if Input.is_action_pressed("d_player_move_right") : 
			velocity.x = player_move_speed * power * delta
			animated_sprite.flip_h = false
			animated_sprite.play("a&d_move")
		elif Input.is_action_just_released("d_player_move_right") : 
			velocity.x = 0
			animated_sprite.play("a&d_idel")
		
		if Input.is_action_pressed("w_player_move_up") : 
			velocity.y = -player_move_speed * power * delta
			animated_sprite.play("w_move")
		elif Input.is_action_just_released("w_player_move_up") : 
			velocity.y = 0
			animated_sprite.play("w_idel")
		
		if Input.is_action_pressed("s_player_move_down") : 
			velocity.y = player_move_speed * power * delta
			animated_sprite.play("s_move")
		elif Input.is_action_just_released("s_player_move_down") : 
			velocity.y = 0
			animated_sprite.play("s_idel")
		
	move_and_slide()
