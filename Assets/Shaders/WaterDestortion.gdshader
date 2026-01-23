shader_type canvas_item;

uniform float speed: hint_range(0.01, 0.5) = 0.1;
uniform float strength: hint_range(0.01, 0.5) = 0.1;

uniform sampler2D noise: repeat_enable;

void fragment() {
	vec2 uv = SCREEN_UV;
	vec4 original = texture(TEXTURE, UV);
	
	float noiseValue = texture(noise, UV + TIME * speed).r;
	vec4 finalColor = texture(TEXTURE, UV - strength / 2.0 + vec2(noiseValue) * strength);
	COLOR = vec4(finalColor);
}