Shader "Unlit/DiffuseShader"
{
	Properties 
       {
           _MainTex ("Base (RGB)", 2D) = "white" {}
           _Ambient ("Ambient", Range (0, 1)) = 0
       }
       SubShader 
       {
           Pass
           {
               Tags { "RenderType"="Opaque" "LightMode"="ForwardBase"}
               CGPROGRAM
               #pragma vertex vert
               #pragma fragment frag
               #include "UnityCG.cginc"
   
               sampler2D _MainTex;
               float4    _LightColor0;
               float	_Ambient;
               
               struct VertexOutput 
               {
                   float4 pos:SV_POSITION;
                   float2 uv_MainTex:TEXCOORD0;
                   float3 normal:TEXCOORD1;
               };
   
               VertexOutput vert(appdata_base input)
               {
                   VertexOutput o;
                   o.pos = mul(UNITY_MATRIX_MVP,input.vertex);
                   o.uv_MainTex = input.texcoord.xy;
                   o.normal = normalize(input.normal);
                   return o;
               }
   
               float4 frag(VertexOutput input):COLOR
               {
                   float3 normalDir = normalize(input.normal);
                   float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                   float3 Kd = tex2D(_MainTex,input.uv_MainTex).xyz;
                   float3 diffuseColor = Kd * _LightColor0.rgb * max(0,dot(normalDir,lightDir));
                   float3 ambientColor = Kd * _Ambient;
                   return float4(diffuseColor + ambientColor,1);
               }
               ENDCG
           }
       } 
       FallBack "Diffuse"
}