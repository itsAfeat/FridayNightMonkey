shader_type spatial;
render_mode unshaded;

uniform sampler2D _GRADIENT: hint_albedo;
uniform float _FOG_INTESITY:  hint_range(0.0, 1.0);
uniform float _FOG_AMOUNT: hint_range(0.0, 1.0);

void vertex() {
	POSITION = vec4(VERTEX,	1.0);
}

void fragment() {
	vec4 original = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	float depth = texture(DEPTH_TEXTURE, SCREEN_UV).x;
	vec3 ndc= vec3(SCREEN_UV, depth) * 2.0 - 1.0;
	vec4 view = INV_PROJECTION_MATRIX* vec4(ndc, 1.0);
	view.xyz /= view.w;
	depth = -view.z;
	
	float fog = depth * _FOG_AMOUNT;
	
	vec4 fog_color = texture(_GRADIENT, vec2(fog, 0.0));
	if (depth > 1.0)
		ALBEDO =  mix(original.rgb, fog_color.rgb, fog_color.a * _FOG_INTESITY);
	else
		ALBEDO = fog_color.rgb;
}