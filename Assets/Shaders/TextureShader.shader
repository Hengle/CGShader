Shader "Unlit/TextureShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vertMain
			#pragma fragment fragMain
			
			
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			
			v2f vertMain (appdata_base v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}
			
			float4 fragMain (v2f i) : COLOR
			{
				// sample the texture
				float4 col = tex2D(_MainTex, i.uv);
							
				return col;
			}
			ENDCG
		}
	}
	
	FallBack "Diffuse"
}
