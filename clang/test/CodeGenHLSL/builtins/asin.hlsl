// RUN: %clang_cc1 -finclude-default-header -x hlsl -triple \
// RUN:   dxil-pc-shadermodel6.3-library %s -fnative-half-type \
// RUN:   -emit-llvm -disable-llvm-passes -o - | FileCheck %s \ 
// RUN:   --check-prefixes=CHECK,NATIVE_HALF
// RUN: %clang_cc1 -finclude-default-header -x hlsl -triple \
// RUN:   spirv-unknown-vulkan-compute %s -emit-llvm -disable-llvm-passes \
// RUN:   -o - | FileCheck %s --check-prefixes=CHECK,NO_HALF

// CHECK-LABEL: test_asin_half
// NATIVE_HALF: call reassoc nnan ninf nsz arcp afn half @llvm.asin.f16
// NO_HALF: call reassoc nnan ninf nsz arcp afn float @llvm.asin.f32
half test_asin_half ( half p0 ) {
  return asin ( p0 );
}

// CHECK-LABEL: test_asin_half2
// NATIVE_HALF: call reassoc nnan ninf nsz arcp afn <2 x half> @llvm.asin.v2f16
// NO_HALF: call reassoc nnan ninf nsz arcp afn <2 x float> @llvm.asin.v2f32
half2 test_asin_half2 ( half2 p0 ) {
  return asin ( p0 );
}

// CHECK-LABEL: test_asin_half3
// NATIVE_HALF: call reassoc nnan ninf nsz arcp afn <3 x half> @llvm.asin.v3f16
// NO_HALF: call reassoc nnan ninf nsz arcp afn <3 x float> @llvm.asin.v3f32
half3 test_asin_half3 ( half3 p0 ) {
  return asin ( p0 );
}

// CHECK-LABEL: test_asin_half4
// NATIVE_HALF: call reassoc nnan ninf nsz arcp afn <4 x half> @llvm.asin.v4f16
// NO_HALF: call reassoc nnan ninf nsz arcp afn <4 x float> @llvm.asin.v4f32
half4 test_asin_half4 ( half4 p0 ) {
  return asin ( p0 );
}

// CHECK-LABEL: test_asin_float
// CHECK: call reassoc nnan ninf nsz arcp afn float @llvm.asin.f32
float test_asin_float ( float p0 ) {
  return asin ( p0 );
}

// CHECK-LABEL: test_asin_float2
// CHECK: call reassoc nnan ninf nsz arcp afn <2 x float> @llvm.asin.v2f32
float2 test_asin_float2 ( float2 p0 ) {
  return asin ( p0 );
}

// CHECK-LABEL: test_asin_float3
// CHECK: call reassoc nnan ninf nsz arcp afn <3 x float> @llvm.asin.v3f32
float3 test_asin_float3 ( float3 p0 ) {
  return asin ( p0 );
}

// CHECK-LABEL: test_asin_float4
// CHECK: call reassoc nnan ninf nsz arcp afn <4 x float> @llvm.asin.v4f32
float4 test_asin_float4 ( float4 p0 ) {
  return asin ( p0 );
}
