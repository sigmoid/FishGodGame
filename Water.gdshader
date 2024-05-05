shader_type canvas_item;

uniform sampler2D noiseA;
uniform sampler2D noiseH;
//uniform sampler2D noiseG;
//uniform sampler2D noiseB;
uniform float colorMin:hint_range(0.0, 1.0);
uniform float scrollAmount:hint_range(0.0, 1.0);

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

float noiseV(sampler2D noiseSample,vec2 _UV){
	vec4 noiseTexture = texture(noiseSample,_UV);
	float val = (noiseTexture.r + noiseTexture.g + noiseTexture.b)/3.0;
	return val;
}

void fragment(){
	float outGrad = pow(distance(vec2(0.5,0.0),UV),2.5);
	float xScroll =(sin(TIME)/64.0);
	vec2 scroll = vec2(xScroll,sin(TIME/2.0)/10.0);
	float _a = noiseV(noiseA,UV+scroll);
	vec3 c1 = vec3(0.1,0.15,0.23);
	vec3 c2 = vec3(0.1,0.4,0.55);
	vec3 color = mix(c1,c2,_a);
	vec3 c3 = vec3(0.1,0.6,0.4);
	color = mix(color,c3,mix(0.0,0.15,(1.0-outGrad)));
	//_a *= step(0.5,texture(TEXTURE,UV).a);
	COLOR = vec4(color,1.0);
	
}
