
Shader "Custom/DepthWrite" {
Properties {
		_DepthTex ("Depth Texture", 2D) = "white" {}
		_RenderedTex ("Rendered Image", 2D) = "white" {}
		//_Near("Near clipping plane", Float) = 1
		//_Far("Far clipping plane", Float) = 40
	}	
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct vertOut {
				float4 pos:SV_POSITION;
				float2 uv:TEXCOORD0;
			};

			vertOut vert(appdata_base v) {
				vertOut o;
				//Transforms a point from object space to the camera’s clip space in homogeneous coordinates. 
				//This is the equivalent of mul(UNITY_MATRIX_MVP, float4(pos, 1.0)), and should be used in its place.
				o.pos = UnityObjectToClipPos (v.vertex); 
				o.uv = v.texcoord.xy;
				return o;
			}

			uniform sampler2D _DepthTex;
			uniform sampler2D _RenderedTex;
			uniform float4x4 _Perspective;	// The perspective projection of the Unity camera
			uniform float _Near;
			uniform float _Far;
			//for 3D photo
			

			struct fout {
                    half4 color : COLOR;
                    float depth : DEPTH;
                };    
			
			
			fout frag( vertOut i ) {      
			
                    fout pshift;

					// Read the depth from the depth texture
					float4 imageDepth3D = tex2D(_DepthTex, i.uv);
					//float imageDepth = -(1 - imageDepth3D).x;
					//1 - imageDepth3D:flip depth map black&white.
					//-1* : camera Z flip.
					//result : (imageDepth3D-1).x
					float imageDepth = (imageDepth3D-1.0).r;					
					
					// Go back to clip space by computing the depth as the depth of the pixel from the camera
					float4 temp = float4(0, 0, (imageDepth * (_Far - _Near) - _Near) , 1);
					float4 clipSpace = mul(_Perspective, temp);
					
					// Carry out the perspective division and map into screen space (DirectX)					
					// We only care about z
					clipSpace.z /= clipSpace.w;
					clipSpace.z = 0.5*(1.0 - clipSpace.z);
					float z = clipSpace.z;

					// Write out the pre-computed color and the correct depth.
					
					pshift.color = tex2D(_RenderedTex, i.uv);
					pshift.depth = z;
					
                    return pshift;
					
                }
			
			

			

			ENDCG
		}
	}
}