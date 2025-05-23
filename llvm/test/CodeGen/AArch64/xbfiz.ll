; RUN: llc -mtriple=arm64-apple-ios < %s | FileCheck %s

define i64 @sbfiz64(i64 %v) {
; CHECK-LABEL: sbfiz64:
; CHECK: sbfiz	x0, x0, #1, #16
  %shl = shl i64 %v, 48
  %shr = ashr i64 %shl, 47
  ret i64 %shr
}

define i32 @sbfiz32(i32 %v) {
; CHECK-LABEL: sbfiz32:
; CHECK: sbfiz	w0, w0, #1, #14
  %shl = shl i32 %v, 18
  %shr = ashr i32 %shl, 17
  ret i32 %shr
}

define i64 @ubfiz64(i64 %v) {
; CHECK-LABEL: ubfiz64:
; CHECK: ubfiz	x0, x0, #36, #11
  %shl = shl i64 %v, 53
  %shr = lshr i64 %shl, 17
  ret i64 %shr
}

define i32 @ubfiz32(i32 %v) {
; CHECK-LABEL: ubfiz32:
; CHECK: ubfiz	w0, w0, #6, #24
  %shl = shl i32 %v, 8
  %shr = lshr i32 %shl, 2
  ret i32 %shr
}

define i64 @ubfiz64and(i64 %v) {
; CHECK-LABEL: ubfiz64and:
; CHECK: ubfiz	x0, x0, #36, #11
  %shl = shl i64 %v, 36
  %and = and i64 %shl, 140668768878592
  ret i64 %and
}

define i32 @ubfiz32and(i32 %v) {
; CHECK-LABEL: ubfiz32and:
; CHECK: ubfiz	w0, w0, #6, #24
  %shl = shl i32 %v, 6
  %and = and i32 %shl, 1073741760
  ret i32 %and
}

; Check that we don't generate a ubfiz if the lsl has more than one
; use, since we'd just be replacing an and with a ubfiz.
define i32 @noubfiz32(i32 %v) {
; CHECK-LABEL: noubfiz32:
; CHECK: lsl	w[[REG1:[0-9]+]], w0, #6
; CHECK: and	w[[REG2:[0-9]+]], w[[REG1]], #0x3fffffc0
; CHECK: add	w0, w[[REG1]], w[[REG2]]
; CHECK: ret
  %shl = shl i32 %v, 6
  %and = and i32 %shl, 1073741760
  %add = add i32 %shl, %and
  ret i32 %add
}

define i64 @lsl32_not_ubfiz64(i64 %v) {
; CHECK-LABEL: lsl32_not_ubfiz64:
; CHECK: lsl	w0, w0, #6
  %shl = shl i64 %v, 6
  %and = and i64 %shl, 4294967295
  ret i64 %and
}

define i64 @lsl_zext_i8_i64(i8 %b) {
; CHECK-LABEL: lsl_zext_i8_i64:
; CHECK:    ubfiz x0, x0, #1, #8
  %1 = zext i8 %b to i64
  %2 = shl i64 %1, 1
  ret i64 %2
}

define i64 @lsl_zext_i16_i64(i16 %b) {
; CHECK-LABEL: lsl_zext_i16_i64:
; CHECK:    ubfiz x0, x0, #1, #16
  %1 = zext i16 %b to i64
  %2 = shl i64 %1, 1
  ret i64 %2
}

; Regression test for:
; https://github.com/llvm/llvm-project/pull/118974#issuecomment-2598521878
; that exposed infinite loop in DAGCombiner.
define void @_f(ptr %0, ptr %1, i64 %2) {
; CHECK-LABEL: @_f
; CHECK-NOT: ubfiz
  store i64 -2401053089408754003, ptr %1, align 8
  %4 = and i64 %2, -2401053089408754003
  %5 = shl i64 %4, 1
  store i64 %5, ptr %0, align 1
  %6 = lshr i64 %4, 54
  %7 = shl i64 %2, 10
  %8 = and i64 %7, 131072
  %9 = or i64 %8, %6
  store i64 %9, ptr %1, align 1
  ret void
}
