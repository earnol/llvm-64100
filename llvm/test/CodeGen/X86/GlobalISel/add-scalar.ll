; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-linux-gnu -global-isel -verify-machineinstrs < %s -o - | FileCheck %s --check-prefix=X64
; RUN: llc -mtriple=i386-linux-gnu   -global-isel -verify-machineinstrs < %s -o - | FileCheck %s --check-prefix=X86

define i128 @test_add_i128(i128 %arg1, i128 %arg2) nounwind {
; X64-LABEL: test_add_i128:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdx, %rax
; X64-NEXT:    addq %rdi, %rax
; X64-NEXT:    adcq %rsi, %rcx
; X64-NEXT:    movq %rcx, %rdx
; X64-NEXT:    retq
;
; X86-LABEL: test_add_i128:
; X86:       # %bb.0:
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    addl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl %ecx, (%eax)
; X86-NEXT:    movl %edx, 4(%eax)
; X86-NEXT:    movl %esi, 8(%eax)
; X86-NEXT:    movl %edi, 12(%eax)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    retl
  %ret = add i128 %arg1, %arg2
  ret i128 %ret
}

define i64 @test_add_i64(i64 %arg1, i64 %arg2) {
; X64-LABEL: test_add_i64:
; X64:       # %bb.0:
; X64-NEXT:    leaq (%rsi,%rdi), %rax
; X64-NEXT:    retq
;
; X86-LABEL: test_add_i64:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    retl
  %ret = add i64 %arg1, %arg2
  ret i64 %ret
}

define i32 @test_add_i32(i32 %arg1, i32 %arg2) {
; X64-LABEL: test_add_i32:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    leal (%rsi,%rdi), %eax
; X64-NEXT:    retq
;
; X86-LABEL: test_add_i32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    retl
  %ret = add i32 %arg1, %arg2
  ret i32 %ret
}

define i16 @test_add_i16(i16 %arg1, i16 %arg2) {
; X64-LABEL: test_add_i16:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    leal (%rsi,%rdi), %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: test_add_i16:
; X86:       # %bb.0:
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addw %cx, %ax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
  %ret = add i16 %arg1, %arg2
  ret i16 %ret
}

define i8 @test_add_i8(i8 %arg1, i8 %arg2) {
; X64-LABEL: test_add_i8:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    # kill: def $esi killed $esi def $rsi
; X64-NEXT:    leal (%rsi,%rdi), %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
;
; X86-LABEL: test_add_i8:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    addb %cl, %al
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
  %ret = add i8 %arg1, %arg2
  ret i8 %ret
}

define i32 @test_add_i1(i32 %arg1, i32 %arg2) {
; X64-LABEL: test_add_i1:
; X64:       # %bb.0:
; X64-NEXT:    cmpl %esi, %edi
; X64-NEXT:    sete %al
; X64-NEXT:    addb %al, %al
; X64-NEXT:    movzbl %al, %eax
; X64-NEXT:    andl $1, %eax
; X64-NEXT:    retq
;
; X86-LABEL: test_add_i1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    cmpl %eax, {{[0-9]+}}(%esp)
; X86-NEXT:    sete %al
; X86-NEXT:    addb %al, %al
; X86-NEXT:    movzbl %al, %eax
; X86-NEXT:    andl $1, %eax
; X86-NEXT:    retl
  %c = icmp eq i32 %arg1, %arg2
  %x = add i1 %c , %c
  %ret = zext i1 %x to i32
  ret i32 %ret
}
