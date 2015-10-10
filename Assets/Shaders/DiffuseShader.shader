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
               float4    _LightColor0; //灯光颜色
               float	_Ambient;        //环境光系数
               
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
                    // 顶点法向量
                   float3 normalDir = normalize(input.normal);
                    // 顶点指向光源的方向向量
                   float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
                    // 材质对环境光的反射系数即材质的颜色分量
                   float3 Kd = tex2D(_MainTex,input.uv_MainTex).xyz;
                    // 计算漫反射
                   float3 diffuseColor = Kd * _LightColor0.rgb * max(0,dot(normalDir,lightDir));
                    // 计算环境光
                   float3 ambientColor = Kd * _Ambient;
                   return float4(diffuseColor + ambientColor,1);
               }
               ENDCG
           }
       } 
       FallBack "Diffuse"
}