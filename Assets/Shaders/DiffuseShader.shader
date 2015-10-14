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
     			   float4x4 modelMatrixInverse = _World2Object;
     				
                   o.pos = mul(UNITY_MATRIX_MVP,input.vertex);
                   o.uv_MainTex = input.texcoord.xy;
                   o.normal = normalize(float3(mul(float4(input.normal, 0.0), modelMatrixInverse)));
                   return o;
               }
               
               
               float4 frag(VertexOutput input):COLOR
               {
               	   float3 N = normalize(input.normal);
          		   float3 L = normalize(float3(_WorldSpaceLightPos0));
      
             	   // 材质对环境光的反射系数即材质的颜色分量
                   float3 Kd = tex2D(_MainTex,input.uv_MainTex).xyz;
               	 
               	  
               	   float3 diffuseColor = Kd * _LightColor0.rgb * max(0, dot(N, L));
               	   
               	   float3 ambientColor = Kd * _Ambient;
               	   
               	   return float4(diffuseColor + ambientColor, 1);
               }
               
              
               ENDCG
           }
       } 
       FallBack "Diffuse"
}