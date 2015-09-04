Shader "Custom/Fur" {
    Properties {
        _MainTex ("Base (RGBA)", 2D) = "white" {}
        _FurLength ("Fur Length", Range(0.0, 1.0)) = 1.0
        _LayerIndex ("Layer Index", Float) = 0.0
    }

    SubShader {
        Tags { "RenderType" = "Opaque" }
        Blend SrcAlpha OneMinusSrcAlpha

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;
            uniform float _FurLength;
            uniform float _LayerIndex;

            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert(appdata_base v) {
                v2f o;
                float3 pos = v.vertex + v.normal * _FurLength * _LayerIndex;
                o.pos = mul(UNITY_MATRIX_MVP, float4(pos.xyz, 1));
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target {
                fixed4 c = tex2D(_MainTex, i.uv);
                clip(c.a == 0.0 ? -1.0 : 1.0);
                return c;
            }
            ENDCG
        }
    }
}
