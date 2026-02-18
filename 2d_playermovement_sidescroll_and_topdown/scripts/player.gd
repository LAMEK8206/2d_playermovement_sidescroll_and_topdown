extends CharacterBody2D

#دریافت جاذبه از گیم انجین
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#گرفتن کلید های ورودی برای حرکت
@export var move_key : Array [Key] = [KEY_W,KEY_S,KEY_A,KEY_D,KEY_SPACE]

#مقادیر کنترل‌کننده‌ی بازیکن
@export var player_mode :bool = true
@export var player_move_speed :float = 100.0
@export var player_jump_power :float = 350.0

#ساخت آبجکت از نود AnimationSprite2D برای پخش انیمیشن‌ها
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass

# چک جهت انیمیشن ها
enum Direct{
	non , up , down , left , right
}
# مشخص کردن مقدار اویه داریکت
var direct : Direct = Direct.non 
func _physics_process(delta: float) -> void:
	
	#دریافت جهت های حرکت 
	var dirction = Vector2 (int(Input.is_key_pressed(move_key[3])) - int (Input.is_key_pressed(move_key[2])) ,
							int (Input.is_key_pressed(move_key[1])) - int(Input.is_key_pressed(move_key[0])) )

	#حرکت پلیر در حالت تاپ دون
	if  player_mode == false : #چک کردن حالت
		if dirction : 
			if Input.is_key_pressed(move_key[3]) :
				velocity.x = dirction.x * player_move_speed
				animated_sprite.flip_h = false # چرخاندن انیمشن پلیر
				animated_sprite.play("a&d_move") # کد اجرا کردن انیمشن
				direct = Direct.right # دادن مقدار به متقیری که مقدار دایرکت را میگیر بقه هم مشابه همین هستند
			if Input.is_key_pressed(move_key[2]) : 
				velocity.x = dirction.x * player_move_speed
				animated_sprite.flip_h = true
				animated_sprite.play("a&d_move")
				direct = Direct.left
			if Input.is_key_pressed(move_key[0]) :
				velocity.y = dirction.y *player_move_speed
				animated_sprite.play("w_move")
				direct = Direct.up
			if Input.is_key_pressed(move_key[1]) : 
				velocity.y = dirction.y * player_move_speed
				animated_sprite.play("s_move")
				direct = Direct.down
		else :
			velocity.x = 0
			velocity.y = 0
			if direct != Direct.non: # چک میکنیم که دکمه ای دکمه ای از کیبرد فشار داده نشده و انیمیشن ایدل پیشفرض پلی میشود
				animated_sprite.play("idel_" + str(direct))
	
	#حرکت کردن پلیر در حالت ساید اسکرول
	if player_mode == true : 
		
		#ا اعمال جاذبه به پلیر
		if not is_on_floor() : 
			velocity.y += gravity * delta
		# حرکت به سمت چپ و راست
		if dirction : 
			if Input.is_key_pressed(move_key[3]) :
				velocity.x = dirction.x * player_move_speed
				animated_sprite.flip_h = false
				animated_sprite.play("a&d_move")
				direct = Direct.right
			if Input.is_key_pressed(move_key[2]) : 
				velocity.x = dirction.x * player_move_speed
				animated_sprite.flip_h = true
				animated_sprite.play("a&d_move")
				direct = Direct.left
		else :
			velocity.x = 0
			if direct != Direct.non : 
				animated_sprite.play("idel_" + str(direct))
		# پریدن پلیر
		if Input.is_key_pressed(move_key[4]) and is_on_floor() : 
			velocity.y -= player_jump_power


	move_and_slide()
