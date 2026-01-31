shader_type canvas_item;

uniform vec4 glowColor: source_color = vec4(0.2, 0.6, 0.3, 1.0);
uniform float glowPower: hint_range(0.0, 8.0, 0.1) = 2.0;
uniform float glowShift: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float glowRadius: hint_range(1.0, 10.0, 1.0) = 1.0;

void fragment() {
	vec4 glow = vec4(0.0);
	float count = 0.0;
	for (float x = -glowRadius; x <= glowRadius; x += 1.0) {
		for (float y = -glowRadius; y <= glowRadius; y += 1.0) {
			vec2 offset = vec2(x, y) * glowShift * TEXTURE_PIXEL_SIZE;
			glow += texture(TEXTURE, UV + offset) * glowColor;
			count += 1.0;
		}
	}
	glow *= glowPower / count;
	COLOR = mix(vec4(glowColor.xyz, texture(TEXTURE, UV).a), glow, glow.a);
}
