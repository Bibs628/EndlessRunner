shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float effect_amount : hint_range(-2.5, 2.5) = 1.0;

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec4 fragCoord = FRAGCOORD;
	vec2 p = fragCoord.xy / iResolution.x;
	float prop = iResolution.x / iResolution.y;
	vec2 m = vec2(0.5, 0.5 / prop);
	vec2 d = p - m;
	float r = sqrt(dot(d, d));
	float power = effect_amount;
	float bind;

	if (power > 0.0)
		bind = sqrt(dot(m, m));
	else {
		if (prop < 1.0)
    		bind = m.x;
    	else
        	bind = m.y;
	}

	vec2 uv;
	if (power > 0.0)
		uv = m + normalize(d) * tan(r * power) * bind / tan( bind * power);
	else
		uv = p;
    uv.y *= prop;
	vec3 col = texture(SCREEN_TEXTURE, uv).rgb;
	COLOR = vec4(col, 1.0);
}