#ifdef GL_ES
precision mediump float;
#endif

varying float height;

uniform vec2 u_resolution;
uniform float u_time;

uniform sampler2D mountainTexture;
uniform sampler2D waterTexture;
uniform sampler2D snowTexture;
uniform sampler2D grassTexture;
uniform sampler2D groundTexture;

varying vec3 vertNormal;
varying vec3 vertLightDir;

void main() {  
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    
    vec2 waterPoint = st + vec2(u_time, 0);
    if (waterPoint.x>1.0) waterPoint.x = mod(waterPoint.x,1.0);
    
    vec4 waterT = texture2D(waterTexture, waterPoint);
    vec4 mountainT = texture2D(mountainTexture, st);
    vec4 snowT = texture2D(snowTexture, st);
    vec4 grassT = texture2D(grassTexture, st);
    vec4 groundT = texture2D(groundTexture, st);
    
    vec3 color;
    
    if (height <= -1) color=waterT.rgb*0.7f;
    else {
      if (height < 15)  {
        color = grassT.rgb;
        color = mix(groundT.rgb,grassT.rgb, (15.0-height)/16.0);
      }
      else if(height < 35) {
        color = groundT.rgb;
        color = mix(mountainT.rgb,groundT.rgb, (35.0-height)/20.0);
      }
      else {
        color = snowT.rgb;
        color = mix(snowT.rgb,mountainT.rgb, (45.0-height)/10.0);
      }
        
      float intensity;
      
      // Producto escalar normal y vector hacia la fuente de luz
      intensity = max(0.0, dot(vertLightDir, vertNormal));
    
      color*=intensity;
  }
  
  gl_FragColor = vec4(color.r, color.g, color.b, 1.);
}
