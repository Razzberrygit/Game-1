shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

//uniform float z_index = 0.25;
//uniform float zIndexStrength = 1;

uniform float blurAmount: hint_range(0.0, 5.0) = 0.25;
uniform float mixAmount: hint_range(0.0, 1.0) = 0.4;
uniform vec4 color_over: source_color = vec4 (0.05098, 0.05098, 0.10196, 1.0);

void fragment() {
	vec4 blurredTexture = textureLod(SCREEN_TEXTURE, SCREEN_UV, blurAmount);

	COLOR.rgb = mix(blurredTexture.rgb, color_over.rgb, mixAmount);
	COLOR.a = 1.0;
}
