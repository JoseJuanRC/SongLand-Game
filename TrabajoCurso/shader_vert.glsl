#define PROCESSING_TEXTLIGHT_SHADER

uniform mat4 transform;
uniform mat3 normalMatrix;

uniform vec3 lightNormal[8];

attribute vec4 vertex;
attribute vec3 normal;

varying float height;

varying vec3 vertNormal;
varying vec3 vertLightDir;

void main() {
  
  height = vertex.z;

  gl_Position = transform * (vertex);
  
  vertNormal = normalize(normalMatrix * normal);
  
  vertLightDir = -lightNormal[0]; 
}
